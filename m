From: Ciaccia <ciacciax@yahoo.com>
Subject: Re: Endiannes and alsa (in an embedded device)
Date: Tue, 1 May 2007 14:45:17 -0700 (PDT)
Message-ID: <597229.81223.qm@web31001.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from web31001.mail.mud.yahoo.com (web31001.mail.mud.yahoo.com
	[68.142.200.164]) by alsa0.perex.cz (Postfix) with SMTP id 511FF24179
	for <alsa-devel@alsa-project.org>;
	Tue,  1 May 2007 23:45:20 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ciaccia <ciacciax@yahoo.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Forget about that, it took 4 hours but I understood why it was not working...

Since I'm working with 24bit resolution (and not 16 as I usually do), the samples were to little... Now I replaced the sin line with:

sample = (int)(4000000.0f * sin((float)i * 2.0f * M_PI / (512.0f / 50.0f)));

and it's working fine. I really thought it was too strange to be true...
Sorry for the spam :-|
Andrea

----- Original Message ----
From: Ciaccia <ciacciax@yahoo.com>
To: alsa-devel@alsa-project.org
Sent: Tuesday, May 1, 2007 8:49:18 PM
Subject: [alsa-devel] Endiannes and alsa (in an embedded device)

Dear all,
I have a question that really puzzles me, I wonder if someone can explain to me what I'm doing wrong... :-|

I have programmed an ALSA driver for an embedded device, everything works fine and all the application use my driver without any glitches. The snd_pcm_hardware for this device is defined as following:

static const struct snd_pcm_hardware ep93xx_pcm_hardware = {
    .info= SNDRV_PCM_INFO_MMAP |
            SNDRV_PCM_INFO_MMAP_VALID |
            SNDRV_PCM_INFO_INTERLEAVED |
            SNDRV_PCM_INFO_BLOCK_TRANSFER,
    .rates =            SNDRV_PCM_RATE_8000_48000,
    .rate_min =         8000,
    .rate_max =         48000,
    .channels_min =     2,
    .channels_max =     2,
    .formats = SNDRV_PCM_FMTBIT_S24_LE,
    .buffer_bytes_max = 131072,
    .period_bytes_min = 512,
    .period_bytes_max = 32768,
    .periods_min = 1,
    .periods_max = MAX_PERIODS,
    .fifo_size = 32,
};

Then I tried to program a test application that uses the hardware device directly (without using alsa-lib to convert the format and so on). I open the device as following:

if ((err = snd_pcm_open (&playback_handle, "hw:0,0", SND_PCM_STREAM_PLAYBACK, 0)) < 0) {

Everything works fine until I try to write data to the stream. I tried both SND_PCM_ACCESS_RW_INTERLEAVED and SND_PCM_ACCESS_MMAP_INTERLEAVED, but I always have the following problem.

When I want to write data to the stream, I have to "reverse" the byte order, otherwise I hear noise on the speaker. The system I am working on is little-endian (it has cirrus ep93xx arm core), so I assume I could write data directly to the buffer. Here is what I have to do:

// fill the buffer
for (i = 0; i < 512; i++) {
    int sample = (int)(20000.0f * sin((float)i * 2.0f * M_PI / 512.0f));
    int reversed;
    char *src = (char *)(&sample);
    char *dst = (char *)(&reversed);
    dst[0] = src[3];
    dst[1] = src[2];

    dst[2] = src[1];

    dst[3] = src[0];
    *(buffer++) = reversed;
    *(buffer++) = reversed;
}

It this normal? I thought that since the system is little-endian and the format of the driver is S24_LE, I could copy the data directly to the stream (either using snd_pcm_writei or snd_pcm_mmap_begin).



I think the driver is ok, since all the applications run with no problem at all. Can someone explain to me how/why the applications such as aplay/arecord work ok?

Every help is greatly appreciated
Thanks in advance
Andrea


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel




__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
