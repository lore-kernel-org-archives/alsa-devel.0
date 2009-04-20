From: Tino Keitel <tino.keitel@tikei.de>
Subject: 2.6.29 regression: left audio channel broken after resume from
	suspend with Intel HDA
Date: Mon, 20 Apr 2009 20:40:24 +0200
Message-ID: <20090420184024.GA10155@dose.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754149AbZDTSkg@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

Hi,

since 2.6.29 and also with 2.6.29.1 the left audio channel of the
digital output of my Mac mini Core 2 Duo is noisy.  This didn't happen
with 2.6.28.  Unloading snd-hda-intel and reloading it does fix the
noisy sound.

This happened with some older versions of the Linux kernel (with an
older Mac mini Core Duo, I don't remeber which kernel version), but got
fixed at some point.  Now it happens again with 2.6.29.

Here is the dmesg output for the sound hardware:

HDA Intel 0000:00:1b.0: PCI INT A -> GSI 22 (level, low) -> IRQ 22
HDA Intel 0000:00:1b.0: setting latency timer to 64
hda_codec: STAC922x, Apple subsys_id=100
input: HDA Intel Line In at Ext Left Jack as /class/input/input18
input: HDA Intel Mic at Ext Left Jack as /class/input/input19
input: HDA Intel HP Out at Ext Left Jack as /class/input/input20

Any hints what I could try to fix this, maybe some commit that I should
try to revert?

Regards,
Tino
