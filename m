From: "John W. Cocula" <john@cocula.com>
Subject: Re: [Alsa-user] USB audio device that works for recording?
Date: Tue, 3 Feb 2004 01:16:30 -0500 (EST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <65074.138.88.11.209.1075788990.squirrel@cocula.com>
References: <200402021956.18642.moron@industrial.org>
Mime-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200402021956.18642.moron@industrial.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: moron <moron@industrial.org>
Cc: alsa-user@lists.sourceforge.net, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

My suggestion might be blasphemous to the true audio professionals, but I
have been very pleased overall so far with my Soundblaster Audigy 2 NX
device.  It has the potential to do 96KHz, 24-bit playback and capture.  I
have recorded at 48KHz 16-bit from its line in jack, and the quality was
excellent.  And while I was playing back 48KHz 16-bit at the same time. 
And only at USB 1.1 full-speed isochronous.

Concerning USB 2.0, I have upgraded the NX's firmware to the 12/23/03
level that should support USB 2.0, but it's still a 1.1 device under
kernel 2.4.22.

Does anyone have this device working as USB 2.0 on Linux?  One possible
explanation is that kernel 2.4.22's USB drivers don't have "other speed"
(USB_DT_OTHER_SPEED_CONFIG) support, and Creative might have implemented
support for USB 2.0 this way.  A later 2.4 or 2.6 kernel might "just work"
at USB 2.0, or does the snd-usb-audio driver have to get involved in this
negotiation?

Thanks!
John



moron said:
> Howdy.  I have been futzing around with my M-Audiophile USB for way too
> long
> now trying to get it to work reliably under Linux and as luck would have
> it,
> my old Windows install blew up today so now I am totally fubar for
> recording
> my tracks until I get this fixed.
>
> Since the Audiophile USB does not work for recording and is proving flakey
> for
> playback regardless (works sometimes, not others and I do not know why) I
> am
> curious if anyone has any recommendations for USB audio interfaces that
> will
> work with the 2.6 kernel as well as ALSA?  My requirements are simple:
> stereo
> in / out with decent sound quality (CD is good enough but must have low
> noise
> floor).  MIDI would be nice but for now just being able to record my live
> griefer sessions would be enough to tide me over.
>
> I do not want to go for a PCI solution as I expect PCI to go away soon and
> USB
> is portable to any machine I have now or will have in the future.
>
> I am thinking one of the simple Edirol UA* interfaces would do but I would
> like to hear feedback from folks using stuff for recording specifically
> before wasting more money on a non-compliant, poorly supported interface.
>
> Thanks in advance for any suggestions.
>
> It so sucks that the Audiophile USB is problematic as the sound quality is
> awesome.  Too bad the company is so unsupportive of Linux.
>
> Cheers
>
> --
> ---> (culture) http://industrial.org : (label)  http://deterrent.net
> ---> (community) http://ampfea.org : (hire me) http://codegrunt.com
> ---> (send EEEI news to) infosuck@industrial.org
> ---> Whomever dies with the most URLs wins!!!!!!!!!!!!!
>
>
>
> -------------------------------------------------------
> The SF.Net email is sponsored by EclipseCon 2004
> Premiere Conference on Open Tools Development and Integration
> See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
> http://www.eclipsecon.org/osdn
> _______________________________________________
> Alsa-user mailing list
> Alsa-user@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-user
>



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
