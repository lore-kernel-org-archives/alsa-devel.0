From: Harald Becker <ralda@gmx.de>
Subject: HDA Beep Device for Asus EeeBox EB1501P
Date: Wed, 20 Feb 2013 22:51:53 +0100
Message-ID: <20130220225153.603edc5e@ralda.gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 by alsa0.perex.cz (Postfix) with ESMTP id 80D28265B62
 for <alsa-devel@alsa-project.org>; Wed, 20 Feb 2013 22:51:59 +0100 (CET)
Received: from mailout-de.gmx.net ([10.1.76.28]) by mrigmx.server.lan
 (mrigmx002) with ESMTP (Nemesis) id 0Lur0x-1Uq6gs0qnp-0106Ep for
 <alsa-devel@alsa-project.org>; Wed, 20 Feb 2013 22:51:55 +0100
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
List-Id: alsa-devel@alsa-project.org

Hi,

I own an Asus EeeBox EB1501P with an ALC662 codec and had no HDA mixer
channel for the speaker beep device. After digging somewhat in the
kernel source I found that I only need to add a single line in the
beep_white_list in patch_realtek.c. May be this entry can be included
in the mainstream drivers:

SND_PCI_QUIRK(0x1043, 0x8376, "EeePC", 1),

After recompiling the driver with this entry, the mixer device for the
beep channel appears and the digital beep sound is emitted on the
connected speakers.

... with one problem:

If I use echo -e "\a" in a shell or run the beep command utility the
sound appears only on second and following invocations. Whenever the
frequency changes with the beep command the first invocation stays
silent or just produce some click due to ALSA driver power saving. On
all further invocations with same frequency the requested tone is
generated on external speakers. There is no difference in behavior if
the commands are called in a terminal emulator or directly on a virtual
text console.

Does this happen only on my machine or is this a known problem? Is
there anything I can do to fix this behavior?

The kernel I used for testing is 3.8.0 from Gentoo Sources.

Feel free to ask for any information you may need for debugging.

Thx for any help ahead
Harald
