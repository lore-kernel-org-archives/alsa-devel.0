From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Re: snd-usb-audio: quirk for Edirol UA-5 in Advanced
 Mode
Date: Thu, 12 Jun 2003 10:18:06 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0306120954450.13924-100000@studcom.urz.uni-halle.de>
References: <Pine.LNX.4.44.0306112244350.10270-100000@kani-keli.alnet.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <Pine.LNX.4.44.0306112244350.10270-100000@kani-keli.alnet.home>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Stephane Alnet <alsa-dev@shimaore.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Stephane Alnet wrote:
> On Tue, 10 Jun 2003, Stephane Alnet wrote:
> > (Hopefully this is the right place to post this!)
> >
> > Attached is a diff file for the Edirol UA-5 Advanced Mode against kernel
> > 2.5.70-bk14 sound/usb.

I didn't see your first post (maybe because the current list moderator
is Dave Null), so I'm only guessing what your diff did.

> > I added a new QUIRK mode (QUIRK_AUDIOSTREAM_INTERFACE) which basically
> > forces an interface (and its altsettings) into Audio/AudioStream. When in
> > Advanced Mode, the UA-5 exposes all its interfaces in class 255/255
> > (Vendor/Vendor), but actually besides this all the descriptors are valid
> > USB Audio control/interfaces/endpoints/... So this quirk simply overwrites
> > the streaming interfaces class/subclass with the proper values. (My
> > understanding is that we don't need to care about the audiocontrol
> > interface.)

There already is a quirk type for this, QUIRK_STANDARD_INTERFACE. See
the quirk entry for the UA-20, which behaves in the same way (the
UA-20's interface #3 is for the MIDI ports).


Regards,
Clemens




-------------------------------------------------------
This SF.NET email is sponsored by: eBay
Great deals on office technology -- on eBay now! Click here:
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
