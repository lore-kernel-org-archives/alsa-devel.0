From: Sampo Savolainen <v2@iki.fi>
Subject: Re: M-Audio USB Quattro on 2.6.x
Date: Mon, 16 Feb 2004 19:52:38 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1076953958.683.52.camel@puppeli>
References: <1076950250.683.38.camel@puppeli>
	 <20040216172919.GA3305@fliwatut.scifi>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20040216172919.GA3305@fliwatut.scifi>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Frank Barknecht <fbar@footils.org>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hello,

I contacted the tech support at usb.org. I got in touch with a man
called Mark Paxson from USB-IF Compliance. I described the problem we
are having with the Quattro. I quote from his answer:

> Does the device you identify carry the USB-IF logo as displayed at the
> top of the USB.ORG website http://www.usb.org/home?  If so, they are
> in violation and the USB-IF can contact them.

To which I sent pictures of the Quattro, and the answer was:

> The icon they are using is called the USB Trident and is part of the
> USB specification for identifying a USB port. You are correct in that
> they are not in violation of a license agreement for using that icon. 
> So there's not much the USB-IF can do in regard to their
> non-compliance.

In short, they do not have the authority to force M-Audio to change the
behaviour of the device. So, if M-Audio doesn't supply firmware updates,
we have to select one of these:

 a) Stick with 2.4.x
 b) Try to reverse engineer the firmware. Which is almost impossible,
    because I do not know of any tools to get firmware out of the device
    or if the Quattro even supports firmware updates.
 c) Get 2.6.x to accept the device despite the strange settings.


 Sampo Savolainen


On Mon, 2004-02-16 at 19:29, Frank Barknecht wrote:
> Hallo,
> Sampo Savolainen hat gesagt: // Sampo Savolainen wrote:
> 
> > As most of you who have seen the words "USB Quattro" and "2.6.x"
> > together know, these two don't mix well. I have been investigating this
> > issue for some time and here are a few conclusions:
> > 
> ... 
> >  3. USB-IF says that M-Audio are violating the specs, but they can't
> >     force them to correct these issues because the USB logo is not
> >     on the device (that requires licensing and compliance). Only the
> >     USB trident is on the box, and that doesn't apply.
> 
> You did ask USB-IF? Is there something like an "official" statement by
> the forum somewhere? 
> 
> ciao



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
