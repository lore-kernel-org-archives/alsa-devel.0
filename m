From: Thibault Le Meur <Thibault.LeMeur@supelec.fr>
Subject: Re: snd-usb-audio - Driver for M-Audio Fast Track Pro
Date: Tue, 08 Aug 2006 22:22:50 +0200
Message-ID: <20060808222250.kgpv3965ss0oowoo@webmail.supelec.fr>
References: <20060808181650.llg22g6lwgcs4c0s@zeus.oda.li>
	<1155056548.23266.267914050@webmail.messagingengine.com>
	<20060808184722.6627D55E2E7@zeus.olymp.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <20060808184722.6627D55E2E7@zeus.olymp.home>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Peter Oehry <peter.oehry@gmx.li>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> What I know from the manual is that the device can do
>
> either 4X4 (2 stereo in and 2 stereo out) in 16-Bit mode up to 48kHz
> or 4x2 2 stereo in and 1 stero out in 24-Bit mode up to 48kHz
> or 2X4 1 stereo in and 2 stereo out in 24-Bit mode up to 48kHz

Same thing for Audiophile USB.

> some more limitations are present when using higher sampling rates up 
> to 96kHz
> thus I belive that normally in 24-Bit mode the alternate settings 3 
> and 6 should not
> be used. At least I had no output witch setting 3 and I had an output 
> with setting 2.

I had to find out which mapping is used for my device as well. I used 
usb sniff under windows and played with the M-Audio control panel... My 
conclusions are described in Documentation/Audiophile-Usb.txt which can 
give you ideas about how M-Audio implements usb interfaces.

>
> Do you know which calls are necessary to switch the config of a usb device?

In my case I use a device_setup parameter at the module initialization, 
because it seems that switching from AltSettings corresponding to 
16bits endpoints to  AltSettings corresponding to 24bits endpoints 
causes allignment errors.

> I have to investigate this further. It can not be a general problem 
> because the 16-Bit mode is working. But it can be that the alignment 
> of 24-Bit is different.

Yes looks like it is.... you can have a look at the patch I proposed, 
you may find interresting info:

http://hg-mirror.alsa-project.org/alsa-kernel?cmd=changeset;node=4249e5ffdb3f;style=gitweb

Regards,
Thibault


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
