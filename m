From: Chris Pemberton <cjpembo.mailing.lists@gmail.com>
Subject: Re: New BIOS, new vendor and device IDs
Date: Fri, 17 Oct 2008 02:04:37 -0500
Message-ID: <48F83905.8040801@gmail.com>
References: <48F7FDAF.3010300@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.184])
	by alsa0.perex.cz (Postfix) with ESMTP id C3131103827
	for <alsa-devel@alsa-project.org>;
	Fri, 17 Oct 2008 09:05:06 +0200 (CEST)
Received: by nf-out-0910.google.com with SMTP id e27so273065nfd.32
	for <alsa-devel@alsa-project.org>; Fri, 17 Oct 2008 00:04:49 -0700 (PDT)
In-Reply-To: <48F7FDAF.3010300@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alsa Developer Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Chris Pemberton wrote:
> My machine is a Lenovo 3000 N100 laptop (0768 model).  I had to 
> recently update the BIOS.
>
> Old BIOS:  lspci -> device id:  [17aa:2066] which is a Realtek 
> ALC861VD (found in patch_realtek.c)
>
> New BIOS: lspci -> device id: [8086:27d8] (found in hda_intel.c)
>
> In both cases, I use the module option "model=3stack" to get sound 
> working:
> Laptop speakers work. Built-in mic works. External mic works
> Headphones work; but automatic speaker muting does not.
> I tried to debug why I needed this module option at all, several 
> months ago (old BIOS), but I didn't get far and just became complacent 
> with using the module option.
>
> If anyone is interested, I'll do what I can to help debug.  It would 
> be nice to be able to use Skype with headphones...
>
> Output of the alsa info script is at:  
> http://www.alsa-project.org/db/?f=701ca6efa0500080dc78a555813f66c1d42096e6 
>
> That is with driver 1.0.17.  I'll try to update to the latest snapshot 
> and run the script again.
>
> Thanks,
>
> Chris
>
Well, forget everything I said about the BIOS and new device ids: I was 
mistaken. 

Running "lspci -nnvv" gives the following:

00:1b.0 Audio device [0403]: Intel Corporation 82801G (ICH7 Family) High 
Definition Audio Controller [8086:27d8] (rev 02)
        *Subsystem: Lenovo Device [17aa:2066]*
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Interrupt: pin A routed to IRQ 22
        Region 0: Memory at d0340000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: <access denied>
        Kernel driver in use: HDA Intel
        Kernel modules: snd-hda-intel

I mistakenly thought "lspci -nn" was the correct command.  This gave the 
vendor info, not the device into.  Sorry for the noise.  I feel like a tool.

But, I'd still like to help debug the headphone jack sensing and module 
option if possible.

Chris
