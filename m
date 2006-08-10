From: Peter Oehry <peter.oehry@gmx.li>
Subject: Re: snd-usb-audio - Driver for M-Audio Fast Track Pro
Date: Thu, 10 Aug 2006 23:33:40 +0200
Message-ID: <20060810213340.A53144FA617@zeus.olymp.home>
References: <20060808181650.llg22g6lwgcs4c0s@zeus.oda.li>
	<1155056548.23266.267914050@webmail.messagingengine.com>
	<20060808184722.6627D55E2E7@zeus.olymp.home>
	<20060808222250.kgpv3965ss0oowoo@webmail.supelec.fr>
	<20060808214138.419D4DE279@zeus.olymp.home>
	<20060809000741.7zournuj4c0wcwc8@webmail.supelec.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <20060809000741.7zournuj4c0wcwc8@webmail.supelec.fr>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Thibault Le Meur <Thibault.LeMeur@supelec.fr>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> > I'll need some time to check what is needed for the Fast Track Pro.
> 
> In fact it's not that tricky: just install a usb sniffer under windows, 
> then play with the control panel and check the SELECT_INTERFACE 
> messages for Interface/AlternateSetting. With the audiophile USB, it 
> only changes:
> * if you change the bit depth
> * if you change the sampling rate
> * if you enable/disable the SPDIF input
> 

I'll do some investigations on that this weekend.

> > I think there is a big chance that many things are handled the same 
> > way like Audiophile. At least the number of Channels and also the 
> > mapping of digital an analog interfaces are the same. I tried to 
> > connect directly to the 24-Bit mode after startup of the USB device 
> > and I had the same "wrong" signal on both channels. This makes me 
> > positve to believe that the byte alignement (like you described) gets 
> > mixed up after mode switching.
> 
> Yes that sounds exactly the same...
> 
> > The distortion I head on both channels could have something to do 
> > with endianess. Instead of a sine wave I had a 3rd Harmonic at level 
> > of about -55dB (in the range of one byte) and the noise level was 
> > about -80dB (the range of the second byte).
> 

I can say now a bit more about the actual signal I get. It has not only to do
with little or big endian.

One problem is that it is dependant on something todo with initialisation. So
the signal I get is not allways the same. Sometimes even the working 16-Bit 
signal is messed up. We talked about that the byte ordering might be mixed up.

Basically I got to differt sorts of signals. I recorded a sine and looked at the actual samples.
Lets assume that if we have little endian the right samples would be organised
like that:
L1-L2-L3 R1-R2-R3 
(L1 is left least significant byte and R3 is right most sig. byte)
Can someone comfirm that this would be right?

wat I get look like that:
L3-L3-L3 R3-R3-R3 in one case and
L3-L2-L3 R2-R3-R2 in the other case 

the second case is nearly right for the left chanel. In many case you won't be able
to hear the wrong byte in the least significat position. But what I can say for shure
is that all wrong signals are not wrong because of byte alignment.

Sometimes I'm not shure who (which application) I can believe or not. Does anybody
now a way to check what realy comes from the USB device?

Regards,
Peter







-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
