From: ruben@ugr.es
Subject: [PATCH] Enable loudspeakers in ALC889 for Acers and
	others
Date: Wed, 1 Jul 2009 20:04:36 +0200 (CEST)
Message-ID: <32768.87.217.178.68.1246471476.squirrel@goliat7.ugr.es>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail2.ugr.es (mail2.ugr.es [150.214.35.29])
	by alsa0.perex.cz (Postfix) with ESMTP id F40F524348
	for <alsa-devel@alsa-project.org>;
	Wed,  1 Jul 2009 20:04:39 +0200 (CEST)
Received: from mail2.ugr.es (localhost [127.0.0.1])
	by localhost.ugr.es (Postfix) with ESMTP id B776D498CA
	for <alsa-devel@alsa-project.org>;
	Wed,  1 Jul 2009 20:04:37 +0200 (MEST)
Received: from goliat7.ugr.es (goliat7.ugr.es [150.214.20.48])
	by mail2.ugr.es (Postfix) with ESMTP id 8B965498C9
	for <alsa-devel@alsa-project.org>;
	Wed,  1 Jul 2009 20:04:37 +0200 (MEST)
Received: from goliat7.ugr.es (localhost [127.0.0.1])
	by goliat7.ugr.es (Postfix) with ESMTP id 622E6168
	for <alsa-devel@alsa-project.org>;
	Wed,  1 Jul 2009 20:04:36 +0200 (CEST)
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

Hi all

I managed to get sound working on my acer 6935, which has an ALC889 driven
by the intel_hda driver
The lack of sound seems to appear in other laptops as well.

The bug report is at
 https://bugtrack.alsa-project.org/alsa-bug/view.php?id=4261

I know Takashi Iwai is familiar with the problems, since I used his
workaround with hda-verb to get it working initially, so if he is free and
wants to get this fixed, I'd be grateful (if anybody else can have a look,
that'd be great as well).

The patch is very easy (you can download it at the url above).
I added
snd_hda_codec_write(codec, 0x15, 0, AC_VERB_SET_EAPD_BTLENABLE, 2);
at the end of patch_alc883 before the return.

Please check whether there is a problem with other models; in that case a
new patch_alc889 which calls patch_alc883 plus the line can be added, or
more detailed checks on the pci ids can be done.

Thanks for your time.
Ruben
