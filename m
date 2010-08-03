From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Rates/formats available upstream from the plug
 plugin
Date: Tue, 3 Aug 2010 15:44:33 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1008031542320.4068@eeebox2.perex-int.cz>
References: <4C5815E6.9010803@ivitera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 1F1BC2449B
	for <alsa-devel@alsa-project.org>;
	Tue,  3 Aug 2010 15:44:35 +0200 (CEST)
In-Reply-To: <4C5815E6.9010803@ivitera.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Pavel Hofman <pavel.hofman@ivitera.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 3 Aug 2010, Pavel Hofman wrote:

> Hi,
>
> mplayer checks hw_params for availability of the current format
> http://mplayer-ww.git.sourceforge.net/git/gitweb.cgi?p=mplayer-ww/mplayer-ww;a=blob;f=libao2/ao_alsa.c;h=57f0bd07cb5ec300d327682a0b5209ba9dc10e30;hb=09ab9f6346aaf15d20792ca3df761a45fe46d83d#l514
> . If the check fails, it uses 16bits as fixed default.
>
> Now if we define the card to be plughw:0, the check still fails for
> formats unsupported directly by the card. Which in fact is incorrect
> since the plug plugin takes care of most formats known. The same holds
> for sample rates.

It works for me:

perex@eeebox2:~/alsa/alsa-lib/test> ./pcm
Playback device is plughw:0,0
Stream parameters are 44100Hz, S16_LE, 1 channels
Sine wave rate is 440.0000Hz
Using transfer method: write
test format float_le: 0
test format mpeg: -22

Using modified alsa-lib/test/pcm.c code:

diff --git a/test/pcm.c b/test/pcm.c
index abb83e4..0582891 100644
--- a/test/pcm.c
+++ b/test/pcm.c
@@ -106,6 +106,8 @@ static int set_hwparams(snd_pcm_t *handle,
  		printf("Broken configuration for playback: no configurations available: %s\n", snd_strerror(err));
  		return err;
  	}
+	printf("test format float_le: %i\n", snd_pcm_hw_params_test_format(handle, params, SND_PCM_FORMAT_FLOAT_LE));
+	printf("test format mpeg: %i\n", snd_pcm_hw_params_test_format(handle, params, SND_PCM_FORMAT_MPEG));
  	/* set hardware resampling */
  	err = snd_pcm_hw_params_set_rate_resample(handle, params, resample);
  	if (err < 0) {


Could you describe you hw configuration or can you reproduce this issue 
with the snd-dummy module?

 					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
