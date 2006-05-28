From: Dave Jones <davej@redhat.com>
Subject: 2.6.17rc emu10k1 regression.
Date: Sun, 28 May 2006 12:40:15 -0400
Message-ID: <20060528164015.GA13499@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id ECD06147
	for <alsa-devel@alsa-project.org>;
	Sun, 28 May 2006 18:40:17 +0200 (MEST)
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

$ lspci  | grep audio
00:1f.5 Multimedia audio controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) AC'97 Audio Controller (rev 02)
06:0d.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 04)

(That's 06:0d.1 0980: 1102:7002 (rev 01))

This worked fine in 2.6.16, however when I try a .17rc kernel I get this..

cannot find the slot for index 0 (range 0-1)
EMU10K1_Audigy: probe of 0000:06:0d.0 failed with error -12

(Unremarkable, considering it *isn't* an Audigy)


modprobe.conf has ..
alias snd-card-0 snd-emu10k1
options snd-card-0 index=0
options snd-emu10k1 index=0
remove snd-emu10k1 { /usr/sbin/alsactl store 0 >/dev/null 2>&1 || : ; }; /sbin/modprobe -r --ignore-remove snd-emu10k1

What changed ?

		Dave

-- 
http://www.codemonkey.org.uk
