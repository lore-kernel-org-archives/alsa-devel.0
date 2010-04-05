From: Aleksander Adamowski <alsa@olo.org.pl>
Subject: snd-hda-intel: Is there a way to specify a quirk for
	the default bdl_pos_adj value for the given chipset (PCI ID)?
Date: Mon, 5 Apr 2010 21:03:53 +0200
Message-ID: <i2l1c690d741004051203k36fdd493z577063a9a53ae715@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f188.google.com (mail-yx0-f188.google.com
	[209.85.210.188])
	by alsa0.perex.cz (Postfix) with ESMTP id B6DCC1038FF
	for <alsa-devel@alsa-project.org>;
	Mon,  5 Apr 2010 21:06:21 +0200 (CEST)
Received: by yxe26 with SMTP id 26so2306690yxe.23
	for <alsa-devel@alsa-project.org>; Mon, 05 Apr 2010 12:06:19 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi!

I'm working on a patch against GIT for snd-hda-intel that would let my
card's capture work properly without losing ability to capture audio (that's
an old story available in this thread:
http://thread.gmane.org/gmane.linux.alsa.devel/66775).

I know how to make position_fix=1 permanent for the given PCI ID (the
snd_pci_quirk position_fix_list struct array in hda_intel.c), but there
seems to be no way of making a similar quirk for bdl_pos_adj - am I looking
in the wrong place?

My work on a patch goes in parallel with determining the minimal set of
modifications that will solve the problem.

Currently, I've determined that the combination of 3 module options
described in this forum post solves my problem:
http://www.linuxhardware.org/forums/viewtopic.php?p=66&sid=f6e8953338fd94c7c44a9d4955849e3f#66

I'm working on isolating the minimum set of these that solves the problem
(which requires a couple of hours to be reproduce, so that takes time).

I've observed that neither position_fix=1, nor bdl_pos_adj=0 solve the
problem by themselves in isolation.

I'm unsure whether model=3stack-6ch is necessary at all,
because patch_realtek.c already has the model mapping for my combination of
PCI IDs and it maps to a different model:
SND_PCI_QUIRK(0x1458, 0xa002, "Gigabyte P35 DS3R", ALC882_6ST_DIG),

Once the minimization is accomplished, I want to prepare a patch against GIT
(git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6.git is the
repo to work against, as far as I understand).

But since it seems that bdl_pos_adj=0 is required for proper operation, I
need a method to map the default for that option in the sources, if there is
such a method.

I'd be grateful for any pointers.

-- 
Best Regards,
 Aleksander Adamowski
 http://olo.org.pl
