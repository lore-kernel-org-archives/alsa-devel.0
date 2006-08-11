From: "Markus Rechberger" <mrechberger@gmail.com>
Subject: Re: Line6 TonePort
Date: Sat, 12 Aug 2006 01:44:17 +0200
Message-ID: <d9def9db0608111644s22ab3361ob68011034fb8d502@mail.gmail.com>
References: <160c13350608100919yee3fc8p14096f59aa0071f7@mail.gmail.com>
	<1155316913.11766.268179999@webmail.messagingengine.com>
	<160c13350608111307w5a0778ffm4aa01046c95f1132@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <160c13350608111307w5a0778ffm4aa01046c95f1132@mail.gmail.com>
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
To: Stefano D'Angelo <zanga.mail@gmail.com>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi,

try to replay packets with a constant value like zero, you shouldn't
hear any noise then, try to vary with the packet size, and maybe use
USBSnoop for determining that (at least I was able to clearly
determine what's going on..) I have no serious experience with other
USB sniffers, I just used others but the outputs weren't as easy
readable as with USBSnoop.

Somehow I think we exactly have the same problem (but I almost solved my one..)
Do all packets have the same packetsize? My USB Device varies with that too..
After exactly 46 seconds I get some buzz too with my device at the
moment :( I couldn't determine any sync stuff there yet.. though I
haven't correctly implemented the record feature correctly yet which
might affect the other part as well .. let's see..



On 8/11/06, Stefano D'Angelo <zanga.mail@gmail.com> wrote:
> Markus: I use USB Snoopy Pro and I'm sure that packet sizes are ok, I'm just
> trying to do as the Windows' driver does.
>
> Clemens:
> > No USB device supports DMA transfers.  USB devices support USB transfers.
> > The host controller supports DMA transfers.  Yours does, too.

I thought so too it sound kinda strange...

> Well, I thought so. But I even modified snd-usb-audio driver (quirks + other
> code) to support this card and what I get out of it is the same thing I got
> when I tried with DMA on my own: a kind of buzz sound that sometimes
> continues after stopping the playback.

wrong device setup.

> As you can see from the code I posted I'm not going this way, I'm copying
> the data from runtime->dma_area into the URB transfer_buffer I allocate.
>

you have to do this anyway?! runtime->dma_area is alsa specific, and
transfer_buffer is USB specific

> > You should copy the data just before you submit the URB.  In other words,
> > yes.
> I copy and send in the same function, is it right?
>
> > How do you determine how much data to send in each USB frame?
> I use fixed sizes (as the windows' driver do). In snd_toneport.h each size
> is specified according to the different altsettings. Each URB has 2 isoch.
> packets of the same size.

could you also provide a 20 MB USBSnoop (not usb snoopy) logfile
(please zip it somewhere)

cheers,
Markus

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
