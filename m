From: Harald Welte <HaraldWelte@viatech.com>
Subject: [PATCH 0/3] HDA patch_via.c updates
Date: Mon, 15 Sep 2008 22:40:05 +0800
Message-ID: <20080915144005.GA8061@prithivi.gnumonks.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	by alsa0.perex.cz (Postfix) with ESMTP id 24335243F1
	for <alsa-devel@alsa-project.org>;
	Mon, 15 Sep 2008 16:40:15 +0200 (CEST)
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
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>, Logan Li <loganli@viatech.com.cn>
List-Id: alsa-devel@alsa-project.org

Hi!

Unfortunately there is one crash (headphone related), one non-working feature
(second S/PDIF out) and one regular bugfix since my seven-patch series from
last week.

Please review + apply the following patches to your tree.  I've tested them
against sound-2.6/topic/hda and they apply fine.

If you have any questions, please keep Logan Li in the Cc, he is the engineer
who actually implemented those changes and knows all the details.

Thanks in advance,
-- 
- Harald Welte <HaraldWelte@viatech.com>	    http://linux.via.com.tw/
============================================================================
VIA Open Source Liaison
