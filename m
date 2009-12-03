From: "Chaithrika U S" <chaithrika@ti.com>
Subject: Re: [PATCH] ASoC: DaVinci: Update suspend/resume
	support	for McASP driver
Date: Thu, 3 Dec 2009 17:58:08 +0530
Message-ID: <000301ca7414$12280120$36780360$@com>
References: <1259737740-27324-1-git-send-email-chaithrika@ti.com>
	<s5hskbtybeg.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
	by alsa0.perex.cz (Postfix) with ESMTP id 7B2B62442A
	for <alsa-devel@alsa-project.org>; Thu,  3 Dec 2009 13:30:46 +0100 (CET)
In-Reply-To: <s5hskbtybeg.wl%tiwai@suse.de>
Content-Language: en-us
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: 'Takashi Iwai' <tiwai@suse.de>
Cc: khilman@deeprootsystems.com, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, davinci-linux-open-source@linux.davincidsp.com
List-Id: alsa-devel@alsa-project.org

On Wed, Dec 02, 2009 at 14:56:31, Takashi Iwai wrote:
> At Wed,  2 Dec 2009 12:39:00 +0530,
> Chaithrika U S wrote:
> > 
> > diff --git a/sound/soc/davinci/davinci-pcm.c b/sound/soc/davinci/davinci-pcm.c
> > index ad4d7f4..80c7fdf 100644
> > --- a/sound/soc/davinci/davinci-pcm.c
> > +++ b/sound/soc/davinci/davinci-pcm.c
> > @@ -49,7 +49,7 @@ static void print_buf_info(int slot, char *name)
> >  static struct snd_pcm_hardware pcm_hardware_playback = {
> >  	.info = (SNDRV_PCM_INFO_INTERLEAVED | SNDRV_PCM_INFO_BLOCK_TRANSFER |
> >  		 SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_MMAP_VALID |
> > -		 SNDRV_PCM_INFO_PAUSE),
> > +		 SNDRV_PCM_INFO_PAUSE | SNDRV_PCM_INFO_RESUME),
> 
> Note that unless your driver supports the "full" resume,
> SNDRV_PCM_INFO_RESUME shouldn't be set.  Here, the "full" resume means
> that the hardware gets back to a completely sane state and the PCM
> streams are resumed without extra PCM prepare call at PM resume.
> If the PCM (or whatever) needs another re-initialization (like in many
> cases), don't set this flag.
> 
> Just to be sure...
> 
> 
> Takashi
> 

PCM prepare call is not needed in this case. Testing was done with audio
loopback and after a suspend/resume cycle the audio output was proper. Hope
my understanding is correct. Is this test sufficient to prove that driver
supports full resume?

Regards, 
Chaithrika
