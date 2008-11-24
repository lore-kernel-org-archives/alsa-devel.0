From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: [topic/asoc][RFC 0/1] ASoC: OMAP: Add support for mono
	link configuration to McBSP DAI
Date: Mon, 24 Nov 2008 15:09:23 +0200
Message-ID: <1227532164-2612-1-git-send-email-jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id D33CE243EA
	for <alsa-devel@alsa-project.org>; Mon, 24 Nov 2008 14:09:48 +0100 (CET)
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id
	mAOD9B4r003535
	for <alsa-devel@alsa-project.org>; Mon, 24 Nov 2008 07:09:46 -0600
Received: from localhost.localdomain (esdhcp042162.research.nokia.com
	[172.21.42.162])
	by mgw-int01.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id
	mAOD9d8Y005400
	for <alsa-devel@alsa-project.org>; Mon, 24 Nov 2008 15:09:39 +0200
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

Hi

I'm trying to cover also pure mono codecs like bluetooth audio with McBSP DAI
driver. Protocol part is trivial like patch here but interfacing with machine
driver is somewhat question mark.

With this patch, machine driver needs to "hack" with cpu_dai in its init
function:

	cpu_dai->playback.channels_min = 1;
	cpu_dai->playback.channels_max = 1;
	cpu_dai->capture.channels_min = 1;
	cpu_dai->capture.channels_max = 1;

Another idea is to introduce new omap_mcbsp_dai_mono[] array in omap-mcbsp.c
and initialize those with modified builder macro, e.g:

-#define OMAP_MCBSP_DAI_BUILDER(link_id)				\
+#define OMAP_MCBSP_DAI_BUILDER(link_id, min_ch, max_ch)		\
 {								\
 	.name = "omap-mcbsp-dai-"#link_id,			\
 	.id = (link_id),					\
 	.type = SND_SOC_DAI_I2S,				\
 	.playback = {						\
-		.channels_min = 2,				\
-		.channels_max = 2,				\
+		.channels_min = (min_ch),			\
+		.channels_max = (max_ch),			\
...

 struct snd_soc_dai omap_mcbsp_dai[] = {
-	OMAP_MCBSP_DAI_BUILDER(0),
-	OMAP_MCBSP_DAI_BUILDER(1),
+	OMAP_MCBSP_DAI_BUILDER(0, 2, 2),
+	OMAP_MCBSP_DAI_BUILDER(1, 2, 2),
 #if NUM_LINKS >= 3
...

and

+struct snd_soc_dai omap_mcbsp_dai_mono[] = {
+	OMAP_MCBSP_DAI_BUILDER(0, 1, 1),
+	OMAP_MCBSP_DAI_BUILDER(1, 1, 1),
+#if NUM_LINKS >= 3
...

but this looks a bit overkill if typical configuration has only one such a
mono link and might confuse if a machine driver still needs to reference those
arrays using sequential array index like:

	.cpu_dai = &omap_mcbsp_dai[0],
and
	.cpu_dai = &omap_mcbsp_dai_mono[1],

sequential since if I like that cpu_dai->id is also sequential for links.

Opinnions or better ideas :-)


-- 
Jarkko
