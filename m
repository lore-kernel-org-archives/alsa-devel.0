From: Reimundo Heluani <rheluani@gmail.com>
Subject: Macbook Air 2,1 - no mic nor main speakers
Date: Sat, 06 Feb 2010 10:27:59 -0800
Message-ID: <1265480879.2466.21.camel@vino>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-px0-f173.google.com (mail-px0-f173.google.com
	[209.85.216.173])
	by alsa0.perex.cz (Postfix) with ESMTP id 2E4351037F5
	for <alsa-devel@alsa-project.org>; Sat,  6 Feb 2010 19:28:00 +0100 (CET)
Received: by pxi3 with SMTP id 3so117487pxi.16
	for <alsa-devel@alsa-project.org>; Sat, 06 Feb 2010 10:27:59 -0800 (PST)
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

Hello list, this came up a year ago and Takashi's answer was "a broken
bios". I was hoping someone here could point me to documentation to read
in order to diagnose the problem if indeed is a broken bios. I don't
want to start randombly reading the driver's code.

Macbook Air 2,1
2.6.32-gentoo-r3 SMP x86_64
Alsa Driver 1.0.21 libs 1.0.22
nVidia Corporation MCP79 High Definition Audio (rev b1)
HDA NVidia at 0x93380000 irq 19
00:08.0 0403: 10de:0ac0 (rev b1)  Subsystem: 10de:cb79
Codec: Realtek ALC889A

Booting with snd_hda_intel.model=mbp3 get sound on headphones, but not on mainspeakers. The mic never worked.
