From: Jan Depner <eviltwin69@cableone.net>
Subject: Re: Changing BIOS IRQs and I/O addresses
Date: 28 May 2003 16:17:07 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1054156627.3048.1.camel@eviltwin>
References: <20030528100042.GA7426@ee.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from scanmail2.cableone.net (scanmail2.cableone.net [24.116.0.122])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id XAA27329
	for <alsa-devel@alsa-project.org>; Wed, 28 May 2003 23:55:47 +0200
In-Reply-To: <20030528100042.GA7426@ee.unsw.edu.au>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Matt Flax <flatmax@pgb.unsw.edu.au>
Cc: core sound <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

If you can't set the IRQ in the BIOS the only way that I know of to
change it is to change the PCI slot.  That is how I got mine set.

Jan

On Wed, 2003-05-28 at 05:00, Matt Flax wrote:
> Hello,
> 
> I have traced my problem with my sound card to the function 
> 'request_irq' in the intel8x0 module.
> 
> Unfortunatly the IRQ is set up by the BIOS to be 0.
> This bios does not let the user alter the IRQs.
> 
> Can anyone tell me how to change the IRQ manually ?
> 
> Here is some extended info about the card :
> 00:02.7 Multimedia audio controller: Silicon Integrated Systems [SiS] 
> SiS7012 PCI Audio Accelerator (rev a0)
>         Subsystem: CLEVO/KAPOK Computer: Unknown device 0400
>         Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
> ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
> <TAbort- <MAbort- >SERR- <PERR-
>         Interrupt: pin C routed to IRQ 0
>         Region 0: I/O ports at 1c00 [disabled] [size=256]
>         Region 1: I/O ports at 1800 [disabled] [size=128]
>         Capabilities: [48] Power Management version 2
>                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=55mA 
> PME(D0-,D1-,D2-,D3hot+,D3cold+)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 
> thanks
> Matt
> -- 
> http://mffm.ee.unsw.edu.au
> 
> WSOLA TimeScale Audio Mod  : http://mffmtimescale.sourceforge.net/
> FFTw C++                   : http://mffmfftwrapper.sourceforge.net/
> Vector Bass                : http://mffmvectorbass.sourceforge.net/
> Multimedia Time Code       : http://mffmtimecode.sourceforge.net/
> 
> 
> -------------------------------------------------------
> This SF.net email is sponsored by: ObjectStore.
> If flattening out C++ or Java code to make your application fit in a
> relational database is painful, don't do it! Check out ObjectStore.
> Now part of Progress Software. http://www.objectstore.net/sourceforge
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel




-------------------------------------------------------
This SF.net email is sponsored by: eBay
Get office equipment for less on eBay!
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
