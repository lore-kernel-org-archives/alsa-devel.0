From: Andrew Clayton <andrew@digital-domain.net>
Subject: 2.6.38.4 broke my audio
Date: Sun, 24 Apr 2011 11:30:37 +0100
Message-ID: <20110424113037.11af0b04@omega.digital-domain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from b.painless.aaisp.net.uk (b.painless.aaisp.net.uk [81.187.30.52])
	by alsa0.perex.cz (Postfix) with ESMTP id 078102444C
	for <alsa-devel@alsa-project.org>;
	Sun, 24 Apr 2011 12:30:40 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Greg Kroah-Hartman <gregkh@suse.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi guys.

Just upgraded to .4 from .3 and found my audio was _really_ quiet. All
the mixers looked sane.

A quick check of the changelog and a revert of:

commit 58541cc27531727f7120683a7cb123ee3ada4bd4
Author: Takashi Iwai <tiwai@suse.de>
Date:   Mon Mar 28 12:05:31 2011 +0200

    ALSA: hda - Fix pin-config of Gigabyte mobo
    
    commit c6b358748e19ce7e230b0926ac42696bc485a562 upstream.
    
    Use pin-fix instead of the static quirk for Gigabyte mobos 1458:a002.
    
    Bugzilla: https://bugzilla.novell.com/show_bug.cgi?id=677256
    Signed-off-by: Takashi Iwai <tiwai@suse.de>
    Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

made it normal again.

My motherboard is a Gigabyte: G41M-ES2L

00:1b.0 Audio device: Intel Corporation N10/ICH 7 Family High Definition Audio Controller (rev 01)
	Subsystem: Giga-byte Technology Device a002
	Flags: bus master, fast devsel, latency 0, IRQ 16
	Memory at e3500000 (64-bit, non-prefetchable) [size=16K]
	Capabilities: <access denied>
	Kernel driver in use: HDA Intel


Cheers,
Andrew
