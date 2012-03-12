From: Ondrej Zary <linux@rainbow-software.org>
Subject: Triple implementation of WM8766 and quadruple WM8776!
Date: Mon, 12 Mar 2012 22:40:54 +0100
Message-ID: <201203122241.12234.linux@rainbow-software.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: Kernel development list <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Hello,
I'm trying do implement support for Philips PSC724 Ultimate Edge card, which 
is based on VT1722 + WM8776 + WM8766 chips. Found that the best file to base 
my work on is sound/pci/ice1712/se.c (as SE-200PCI card contains both WM8776 
and WM8766 chips).

While doing this, found that there are three implementations of WM8766 codec 
control, two of them in the same driver(!):
sound/pci/ice1712/se.c
sound/pci/ice1712/prodigy_hifi.c
sound/pci/oxygen/xonar_wm87x6.c (+sound/pci/oxygen/wm8766.h)

And WM8776 status is even worse, there are four implementations, again two 
being in the same driver:
sound/pci/ice1712/se.c
sound/pci/ice1712/maya44.c
sound/pci/oxygen/xonar_wm87x6.c (+sound/pci/oxygen/wm8776.h)
sound/soc/codecs/wm8776.c (this one being official and stand-alone module but 
it does not seem to be usable as a part of sound card driver)

My code would enlarge both of these lists and I don't like that. What to do?

-- 
Ondrej Zary
