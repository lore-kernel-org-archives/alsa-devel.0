From: "Mark Knecht" <mknecht@controlnet.com>
Subject: RE: RME HDSP 9632 driver
Date: Mon, 11 Aug 2003 11:14:43 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <NDBBLGIKBJENLAMOLFHGGECOCPAB.mknecht@controlnet.com>
References: <200308111346.46372.chris@realcomputerguy.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200308111346.46372.chris@realcomputerguy.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Chris Smith <chris@realcomputerguy.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi Chris.

> >    My problem right now with the HDSP 9652 is that the audio
> starts fine,
> > then cuts out completely, then comes back, making the card unusable. I
> > expect we'll find a solution to this one of these days soon.
>
> That's a show stopper. Is this both recording and playback?

It's a complete show stopper right now, but I am sure we will find a
solution very soon. Thomas has made great headway in just the last week. He
codes, I test. It's gone for 0% operation to quite a lot of functionality. A
little support from RME and I'm pretty sure we'll be there soon.

I think it's just the output of the card. While I haven't recorded actually
anything to disk using the card recently, all indications in hdspmixer are
that recording should be fine. Inputs and playback never stop in the
display, while the outputs do.

> How
> long does it
> take before the audio cuts out?

Sometimes just seconds. Seldom more than a minute. It's random and makes the
card unusable right now.

> And then how long before it comes
> back?

Same as above.

> Does
> the wordlength or sample-rate affect the results? Is it application
> dependent? Is it port sensitive?

Word length I do not know. I will say that OSS emulation (I think) and mono
wave files do not seem to trigger the problem on my card. I.e. - most simple
games will play sound all night with no problem. Mono wave files will play
all night. Stereo wave files played by aplay will kill it almost immediately
right now. I have not specifically tested the difference between 16-bit and
24-bit. I will, just to see what happens.


>
> More importantly is this a known issue that others are having as
> well?

I do not know of any other Linux-based HDSP 9652 users right now. Paul Davis
has one, but I do not think he's using it much. Other than that I do not
know right now. I think that when we get this solved we will find more
interested people. It's a great card under Windows.

> If so
> is it only with the HDSP 9652?

As far as I know, yes. And possibly only my HDSP 9652, or possibly only my
PC. However, I think it's a Linux driver issue of some type as the cord
works fine in the same machine under Windows ME. We do not have enough test
data to say one way or the other.


> Have you brought the firmware up
> to the latest
> level (is Windows absolutely needed for this?)?

Yep, and yep. To upgrade or downgrade firmware on this card you must be
under Windows and RME drivers for the current firmware revision must be
loaded.

>
> >    I will be very interested to see if your 9632 has any
> similar problems or
> > not.
>
> I have a Multiface with the PCI card in stock but not an HDSP
> 9652 or I would
> attempt to test it for you. Will certainly let you know if there
> are any such
> issues.

Oh, I thought you actually had the HDSP 9632. I guess you were just checking
for support? Or do you have the HDSP 9632 AND the MultiFace?

Are you a dealer? (The 'in stock' comment.)

I do not think these problems affect the MultiFace or DigiFace products.
Just the HDSP 9652.

- Mark




-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
