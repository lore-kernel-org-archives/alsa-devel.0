From: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
Subject: Use-before-initialization in alsa-oss
Date: Sat, 06 Oct 2007 16:16:57 +0600
Message-ID: <47076099.40609@ums.usu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay4.usu.ru (relay4.usu.ru [194.226.235.39])
	by alsa0.perex.cz (Postfix) with ESMTP id D261C243EB
	for <alsa-devel@alsa-project.org>;
	Sat,  6 Oct 2007 12:16:51 +0200 (CEST)
Received: from relay4.usu.ru (localhost [127.0.0.1])
	by relay4.usu.ru (PostSystem) with ESMTP id 793CF17EDA
	for <alsa-devel@alsa-project.org>;
	Sat,  6 Oct 2007 16:20:07 +0600 (YEKST)
Received: from usu2.usu.ru (usu2.usu.ru [194.226.237.16])
	by relay4.usu.ru (PostSystem) with ESMTP id 1158D17EDA
	for <alsa-devel@alsa-project.org>;
	Sat,  6 Oct 2007 16:20:07 +0600 (YEKST)
Received: from usu2.usu.ru (localhost.usu2.usu.ru [127.0.0.1])
	by usu2.usu.ru (Postfix) with ESMTP id 20EECA7E95
	for <alsa-devel@alsa-project.org>;
	Sat,  6 Oct 2007 16:16:45 +0600 (YEKST)
Received: from ums.usu.ru (ums.usu.ru [194.226.236.116])
	by usu2.usu.ru (Postfix) with ESMTP id D7B0DA7A2F
	for <alsa-devel@alsa-project.org>;
	Sat,  6 Oct 2007 16:16:39 +0600 (YEKST)
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

dsp->oss_format was used before it was set correctly

spotted by running "aoss flite_time 10:00"
Signed-Off-By: Alexander E. Patrakov

--- alsa-oss-1.0.14.orig/alsa/pcm.c	2007-09-29 16:12:44.000000000 +0600
+++ alsa-oss-1.0.14/alsa/pcm.c	2007-09-29 16:13:06.000000000 +0600
@@ -215,10 +215,10 @@
 		unsigned int rate, periods_min;
 		if (!pcm)
 			continue;
+		dsp->format = oss_format_to_alsa(dsp->oss_format);
 		str->frame_bytes = snd_pcm_format_physical_width(dsp->format) * dsp->channels / 8;
 		snd_pcm_hw_params_alloca(&hw);
 		snd_pcm_hw_params_any(pcm, hw);
-		dsp->format = oss_format_to_alsa(dsp->oss_format);
 
 		err = snd_pcm_hw_params_set_format(pcm, hw, dsp->format);
 		if (err < 0)



-- 
Alexander E. Patrakov
