From: Andreas Herrmann <herrmann.der.user@googlemail.com>
Subject: Re: [PATCH] ALSA,
 hda: Add support for Lenovo ThinkPad Edge 13 in conexant codec
Date: Fri, 28 May 2010 08:45:08 +0200
Message-ID: <20100528064508.GG10254@alberich.amd.com>
References: <20100527160656.GE10254@alberich.amd.com>
	<s5htyps3788.wl%tiwai@suse.de>
	<20100528062102.GF10254@alberich.amd.com>
	<1275028527.2945.1812.camel@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 37BA1103AEF
	for <alsa-devel@alsa-project.org>;
	Fri, 28 May 2010 08:45:13 +0200 (CEST)
Received: by fxm18 with SMTP id 18so636847fxm.38
	for <alsa-devel@alsa-project.org>; Thu, 27 May 2010 23:45:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1275028527.2945.1812.camel@laptop>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jerone Young <jerone.young@canonical.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Borislav Petkov <borislav.petkov@amd.com>
List-Id: alsa-devel@alsa-project.org

On Fri, May 28, 2010 at 01:35:27AM -0500, Jerone Young wrote:
> Are you sure? The pci id I have is for 0x21b4 based on information from
> that bug. What you point out is 0x21b3. Please retest with 
> 
> SND_PCI_QUIRK(0x17aa, 0x21b4, "Thinkpad Edge", CXT5066_IDEAPAD)
> 
> Can you post lspci -vvnn output for your Thinkpad Edge?

The PCI audio device is:

00:14.2 Audio device [0403]: ATI Technologies Inc SBx00 Azalia (Intel HDA) [1002:4383]
        Subsystem: Lenovo Device [17aa:21b3]
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 64, Cache Line Size: 32 bytes
        Interrupt: pin ? routed to IRQ 16
        Region 0: Memory at d0600000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: <access denied>
        Kernel driver in use: HDA Intel
        Kernel modules: snd-hda-intel

So maybe yours is the Intel version of Thinkpad Edge 13?

What does dmidecode say for your system? Here is my information:

Handle 0x0001, DMI type 1, 27 bytes
System Information
        Manufacturer: LENOVO
        Product Name: 01972NG
        Version: ThinkPad Edge 13"IAL#

Other types of that notebook family are 0196 and 0492 each having a
huge bunch of differnet models (2NG in my case).

However I try to retest with latest alsa tree (using model=ideapad)
maybe that changes something.


Andreas
