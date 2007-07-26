From: Eliot Blennerhassett <linux@audioscience.com>
Subject: [patch] asihpi: mmap and link streams
Date: Thu, 26 Jul 2007 23:14:48 +1200
Message-ID: <200707262314.48809.linux@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp3.clear.net.nz (smtp3.clear.net.nz [203.97.33.64])
	by alsa0.perex.cz (Postfix) with ESMTP id 66C3224368
	for <alsa-devel@alsa-project.org>;
	Thu, 26 Jul 2007 13:08:04 +0200 (CEST)
Received: from zaphod (121-72-250-62.cable.telstraclear.net [121.72.250.62])
	by smtp3.clear.net.nz (CLEAR Net Mail)
	with ESMTP id <0JLS00G219LDIB20@smtp3.clear.net.nz> for
	alsa-devel@alsa-project.org; Thu, 26 Jul 2007 23:08:01 +1200 (NZST)
Content-disposition: inline
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
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Greetings,

asihpi version 3.07.13 :
Enable MMAP  dma capable cards.
Enable linked streams for cards that have hardware support for this.
Add TLV for level and volume controls.
Register asihpi class for HPI part of driver
Add documentation, remove unused code.

Signed-off-by: Eliot Blennerhassett <eblennerhassett@audioscience.com>
----

Patch (4798 lines) is here:
http://audioscience.com/internet/download/beta/alsa_driver3349_asihpi30713.patch

Matching firmware is here:
http://audioscience.com/internet/download/firmware/dspbins30713.zip

FYI: Original source package here:
http://audioscience.com/internet/download/hpklinux-3.07.13.tar.bz2

 asihpi.c             | 1517 
++++++++++++++++++++++++++-------------------------
Implement MMAP and linked streams.
Merge some capture and playback functions
Add dB TLV  for level and volume controls

 hpi6000.c            |    7
Clean

 hpi6205.c            |  498 +++++++++-------
Changes to allow attaching external DMA buffer (for ALSA)

 hpidebug.c           |   67 +-
 hpidebug.h           |  349 +++++------
Changes to support unicode

 hpimod.c             |  283 ++-------
Cleanup, add class registration

 hpimsgx.c            |   50 +
Add 2 new subsys functions

 hpios_linux_kernel.c |   36 -
 hpios_linux_kernel.h |   15
Minor debug changes. Add pci dev ptr to allow alsa to allocate dma buffer

 hpi.h                |   54 -
 hpi56301.c           |    1
 hpidspcd.c           |    2
 hpifunc.c            |  121 ++--
Documentation updates

 13 files changed, 1506 insertions(+), 1494 deletions(-)
