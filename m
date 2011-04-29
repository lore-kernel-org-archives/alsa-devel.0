From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 0/10] Realtek auto-parser updates
Date: Fri, 29 Apr 2011 19:18:26 +0200
Message-ID: <1304097516-7258-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	by alsa0.perex.cz (Postfix) with ESMTP id D206610382A
	for <alsa-devel@alsa-project.org>;
	Fri, 29 Apr 2011 19:19:01 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.221.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id 501265362F
	for <alsa-devel@alsa-project.org>;
	Fri, 29 Apr 2011 19:18:59 +0200 (CEST)
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

Hi, this is a series of patches I'm going to apply as 2.6.40 material.
Basically this adds the missing features to BIOS auto-parser mode, the
support of multi-channel setup (2/4/6-channels) and the auto-mute of
line-out jacks as well as speakers.

Many changes have been done but mostly in systematic manner.
I've checked through hda-emu and a few machines with Realtek codecs,
but of course can't cover all changes I made.

If you see any issues with the updated tree, please let me know.


thanks,

Takashi
