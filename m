From: Giuliano Pochini <pochini@shiny.it>
Subject: RE: snd-powermac produces only low quality dirty so
Date: Wed, 15 Dec 2004 11:10:02 +0100 (CET)
Message-ID: <XFMail.20041215111002.pochini@shiny.it>
References: <20041214213549.GA22308@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="_=XFMail.1.4.7.Linux:20041215111002:3126=_"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from denise.shiny.it (denise.shiny.it [194.20.232.1])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 2F66225D
	for <alsa-devel@alsa-project.org>; Wed, 15 Dec 2004 11:10:08 +0100 (MET)
In-Reply-To: <20041214213549.GA22308@suse.de>
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

This message is in MIME format
--_=XFMail.1.4.7.Linux:20041215111002:3126=_
Content-Type: text/plain; charset=us-ascii


On 14-Dec-2004 Olaf Hering wrote:

> All 2.6 versions I tried so far produce only "dirty" low quality sound
> when playing mp3 with xmms with either the alsa or oss plugin.
> But it works as expected when I use dmasound_pmac and the liboss plugin.
>
> Any ideas how to debug it?

It seems that the chip is not happy with some period/buffer sizes.
Someone was trying to find the right constraints to set for those
parameters. Maybe the attached patch fixes it (untested).



--
Giuliano.

--_=XFMail.1.4.7.Linux:20041215111002:3126=_
Content-Disposition: attachment; filename="pmac.patch"
Content-Transfer-Encoding: none
Content-Type: text/plain; charset=us-ascii; name=pmac.patch; SizeOnDisk=549

--- alsa-kernel/ppc/pmac.c__	Wed Dec 15 10:15:37 2004
+++ alsa-kernel/ppc/pmac.c	Wed Dec 15 10:37:15 2004
@@ -538,6 +538,11 @@
 	runtime->private_data = rec;
 	rec->substream = subs;
 
+	if ((i = snd_pcm_hw_constraint_pow2(runtime, 0, SNDRV_PCM_HW_PARAM_PERIOD_SIZE
)) < 0)
+		return i;
+	if ((i = snd_pcm_hw_constraint_pow2(runtime, 0, SNDRV_PCM_HW_PARAM_BUFFER_SIZE
)) < 0)
+		return i;
+
 #if 0 /* FIXME: still under development.. */
 	snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
 			    snd_pmac_hw_rule_rate, chip, rec->stream, -1);

--_=XFMail.1.4.7.Linux:20041215111002:3126=_--
End of MIME message


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
