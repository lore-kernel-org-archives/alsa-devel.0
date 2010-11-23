From: Dan Carpenter <error27@gmail.com>
Subject: [patch] pcm: add MMAP_EMUL to type names
Date: Tue, 23 Nov 2010 14:03:37 +0300
Message-ID: <20101123110337.GK1522@bicker>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id EAE1F1038B0
	for <alsa-devel@alsa-project.org>; Tue, 23 Nov 2010 12:03:53 +0100 (CET)
Received: by wyg36 with SMTP id 36so8158333wyg.38
	for <alsa-devel@alsa-project.org>; Tue, 23 Nov 2010 03:03:53 -0800 (PST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, perex@perex.cz
List-Id: alsa-devel@alsa-project.org

If we try to print this then it causes a read past the end of the array
in snd_pcm_type_name().

diff --git a/src/pcm/pcm.c b/src/pcm/pcm.c
index 7409943..906b502 100644
--- a/src/pcm/pcm.c
+++ b/src/pcm/pcm.c
@@ -1633,6 +1633,7 @@ static const char *const snd_pcm_type_names[] = {
 	PCMTYPE(SOFTVOL),
         PCMTYPE(IOPLUG),
         PCMTYPE(EXTPLUG),
+	PCMTYPE(MMAP_EMUL),
 };
 
 static const char *const snd_pcm_subformat_names[] = {
