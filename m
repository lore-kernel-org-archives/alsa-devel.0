From: Sampo Savolainen <v2@iki.fi>
Subject: Re: [linux-usb-devel] M-Audio USB Quattro on 2.6.x
Date: Mon, 16 Feb 2004 20:33:57 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1076956436.683.88.camel@puppeli>
References: <Pine.LNX.4.44L0.0402161233140.1490-100000@ida.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44L0.0402161233140.1490-100000@ida.rowland.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>, linux-usb-devel <linux-usb-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Mon, 2004-02-16 at 19:50, Alan Stern wrote:
> You didn't say exactly what the Quattro is doing wrong.  I can guess that 
> it doesn't number its altsettings sequentially starting from 0.  Is that 
> right?

Oops. I forgot that.

Yes, it's an alternate setting numbering issue.

> Yes, although in your case the only driver in question is snd_usb_audio.  
> You might also have trouble trying to read /proc/bus/usb/devices.

lsusb works fine, and I can read /proc/bus/usb/devices very well.
Actually, lsbus and /proc/bus/usb still shows the Quattro, even after
disconnecting it.

Also something I forgot: The kernel won't find ANY usb device after
disconnecting, not even on another controller than the one that the
Quattro was attached to.

> As you've seen, the problem isn't so easy to solve.  Yes, the USB core can
> be patched as you've done to accept devices that number their altsettings
> incorrectly.  Unforunately, there are many device drivers that assume the
> numbering is done right.  They try to access the data for altsetting n by
> looking at position n in the array of altsettings -- with your alterations
> that won't work.  Unless you can change those drivers as well as the core,
> you will run into exactly the sort of thing you're seeing here.
> 
> There hasn't been much call for making the kernel allow out-of-spec
> altsetting numbers; the vast majority of devices seem to get this right.
> Maybe if enough people really want it, it will be added in.

I know of at least two "USB" soundcards that have this problem. At least
M-Audios Quattro and Audiophile. Probably both of them would work if
this patch would be applied to the kernel with a correction to the
snd_usb_audio driver. For us audiogeeks this would be wonderful news.

On the other hand. I do not know enough about linux-usb development. So
I don't know what kind of issues this patch could create.

I haven't asked around, so I do not know how many people need this, but
I have been in touch with at least three others who use this hardware on
Linux. I think I'm speaking for everyone (of us four...) when I say we
really, really, want this feature!

(Before I get really excited, this patch has to be tested more
strenuously before adding it in)

Meanwhile, I'll try to find someone on the alsa side to help me find the
problem in snd_usb_audio. Just to make sure, your opinion is that the
patch is fine and the problem is on the driver side?


 Thanks for the help,
   Sampo Savolainen




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
