From: Mike Gorse <mgorse@mgorse.dhs.org>
Subject: [patch] snd_pcm_drain and lock-ups
Date: Wed, 19 Sep 2007 20:54:07 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0709192041310.7949@mgorse.dhs.org>
References: <Pine.LNX.4.64.0709121739280.26129@mgorse.dhs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from alnrmhc12.comcast.net (alnrmhc12.comcast.net [204.127.225.92])
	by alsa0.perex.cz (Postfix) with ESMTP id EDCBE24624
	for <alsa-devel@alsa-project.org>;
	Thu, 20 Sep 2007 02:53:15 +0200 (CEST)
In-Reply-To: <Pine.LNX.4.64.0709121739280.26129@mgorse.dhs.org>
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

Hi again,

I posted last week because I am getting lockups when portaudio calls 
snd_pcm_drain, and snd_pcm_rate_drain calls snd_pcm_wait on its slave.

Now that I've looked at this more, I'm seeing that it involves dmix, since 
a dmix plugin is behind the rate plugin.

The dmix code in alsa-lib is setting a xrun state because 
snd_pcm_mmap_playback_avail returns a large value.

snd_pcm_wait is then called on the slave of the rate pcm, which is a pcm 
with a type of SND_PCM_TYPE_ROUTE whose slave is the dmix, but the route 
pcm is returning a different value for snd_pcm_mmap_avail than the dmix 
pcm, so it is not triggering snd_pcm_wait to check for a xrun.

The following patch stops snd_pcm_wait from locking up for me, although 
I'm not sure if it is the best way of handling things:

--- src/pcm/pcm.c.orig	2007-09-12 05:20:32.000000000 -0400
+++ src/pcm/pcm.c	2007-09-19 19:52:10.000000000 -0400
@@ -2255,7 +2255,7 @@
   */
  int snd_pcm_wait(snd_pcm_t *pcm, int timeout)
  {
-	if (snd_pcm_mmap_avail(pcm) >= pcm->avail_min) {
+	if (snd_pcm_mmap_avail(pcm) >= pcm->avail_min || pcm->type == SND_PCM_TYPE_ROUTE) {
  		/* check more precisely */
  		switch (snd_pcm_state(pcm)) {
  		case SND_PCM_STATE_XRUN:

Thanks,
-- Mike Gorse / AIM:linvortex / http://mgorse.freeshell.org --
