From: Andrew Paprocki <andrew@ishiboo.com>
Subject: [PATCH] hda_intel: Fix multiple device support by
	incrementing device	count
Date: Sat, 12 Jan 2008 19:05:29 -0400
Message-ID: <bde9dbdbd2ba8a84ac2f.1200182729@firewall.26broadway.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.188])
	by alsa0.perex.cz (Postfix) with ESMTP id 12D87248A5
	for <alsa-devel@alsa-project.org>; Sun, 13 Jan 2008 04:13:24 +0100 (CET)
Received: by rv-out-0910.google.com with SMTP id k20so1162964rvb.32
	for <alsa-devel@alsa-project.org>; Sat, 12 Jan 2008 19:13:23 -0800 (PST)
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
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Fixes multiple device support by incrementing the static device counter
at the end of the azx_probe() call. Without this, subsequent probes would
always use the index specified for the first card.

Signed-off-by: Andrew Paprocki <andrew@ishiboo.com>

diff -r acdc98363786 -r bde9dbdbd2ba pci/hda/hda_intel.c
--- a/pci/hda/hda_intel.c	Fri Jan 11 18:15:26 2008 +0100
+++ b/pci/hda/hda_intel.c	Sat Jan 12 18:59:58 2008 -0500
@@ -1933,6 +1933,7 @@ static int __devinit azx_probe(struct pc
 	chip->running = 1;
 	power_down_all_codecs(chip);
 
+	dev++;
 	return err;
 }
