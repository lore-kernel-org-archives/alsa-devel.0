From: "James Courtier-Dutton" <James@superbug.demon.co.uk>
Subject: RE: dolby digital output
Date: Sun, 17 Feb 2002 18:09:02 -0000
Message-ID: <NGBBLNODKDFPBFMBBFAFMEACCBAA.James@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: 7bit
In-Reply-To: <20020217184735.29659517.plail@web.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Markus Plail <plail@web.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>From what I understand, we can do ac3 "like" encoders in linux for free, and
they might actually make sounds come out on Commercial AC3 decoders, but
unless we pay a license fee, we cannot actually call it AC3.
This is why we now have the "liba52" decoder which just happens to work
quite nicely on ac3 input.

I don't see why we could not also do a liba52 encoder.
I think that if anyone started making a lot of money from liba52, then Dolby
would probably start asking for some royalties.
But there is no point in them making a fuss yet because there is no money
involved.

Cheers
James


> -----Original Message-----
> From: alsa-devel-admin@lists.sourceforge.net
> [mailto:alsa-devel-admin@lists.sourceforge.net]On Behalf Of Markus Plail
> Sent: 17 February 2002 17:48
> To: alsa-devel@lists.sourceforge.net
> Subject: Re: [Alsa-devel] dolby digital output
>
>
> Hi there!
>
> On Sun, 17 Feb 2002 18:15:55 +0100 Andy Lo-A-Foe wrote:
>
> > On Sun, Feb 17, 2002 at 01:33:32AM -0500, Hod McWuff wrote:
> >
> > > I'd imagine the first step would be to add an ac3 encoder, and then
> > > (possibly) the 2->5.1 channel demuxing for stereo streams. This would
> > > result in the ability to mix dolby digital streams (DVD's) with more
> > > mundane PCM streams, such as IM or telephony apps.
> >
> > None of the available open source software AC3 encoders are fast enough
> > to do realtime 5.1 encoding I think. The main task would be to try and
> > optimize this. Outputting compressed AC3 frames through alsa is probably
> > the easiest part (see http://www.alsaplayer.org for ac3play)
>
> Are there really any AC3 ENcoders? I thought only quite expensive
> (windows) software would be able to do that, because of Dolby's licensing.
> If there are any what would those be?
>
> Regards
> Markus Plail
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
