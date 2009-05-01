From: =?UTF-8?B?T3phbiDDh2HEn2xheWFu?= <ozan@pardus.org.tr>
Subject: Too big adjustment messages on hda-intel with ALC883
Date: Fri, 01 May 2009 13:57:59 +0300
Message-ID: <49FAD5B7.9030304@pardus.org.tr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from pardus.org.tr (ns2.uludag.org.tr [193.140.100.220])
	by alsa0.perex.cz (Postfix) with ESMTP id 039322436D
	for <alsa-devel@alsa-project.org>;
	Fri,  1 May 2009 12:58:00 +0200 (CEST)
Received: from [192.168.1.2] (unknown [88.249.178.198])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested) (Authenticated sender: ozan)
	by pardus.org.tr (Postfix) with ESMTP id B1EDF6680B25
	for <alsa-devel@alsa-project.org>;
	Fri,  1 May 2009 13:57:51 +0300 (EEST)
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

When I launch pulseaudio, a bunch of the following line is dropped to dmesg:

[ 1472.847085] ALSA ../../alsa-kernel/pci/hda/hda_intel.c:1102: Too big
adjustment 32
[ 1472.998865] hda-intel: IRQ timing workaround is activated for card
#1. Suggest a bigger bdl_pos_adj.

alsa-info output is at:
http://www.alsa-project.org/db/?f=fd7037731d908e4287e1d457de6a1483062b2130

I'm using 2.6.30_rc3 with:
  - 20090421 snapshot of alsa-driver,
  - 20090410 snapshot of alsa-lib.

Pulseaudio version is 0.9.15, timer-based scheduling is enabled.

Regards,

Ozan Caglayan
http://www.pardus.org.tr/eng
