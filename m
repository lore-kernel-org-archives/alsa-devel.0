From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: Unsupported Realtek ALC260 (snd-hda-intel)
Date: Mon, 23 Oct 2006 23:31:34 -0700
Message-ID: <1161671494.6960.6.camel@razman>
References: <200610240510.k9O5A1X2007019@turbo.physics.adelaide.edu.au>
	<453DAD20.7030907@mcs.vuw.ac.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <453DAD20.7030907@mcs.vuw.ac.nz>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: David Friggens <david.friggens@mcs.vuw.ac.nz>
Cc: alsa-devel@lists.sourceforge.net, Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
List-Id: alsa-devel@alsa-project.org

Hang tight.  With this info we should be able to get a driver working
for you.  Fortunately, Realtek is one of the friendly companies, and all
of their specs are online.

Tobin

On Tue, 2006-10-24 at 19:05 +1300, David Friggens wrote:
> Hi Jonathan
> 
> > Could you also sent the output of lspci
> 
> 00:00.0 Host bridge: ATI Technologies Inc Unknown device 5a31 (rev 01)
> 00:01.0 PCI bridge: ATI Technologies Inc RS480 PCI Bridge
> 00:04.0 PCI bridge: ATI Technologies Inc RS480 PCI Bridge
> 00:05.0 PCI bridge: ATI Technologies Inc Unknown device 5a37
> 00:12.0 IDE interface: ATI Technologies Inc ATI 4379 Serial ATA
> Controller (rev 80)
> 00:13.0 USB Controller: ATI Technologies Inc IXP SB400 USB Host
> Controller (rev 80)
> 00:13.1 USB Controller: ATI Technologies Inc IXP SB400 USB Host
> Controller (rev 80)
> 00:13.2 USB Controller: ATI Technologies Inc IXP SB400 USB2 Host
> Controller (rev 80)
> 00:14.0 SMBus: ATI Technologies Inc IXP SB400 SMBus Controller (rev 83)
> 00:14.1 IDE interface: ATI Technologies Inc Standard Dual Channel PCI
> IDE Controller ATI (rev 80)
> 00:14.2 Audio device: ATI Technologies Inc SB450 HDA Audio (rev 01)
> 00:14.3 ISA bridge: ATI Technologies Inc IXP SB400 PCI-ISA Bridge (rev 80)
> 00:14.4 PCI bridge: ATI Technologies Inc IXP SB400 PCI-PCI Bridge (rev 80)
> 01:05.0 VGA compatible controller: ATI Technologies Inc RC410 [Radeon
> Xpress 200M]
> 02:00.0 Network controller: Broadcom Corporation BCM4310 UART (rev 01)
> 08:07.0 FireWire (IEEE 1394): Ricoh Co Ltd Unknown device 0832
> 08:07.1 Class 0805: Ricoh Co Ltd R5C822 SD/SDIO/MMC/MS/MSPro Host
> Adapter (rev 19)
> 08:07.2 System peripheral: Ricoh Co Ltd Unknown device 0843 (rev 01)
> 08:07.3 System peripheral: Ricoh Co Ltd R5C592 Memory Stick Bus Host
> Adapter (rev 0a)
> 08:08.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
> RTL-8139/8139C/8139C+ (rev 10)
> 
> > It would seem that both the headphone jack and the internal speaker are
> > being driven by an amplifier outside the ALC260 which is switched on using
> > mechanisms independent of the ALC260 chip itself.  This would be the second
> > laptop we've encountered with a similar issue - even though everything's
> > up these two outputs refuse to produce any sound.
> 
> :-( I suppose it's unlikely that writing to Realtek and/or HP would be
> fruitful.
> 
> > Final thought for the day: could you use alsamixer to change all the
> > pin modes to "Line-in" and then back to "Line-out" or "headphones".  Then
> > try the tests again and see if you get audio from any additional jacks or
> > the internal speaker.
> 
> No change unfortunately. Audio comes only from the mic jack both with
> everything set to Line-out or to Headphone. (The only difference is some
> additional static when MIC1 pin mode is set to headphone.)
> 
> Cheers
> David
> 
> -------------------------------------------------------------------------
> Using Tomcat but need to do more? Need to support web services, security?
> Get stuff done quickly with pre-integrated technology to make your job easier
> Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
-- 
Tobin Davis <tdavis@dsl-only.net>


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
