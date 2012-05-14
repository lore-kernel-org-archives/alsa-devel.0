From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 00/15] HD-audio updates for 3.5
Date: Mon, 14 May 2012 17:31:51 +0200
Message-ID: <1337009526-26256-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by alsa0.perex.cz (Postfix) with ESMTP id 7968124A29
	for <alsa-devel@alsa-project.org>;
	Mon, 14 May 2012 17:32:18 +0200 (CEST)
Received: from relay2.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id E65AA8FE69
	for <alsa-devel@alsa-project.org>;
	Mon, 14 May 2012 17:32:17 +0200 (CEST)
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

Hi,

this is a series of HD-audio patches for 3.5 kernel from topic/hda
branch of sound git tree.

One behavior change is about the suspend/resume.  As seen in another
thread, now the driver tries to resume immediately instead of delaying
the initialization.  This is because we found out that some hardware
(more exactly BIOS) don't initialize the chips correctly, thus the
driver _must_ initialize them properly even for the further sleep /
shutdown.

In the code organization side, I started moving some common codes into
hda_auto_parser.[ch].  This will gather the codes commonly used for the
BIOS auto-parser, and leave hda_codec.c a bit more cleaner.

In addition to these commits, there are pending commits for VGA-
switcheroo support in topic/hda-switcheroo branch.  The changes in VGA
side have been already merged in Dave's upstream tree, and the rest
for HD-audio will be merged soon (once after the conflict in linux-next
is resolved...)


thanks,

Takashi
