From: Sedji Gaouaou <sedji.gaouaou@atmel.com>
Subject: Recording problem with ALSA: trying to set up some
	constraints
Date: Thu, 22 May 2008 11:33:34 +0200
Message-ID: <48353DEE.1020502@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from atmel-es2.atmel.fr (mail.atmel.fr [81.80.104.162])
	by alsa0.perex.cz (Postfix) with ESMTP id 6A74D24784
	for <alsa-devel@alsa-project.org>;
	Thu, 22 May 2008 11:33:39 +0200 (CEST)
Received: from fwat.rfo.atmel.com (gateway [192.168.1.1])
	by atmel-es2.atmel.fr (8.11.6+Sun/8.11.6) with SMTP id m4M9NMZ05464
	for <alsa-devel@alsa-project.org>;
	Thu, 22 May 2008 11:23:23 +0200 (MEST)
Received: from [127.0.0.1] ([10.159.245.197])
	by meyreuil.atmel.fr (8.11.7p1+Sun/8.11.7) with ESMTP id m4M9XWr10615
	for <alsa-devel@alsa-project.org>;
	Thu, 22 May 2008 11:33:32 +0200 (MEST)
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


I have a problem with my recording driver.
I have set up a pcm_hardware structure in which I define the format 
supported by my hardware:

static struct snd_pcm_hardware snd_at91_ac97_capture_hw = {
    .info            = (SNDRV_PCM_INFO_INTERLEAVED
                   | SNDRV_PCM_INFO_MMAP
                   | SNDRV_PCM_INFO_MMAP_VALID
                                   | SNDRV_PCM_INFO_BLOCK_TRANSFER),
    .formats        = (SNDRV_PCM_FMTBIT_S16_LE
                   | SNDRV_PCM_FMTBIT_S16_BE
                   | SNDRV_PCM_FMTBIT_S20_3LE
                   | SNDRV_PCM_FMTBIT_U20_3LE
                   | SNDRV_PCM_FMTBIT_S20_3BE
                   | SNDRV_PCM_FMTBIT_U20_3BE
                   | SNDRV_PCM_FMTBIT_S18_3LE
                   | SNDRV_PCM_FMTBIT_U18_3LE
                   | SNDRV_PCM_FMTBIT_S18_3BE
                   | SNDRV_PCM_FMTBIT_U18_3BE),
    .rates            = SNDRV_PCM_RATE_CONTINUOUS,
    .rate_min        = 8000,
    .rate_max        = 48000,
    .channels_min        = 1,
    .channels_max        = 2,
    .buffer_bytes_max    = 256*1024,
    .period_bytes_min    = 1024,
    .period_bytes_max    = 4*1024,
    .periods_min        = 1,
    .periods_max        = 64,
};

Then in my open function I pass it to the runtime struct.

Nevertheless if  I try to run arecord with this option: arecord -d 1 
test.wav, I will have a kernel oops.
The default format is U8, but it is not supported by my Hardware, abd it 
is not defined in my structure, so I though that it should exit arecord 
but not crash.

Do I miss something when defining my pcm_hardware strucutre, or do I 
forgot to use a specific function which should return me an error?

I have try to set up some constraints as well(for the rate and the 
format), but still I have the same crash.


Regards,
Sedji
