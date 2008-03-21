From: "Pharaoh ." <pharaoh137@gmail.com>
Subject: Accessing pcm samples from snd_pcm_channel_area_t in
	an io type plugin
Date: Thu, 20 Mar 2008 18:46:54 -0700
Message-ID: <61445c750803201846y1aad7b18m776ccbf3e76dd8f7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.233])
	by alsa0.perex.cz (Postfix) with ESMTP id 7E15C24455
	for <alsa-devel@alsa-project.org>; Fri, 21 Mar 2008 02:46:56 +0100 (CET)
Received: by wx-out-0506.google.com with SMTP id t11so1646648wxc.23
	for <alsa-devel@alsa-project.org>; Thu, 20 Mar 2008 18:46:55 -0700 (PDT)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

I am writing an external io type plugin for an ARM based board. In the
transfer function
of the plugin, I try to grab the audio samples in a temp buffer and send it
to the DSP in
chunks of period sizes. Somehow the the alsa buffer's audio samples are not
copied to the
temp buffer which I want to send further.

What I do to copy the buffers,
static snd_pcm_sframes_t my_transfer(snd_pcm_ioplug_t *io,
                   const snd_pcm_channel_area_t *areas,
                   snd_pcm_uframes_t offset,
                   snd_pcm_uframes_t size)
{

    char *temp = NULL;
    temp = malloc(io->period_size * frame_size);  //For malloc,

    //I tried all the three approaches here one by one, including the
malloc/memcpy one
    1. memcpy(temp,areas->addr+ offset*io->channels*2, io->period_size *
frame_size);
    2. memcpy(temp, (char *)areas->addr + (areas->first + areas->step *
offset) /8, io->period_size * frame_size);
    //This should work straight off....
    3. temp = (char *)areas->addr + (areas->first + areas->step * offset) /
8;

    //write temp to DSP here
    .........
}

Somehow the empty buffers are being sent to DSP, when I try to send some
data from a static array then it goes
to DSP and is played well. Any idea what I am missing?

-phraoh.
