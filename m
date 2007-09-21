From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: [patch] snd_pcm_drain and lock-ups
Date: Fri, 21 Sep 2007 10:15:09 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0709211009490.8148@tm8103.perex-int.cz>
References: <Pine.LNX.4.64.0709121739280.26129@mgorse.dhs.org>
	<Pine.LNX.4.64.0709192041310.7949@mgorse.dhs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id DDCEF2433C
	for <alsa-devel@alsa-project.org>;
	Fri, 21 Sep 2007 10:15:09 +0200 (CEST)
In-Reply-To: <Pine.LNX.4.64.0709192041310.7949@mgorse.dhs.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mike Gorse <mgorse@mgorse.dhs.org>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wed, 19 Sep 2007, Mike Gorse wrote:

> Hi again,
> 
> I posted last week because I am getting lockups when portaudio calls 
> snd_pcm_drain, and snd_pcm_rate_drain calls snd_pcm_wait on its slave.
> 
> Now that I've looked at this more, I'm seeing that it involves dmix, since 
> a dmix plugin is behind the rate plugin.
> 
> The dmix code in alsa-lib is setting a xrun state because 
> snd_pcm_mmap_playback_avail returns a large value.
> 
> snd_pcm_wait is then called on the slave of the rate pcm, which is a pcm 
> with a type of SND_PCM_TYPE_ROUTE whose slave is the dmix, but the route 
> pcm is returning a different value for snd_pcm_mmap_avail than the dmix 
> pcm, so it is not triggering snd_pcm_wait to check for a xrun.
> 
> The following patch stops snd_pcm_wait from locking up for me, although 
> I'm not sure if it is the best way of handling things:
> 
> --- src/pcm/pcm.c.orig	2007-09-12 05:20:32.000000000 -0400
> +++ src/pcm/pcm.c	2007-09-19 19:52:10.000000000 -0400
> @@ -2255,7 +2255,7 @@
>    */
>   int snd_pcm_wait(snd_pcm_t *pcm, int timeout)
>   {
> -	if (snd_pcm_mmap_avail(pcm) >= pcm->avail_min) {
> +	if (snd_pcm_mmap_avail(pcm) >= pcm->avail_min || pcm->type == SND_PCM_TYPE_ROUTE) {
>   		/* check more precisely */
>   		switch (snd_pcm_state(pcm)) {
>   		case SND_PCM_STATE_XRUN:

I think that better fix is to change the code in snd_pcm_rate_drain(). You 
can set avail_min to 1 there, so condition in snd_pcm_wait() will match.

Does this patch help?

diff -r 68d71239d651 src/pcm/pcm_rate.c
--- a/src/pcm/pcm_rate.c	Thu Sep 20 13:20:03 2007 +0200
+++ b/src/pcm/pcm_rate.c	Fri Sep 21 10:14:41 2007 +0200
@@ -1076,10 +1076,10 @@ static int snd_pcm_rate_drain(snd_pcm_t 
 		snd_pcm_uframes_t size, ofs, saved_avail_min;
 		snd_pcm_sw_params_t sw_params;
 
-		/* temporarily set avail_min to one period */
+		/* temporarily set avail_min to one */
 		sw_params = rate->sw_params;
 		saved_avail_min = sw_params.avail_min;
-		sw_params.avail_min = rate->gen.slave->period_size;
+		sw_params.avail_min = 1;
 		snd_pcm_sw_params(rate->gen.slave, &sw_params);
 
 		size = rate->appl_ptr - rate->last_commit_ptr;

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs
