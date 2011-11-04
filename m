From: Anders Gnistrup <agn@datarespons.dk>
Subject: need some workarround or explanation.
Date: Fri, 4 Nov 2011 09:50:36 +0100
Message-ID: <C516192DA6D2B74F8192CDC209D958FD5832E6F17F@dr-mail>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailgw01.datarespons.com (mailgw01.datarespons.com
	[81.0.189.39]) by alsa0.perex.cz (Postfix) with ESMTP id E1B9A24771
	for <alsa-devel@alsa-project.org>; Fri,  4 Nov 2011 09:50:38 +0100 (CET)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hello

I have a USB headset, where when plugged in, a volume setting is set on playback and capture channels using the ctl interface for the device.
After the volume is set I open the capture interface. but I have i have a 2-3 sec. delay that i just don't understand.

I might need to use another solution, but these are difficult to find.
The Headset is a plantronics.

The code is listed below.

#include <alsa/asoundlib.h>

#define qDebug printf
void set_default_volume(const char *a_hw_dev, int a_percent)
{
    int err;
    snd_mixer_t *handle;
    snd_mixer_selem_id_t *sid;
    snd_mixer_elem_t *elem;
    snd_mixer_selem_id_alloca(&sid);

    if ((err = snd_mixer_open(&handle, 0)) < 0)
    {
        qDebug("Mixer open error: %s\n", snd_strerror(err));
        return;
    }
    if ((err = snd_mixer_attach(handle, a_hw_dev)) < 0)
    {
        qDebug("Mixer attach %s error: %s\n", a_hw_dev, snd_strerror(err));
        snd_mixer_close(handle);
        return;
    }
    if ((err = snd_mixer_selem_register(handle, NULL, NULL)) < 0)
    {
        qDebug("Mixer register error: %s\n", snd_strerror(err));
        snd_mixer_close(handle);
        return;
    }
    err = snd_mixer_load(handle);
    if (err < 0)
    {
        qDebug("Mixer %s load error: %s\n", a_hw_dev, snd_strerror(err));
        snd_mixer_close(handle);
        return;
    }
    for (elem = snd_mixer_first_elem(handle); elem; elem = snd_mixer_elem_next(elem))
    {
        snd_mixer_selem_get_id(elem, sid);
        qDebug("Simple mixer control '%s',%i\n", snd_mixer_selem_id_get_name(sid), snd_mixer_selem_id_get_index(sid));

        if (snd_mixer_selem_has_playback_switch(elem))
        {
            snd_mixer_selem_set_playback_switch_all(elem, 1); //unmute
        }

        if (snd_mixer_selem_has_playback_volume(elem))
        {
            long min, max;
            snd_mixer_selem_get_playback_volume_range(elem, &min, &max);
            qDebug(" pvolume %ld/%ld\n", min , max);
            snd_mixer_selem_set_playback_volume_all(elem, (a_percent * (max-min))/100);
        }

        if (snd_mixer_selem_has_capture_switch(elem))
        {
            snd_mixer_selem_set_capture_switch_all(elem, 1); // unmute all
        }
        if (snd_mixer_selem_has_capture_volume(elem))
        {
            long min, max;
            snd_mixer_selem_get_capture_volume_range(elem, &min, &max);
            qDebug(" pvolume %ld/%ld\n", min , max);
            snd_mixer_selem_set_capture_volume_all(elem,  (a_percent * (max-min))/100); //set capture volume for all
        }
    }
    snd_mixer_close(handle);
    return;
}

int main(int argc, char *argv[])
{
    snd_pcm_t *m_pcm_handle;

    int err,count;
    // Open connection to the PCM devic
    if ((err = snd_pcm_open(&m_pcm_handle, "plughw:1,0", SND_PCM_STREAM_CAPTURE, 0)) < 0)
    {
        for (count=0; count < 5 && err == -EBUSY; count++)
        {
            sleep(1);
            qDebug("AlsaStream:%d open error: %s (%d)\n ", __LINE__, snd_strerror(err), err);
            err = snd_pcm_open(&m_pcm_handle, "plughw:1,0", SND_PCM_STREAM_CAPTURE, 0);
        }

        if (err < 0)
        {
            qDebug("AlsaStream:%d open error: %s (%d)\n ", __LINE__, snd_strerror(err), err);
            return;
        }
        if (err>= 0)
        {
            printf("Success\n");
        }
    }
    set_default_volume("hw:1", 20);
    snd_pcm_close(m_pcm_handle);
    return 0;
}
