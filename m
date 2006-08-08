From: Peter Oehry <peter.oehry@gmx.li>
Subject: Re: snd-usb-audio - Driver for M-Audio Fast Track Pro
Date: Tue, 8 Aug 2006 23:41:38 +0200
Message-ID: <20060808214138.419D4DE279@zeus.olymp.home>
References: <20060808181650.llg22g6lwgcs4c0s@zeus.oda.li>
	<1155056548.23266.267914050@webmail.messagingengine.com>
	<20060808184722.6627D55E2E7@zeus.olymp.home>
	<20060808222250.kgpv3965ss0oowoo@webmail.supelec.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <20060808222250.kgpv3965ss0oowoo@webmail.supelec.fr>
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

On Tue, 08 Aug 2006 22:22:50 +0200
Thibault Le Meur <Thibault.LeMeur@supelec.fr> wrote:

> > What I know from the manual is that the device can do
> >
> > either 4X4 (2 stereo in and 2 stereo out) in 16-Bit mode up to 48kHz
> > or 4x2 2 stereo in and 1 stero out in 24-Bit mode up to 48kHz
> > or 2X4 1 stereo in and 2 stereo out in 24-Bit mode up to 48kHz
> 
> Same thing for Audiophile USB.
> 
> 
> Yes looks like it is.... you can have a look at the patch I proposed, 
> you may find interresting info:
> 
> http://hg-mirror.alsa-project.org/alsa-kernel?cmd=changeset;node=4249e5ffdb3f;style=gitweb
> 
> Regards,
> Thibault
> 
> 

Thank you for all this information! I'll need some time to check what is needed for the Fast Track Pro. I think there is a big chance that many things are handled the same way like Audiophile. At least the number of Channels and also the mapping of digital an analog interfaces are the same. I tried to connect directly to the 24-Bit mode after startup of the USB device and I had the same "wrong" signal on both channels. This makes me positve to believe that the byte alignement (like you described) gets mixed up after mode switching. The distortion I head on both channels could have something to do with endianess. Instead of a sine wave I had a 3rd Harmonic at level of about -55dB (in the range of one byte) and the noise level was about -80dB (the range of the second byte).

Regards,
Peter

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
