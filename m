From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [alsa-cvslog] alsa-kernel: Official ALSA project
 GIT repository for Linux 2.6 branch, master now at v2.6.27-rc3-74-g027ee62
Date: Fri, 15 Aug 2008 13:00:39 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0808151254380.21669@tm8103-a.perex-int.cz>
References: <20080815103920.39D00245AF@alsa0.perex.cz>
	<s5hvdy2y2s6.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id E76E6245A1
	for <alsa-devel@alsa-project.org>;
	Fri, 15 Aug 2008 13:00:45 +0200 (CEST)
In-Reply-To: <s5hvdy2y2s6.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Fri, 15 Aug 2008, Takashi Iwai wrote:

> At Fri, 15 Aug 2008 12:39:19 +0200 (CEST),
> noreply-git@alsa-project.org wrote:
> > 
> > @@ -362,10 +363,8 @@ static int snd_card_dummy_playback_open(struct snd_pcm_substream *substream)
> >  	}
> >  	if (substream->pcm->device & 2)
> >  		runtime->hw.info &= ~(SNDRV_PCM_INFO_MMAP|SNDRV_PCM_INFO_MMAP_VALID);
> > -	if ((err = add_playback_constraints(runtime)) < 0) {
> > -		kfree(dpcm);
> > +	if ((err = add_playback_constraints(runtime)) < 0)
> >  		return err;
> > -	}
> 
> Run checkpatch.pl please...

The patch conformed to coding style in dummy.c. I commited new patch on 
top of this patch to remove (almost all) assignments in if conditions..

						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
