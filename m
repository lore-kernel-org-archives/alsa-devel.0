From: "Matt Mullins" <mokomull@gmail.com>
Subject: Re: Fwd: Problems with hda_intel, Santa Rosa,
	and suspend
Date: Sun, 17 Jun 2007 20:59:14 -0500
Message-ID: <dfd4051f0706171859m721411bbvf9ac0352c8599a67@mail.gmail.com>
References: <dfd4051f0706161836xa191176ke10deff2868ad8d6@mail.gmail.com>
	<200706171149.27547.rjw@sisk.pl>
	<dfd4051f0706171355i7bc3d4b7qe9aee2acb904c8c@mail.gmail.com>
	<dfd4051f0706171735s72033440sf4d1dc83046e0e05@mail.gmail.com>
	<75b66ecd0706171749x1c29b4b2u8978ac68888960d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mu-out-0910.google.com (mu-out-0910.google.com [209.85.134.191])
	by alsa0.perex.cz (Postfix) with ESMTP id AA32D1037F7
	for <alsa-devel@alsa-project.org>;
	Mon, 18 Jun 2007 03:59:15 +0200 (CEST)
Received: by mu-out-0910.google.com with SMTP id w8so1625062mue
	for <alsa-devel@alsa-project.org>; Sun, 17 Jun 2007 18:59:14 -0700 (PDT)
In-Reply-To: <75b66ecd0706171749x1c29b4b2u8978ac68888960d@mail.gmail.com>
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
To: Lee Revell <rlrevell@joe-job.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Well, that fixed the as-module problem; now snd-hda-intel works as a
module.  However, suspend/resume still doesn't work:
[    7.287540] ALSA
/home/mmullins/Desktop/alsa/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:609:
hda-intel: send_cmd timeout: IRS=0x1, val=0x7c2f0009
[    7.287667] ALSA
/home/mmullins/Desktop/alsa/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:609:
hda-intel: send_cmd timeout: IRS=0x1, val=0x7c270500
[    7.287795] ALSA
/home/mmullins/Desktop/alsa/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:609:
hda-intel: send_cmd timeout: IRS=0x1, val=0x7c3f0009
[    7.287922] ALSA
/home/mmullins/Desktop/alsa/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:609:
hda-intel: send_cmd timeout: IRS=0x1, val=0x7c370500
[    7.288049] ALSA
/home/mmullins/Desktop/alsa/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:609:
hda-intel: send_cmd timeout: IRS=0x1, val=0x7c4f0009
[    7.288177] ALSA
/home/mmullins/Desktop/alsa/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:609:
hda-intel: send_cmd timeout: IRS=0x1, val=0x7c470500
[    7.288304] ALSA
/home/mmullins/Desktop/alsa/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:609:
hda-intel: send_cmd timeout: IRS=0x1, val=0x7c5f0009

This can be worked around by removing and reinserting the
snd-hda-intel module.  However, there is still a problem in the PM
code.

- Matt Mullins
