From: Jim Minter <jminter@redhat.com>
Subject: Re: No sound on Thinkpad T440s in Docking Station
Date: Thu, 26 Jun 2014 15:23:35 -0400 (EDT)
Message-ID: <22733057.4.1403810610228.JavaMail.jminter@jminter>
References: <32716219.3.1403810435694.JavaMail.jminter@jminter>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx4-phx2.redhat.com (mx4-phx2.redhat.com [209.132.183.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 8226D265466
 for <alsa-devel@alsa-project.org>; Thu, 26 Jun 2014 21:23:37 +0200 (CEST)
In-Reply-To: <32716219.3.1403810435694.JavaMail.jminter@jminter>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, joschi.brauchle@tum.de
List-Id: alsa-devel@alsa-project.org

Hello,

I'm getting the same issue reported by Joschi in May, but with a docked T540p.  I can confirm that doing the following fixes the issue for me:

==== 8< ====
# cat <<EOF >/lib/firmware/t540p.fw
[codec]
0x10ec0292 0x17aa2210 0

[pincfg]
0x16 0x21211010
0x19 0x21a11010
EOF

# cat <<EOF >/etc/modprobe.d/hda-intel.conf
options snd-hda-intel patch=t540p.fw,t540p.fw,t540p.fw
EOF

Then rmmod/modprobe the snd-hda-intel kernel module, or just reboot.
==== 8< ====

I can see http://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/?id=1c37c22332a2d2c1b4ab32177a4f847c7fe06e38 which I presume resolves this problem for T440s and T440p users.

Please could an additional line, I'm guessing as follows, be added to sound/pci/hda/patch_realtek.c to include T540p users in this happy group?

+	SND_PCI_QUIRK(0x17aa, 0x2210, "Thinkpad T540p", ALC292_FIXUP_TPT440_DOCK),

Thanks!

Jim
