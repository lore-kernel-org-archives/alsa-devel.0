From: Mark Knecht <markknecht@attbi.com>
Subject: Re: hdsp multiface pci.
Date: 19 Jan 2003 12:21:32 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1042978893.1341.108.camel@Godzilla>
References: <3E2A952E.6060305@boosthardware.com>
	<1042985569.1663.33.camel@satellite.undata.org>
	<3E2AC45F.3070601@boosthardware.com>
	<1042992464.1649.55.camel@satellite.undata.org>
	<3E2AD34D.6070308@boosthardware.com>
	<m3d6mt9is6.fsf@grouper.coelacanth.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <m3d6mt9is6.fsf@grouper.coelacanth.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Roger Williams <raw@qux.com>
Cc: Alsa-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Sun, 2003-01-19 at 17:00, Roger Williams wrote:
> >>>>> Patrick Shirkey <pshirkey@boosthardware.com> writes:
> 
>   > Can we route multiple software outputs to the same hardware output?
> 
> Yes.  For instance, when recording 8 tracks, I'll generate a monitor
> mix (for JACK's outputs) to outputs 1 & 2 like this:
> 
> amixer cset numid=5 26,26,16384
> amixer cset numid=5 28,26,16384
> amixer cset numid=5 30,26,16384
> amixer cset numid=5 32,26,16384
> amixer cset numid=5 27,27,16384
> amixer cset numid=5 29,27,16384
> amixer cset numid=5 31,27,16384
> amixer cset numid=5 33,27,16384
> 
> -- 

Roger,
   OK, I just don't get it yet. This is from the Alsa page on the HDSP
cards:

*************
Since the Multiface only have 18 i/o channels, the channel mapping in
the matrix mixer is different from the Digiface when operating at 48kHz
or lower.

[Ed. This is a routing table]

input_source: 0-7 (analog), 16-23 (adat), 24-25 (spdif), 26-51
(playback)
output_source: 0-7 (analog), 16-23 (adat) 24-25 (spdif), 26-27 (line
out)
*************


In your example above, is the use of 26 and 27 on the output part of the
command telling the hardware to route whatever it is that you're mixing
to the line out connectors on your box? 

Second, where do the inputs numbered 26-33 come from. I can't figure
this part out. Are they outputs from the HDSP hardware mixer? Or do they
mean from physical inputs? (somehow renumbered) This is the part I don't
get right now.

I presume that your use of 16384 is to reduce volume so that after
summing 4 channels you do not create output clipping if all the inputs
hit maximum volume at the same time?


QUESTION - If you wanted to route input 0 directly to an output, could
you use a command like:

amixer cset numid=5 0,26,16384
amixer cset numid=5 1,27,16384



I think my HDSP 9652 will have different numbering since I have a
different number of I/O's on the card, but I want to understand your
example since it seems like a good one.

Thanks,
Mark



-------------------------------------------------------
This SF.NET email is sponsored by: FREE  SSL Guide from Thawte
are you planning your Web Server Security? Click here to get a FREE
Thawte SSL guide and find the answers to all your  SSL security issues.
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0026en
