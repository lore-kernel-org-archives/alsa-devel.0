From: Enrico Mioso <mrkiko.rs@gmail.com>
Subject: Re: Intel HDA audio on EEE PC 1101HGo
Date: Tue, 10 Jan 2017 14:32:05 +0100 (CET)
Message-ID: <alpine.LNX.2.20.1701101426370.12174@localhost.localdomain>
References: <alpine.LNX.2.20.1504082130290.1715@localhost.localdomain>
 <s5hegntl2cs.wl-tiwai@suse.de>
 <alpine.LNX.2.20.1611230916070.5938@localhost.localdomain>
 <s5hr35s0xh2.wl-tiwai@suse.de>
 <alpine.LNX.2.20.1612011450060.7660@localhost.localdomain>
 <s5h4m2n21ll.wl-tiwai@suse.de>
 <alpine.LNX.2.20.1701031449090.1620@localhost.localdomain>
 <s5hlgujyyop.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wj0-f196.google.com (mail-wj0-f196.google.com
 [209.85.210.196])
 by alsa0.perex.cz (Postfix) with ESMTP id 7D24B2671C2
 for <alsa-devel@alsa-project.org>; Tue, 10 Jan 2017 14:32:15 +0100 (CET)
Received: by mail-wj0-f196.google.com with SMTP id dh1so7241514wjb.3
 for <alsa-devel@alsa-project.org>; Tue, 10 Jan 2017 05:32:15 -0800 (PST)
In-Reply-To: <s5hlgujyyop.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: hui.wang@canonical.com, alsa-devel@alsa-project.org, kailang@realtek.com
List-Id: alsa-devel@alsa-project.org

First of all - Thank you very very much.
I am apreciating a lot your help and kind replies.

Running the module like:
options snd_hda_intel power_save_controller=0 power_save=0 single_cmd=1

prevents the system from crashing, still I can see lots of errors like the ones you find below.
(I already reported them, doing it again just for reference / clarity after trying to change my top-posting habits.)

I'll test your patch ASAP: starting now kernel recompiling.

Enrico

snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x23a02d
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x23902d
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x33a02d
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x33902d
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x23a02e
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x23902e
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x33a02e
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x33902e
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x23902d
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x33902d
snd_hdac_bus_update_rirb: 42 callbacks suppressed
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x23902e
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x33902e
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x33902e
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x23902d
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x23902d
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x33a02d
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x33902d
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x33902d
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x23a02c
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x23902c
snd_hdac_bus_update_rirb: 2 callbacks suppressed
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hdac_bus_update_rirb: 2 callbacks suppressed
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x23902d
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x33a02d
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x33902d
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x33902d
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x23a02e
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x23902e
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x33a02e
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x33902e
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x23902f
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x33a02f
snd_hdac_bus_update_rirb: 46 callbacks suppressed
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x23a031
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x239031
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x33a031
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x339031
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x23a030
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x239030
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x33a030
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x339030
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x23a02f
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x23902f
snd_hdac_bus_update_rirb: 30 callbacks suppressed
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x239029
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x339029
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x339029
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x339029
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x23902a
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x33902a
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x33902a
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x23902b
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x33a02b
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x33902b
snd_hdac_bus_update_rirb: 114 callbacks suppressed
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x239038
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x339038
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x339038
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x239037
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x33a037
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x339037
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x339037
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x239036
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x33a036
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x339036
snd_hdac_bus_update_rirb: 58 callbacks suppressed
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hdac_bus_update_rirb: 1 callbacks suppressed
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x23a02b
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x23902b
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x33a02b
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x33902b
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x23a02a
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x23902a
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x33a02a
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x33902a
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x23a029
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x239029
snd_hdac_bus_update_rirb: 2 callbacks suppressed
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00


On Tue, 10 Jan 2017, Takashi Iwai wrote:

> Date: Tue, 10 Jan 2017 11:52:22
> From: Takashi Iwai <tiwai@suse.de>
> To: Enrico Mioso <mrkiko.rs@gmail.com>
> Cc: hui.wang@canonical.com, alsa-devel@alsa-project.org, kailang@realtek.com
> Subject: Re: [alsa-devel] Intel HDA audio on EEE PC 1101HGo
> 
> On Tue, 03 Jan 2017 14:49:40 +0100,
> Enrico Mioso wrote:
>>
>> hello Tahaski,
>> hello everyone reading this message.
>>
>> Thank you for the patience you had with me. Now I finally came to set up this system for crash analysis, compiling the kernel with debug informations and frame pointers and so on. I set up kdump also. Unfortunately, I can get no useful output.
>> The last things the system wrote before dying have been reconstructed. I noted down decimal values with the help of my mum. She wrote them down on a piece of paper.
>> I am hitting the following messages:
>> azx_get_response timeout, switching to polling mode: last cmd=0x014ba000
>> azx_get_response timeout, switching to single_cmd mode: last cmd=0x014ba000
>
> It's reading the output amp on NID 0x14, the speaker pin.  It's weird
> that such a verb triggers the problem.  Usually the unexpected
> behavior is triggered at the widget power up/down.
>
> If the switching to single cmd mode causes an issue, you can disable
> by the patch like below.  This may lead to the continuous errors,
> though.
>
>
> Takashi
>
> ---
> diff --git a/sound/pci/hda/hda_controller.c b/sound/pci/hda/hda_controller.c
> index 500878556578..43bf151d8712 100644
> --- a/sound/pci/hda/hda_controller.c
> +++ b/sound/pci/hda/hda_controller.c
> @@ -861,6 +861,7 @@ static int azx_rirb_get_response(struct hdac_bus *bus, unsigned int addr,
> 		return -EIO;
> 	}
>
> +#if 0
> 	/* a fatal communication error; need either to reset or to fallback
> 	 * to the single_cmd mode
> 	 */
> @@ -875,6 +876,7 @@ static int azx_rirb_get_response(struct hdac_bus *bus, unsigned int addr,
> 	chip->single_cmd = 1;
> 	hbus->response_reset = 0;
> 	snd_hdac_bus_stop_cmd_io(bus);
> +#endif
> 	return -EIO;
> }
>
>
