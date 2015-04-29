From: Bram Bos <buramu@gmail.com>
Subject: Simple Mixer help
Date: Wed, 29 Apr 2015 16:15:46 +0200
Message-ID: <CAPaK8bb7mvNjf-EwEciBQth68hRWvXEE5cwAqUdRBk5QcXRqYw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f46.google.com (mail-oi0-f46.google.com
 [209.85.218.46])
 by alsa0.perex.cz (Postfix) with ESMTP id DC5B226058F
 for <alsa-devel@alsa-project.org>; Wed, 29 Apr 2015 16:15:49 +0200 (CEST)
Received: by oign205 with SMTP id n205so22474405oig.2
 for <alsa-devel@alsa-project.org>; Wed, 29 Apr 2015 07:15:46 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I want to get access to the ALSA Simple Mixer interface, but rather than
the 'default' sound device I want to target a specific USB sound device.

I'm at a loss how to refer to it...  I am using a modified version of the
code below but I have no idea what to replace the "card" and "selem_name"
strings with. The device name? The 'hwX.Y' string?

And do I need to change the index#?

Too many variables to solve this by trial and error.
Any hints appreciated!

void SetAlsaMasterVolume(long volume){
    long min, max;
    snd_mixer_t *handle;
    snd_mixer_selem_id_t *sid;
    const char *card = "default";
    const char *selem_name = "Master";

    snd_mixer_open(&handle, 0);
    snd_mixer_attach(handle, card);
    snd_mixer_selem_register(handle, NULL, NULL);
    snd_mixer_load(handle);

    snd_mixer_selem_id_alloca(&sid);
    snd_mixer_selem_id_set_index(sid, 0);
    snd_mixer_selem_id_set_name(sid, selem_name);
    snd_mixer_elem_t* elem = snd_mixer_find_selem(handle, sid);

    snd_mixer_selem_get_playback_volume_range(elem, &min, &max);
    snd_mixer_selem_set_playback_volume_all(elem, volume * max / 100);

    snd_mixer_close(handle);}
