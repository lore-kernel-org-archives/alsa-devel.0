From: Giuliano Pochini <pochini@shiny.it>
Subject: Re: snd-powermac produces only low quality dirty sound
Date: Wed, 15 Dec 2004 11:32:55 +0100
Message-ID: <20041215113255.429b83c1.pochini@shiny.it>
References: <20041214213549.GA22308@suse.de>
	<XFMail.20041215111002.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from denise.shiny.it (denise.shiny.it [194.20.232.1])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 7FF7728E
	for <alsa-devel@alsa-project.org>; Wed, 15 Dec 2004 11:32:49 +0100 (MET)
In-Reply-To: <XFMail.20041215111002.pochini@shiny.it>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Olaf Hering <olh@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, 15 Dec 2004 11:10:02 +0100 (CET)
Giuliano Pochini <pochini@shiny.it> wrote:

> > All 2.6 versions I tried so far produce only "dirty" low quality sound
> > when playing mp3 with xmms with either the alsa or oss plugin.
> > But it works as expected when I use dmasound_pmac and the liboss plugin.
> >
> > Any ideas how to debug it?
>
> It seems that the chip is not happy with some period/buffer sizes.
> Someone was trying to find the right constraints to set for those
> parameters. Maybe the attached patch fixes it (untested).


Uffff, that stupid program wrapped long lines.


--- alsa-kernel/ppc/pmac.c__	Wed Dec 15 10:15:37 2004
+++ alsa-kernel/ppc/pmac.c	Wed Dec 15 10:37:15 2004
@@ -538,6 +538,11 @@
 	runtime->private_data = rec;
 	rec->substream = subs;
 
+	if ((i = snd_pcm_hw_constraint_pow2(runtime, 0, SNDRV_PCM_HW_PARAM_PERIOD_SIZE)) < 0)
+		return i;
+	if ((i = snd_pcm_hw_constraint_pow2(runtime, 0, SNDRV_PCM_HW_PARAM_BUFFER_SIZE)) < 0)
+		return i;
+
 #if 0 /* FIXME: still under development.. */
 	snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
 			    snd_pmac_hw_rule_rate, chip, rec->stream, -1);




-- 
Giuliano.


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
