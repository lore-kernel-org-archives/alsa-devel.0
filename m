From: Mark Knecht <markknecht@attbi.com>
Subject: Re: hdsp multiface pci.
Date: 19 Jan 2003 19:59:45 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1043006386.1401.60.camel@Godzilla>
References: <3E2A952E.6060305@boosthardware.com>
	<1042985569.1663.33.camel@satellite.undata.org>
	<3E2AC45F.3070601@boosthardware.com>
	<1042992464.1649.55.camel@satellite.undata.org>
	<3E2AD34D.6070308@boosthardware.com>
	<m3d6mt9is6.fsf@grouper.coelacanth.com>
	<1042978893.1341.108.camel@Godzilla>
	<m3ptqskcay.fsf@grouper.coelacanth.com> <1042994069.1162.33.camel@Godzilla>
	 <m3bs2ck1o3.fsf@grouper.coelacanth.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <m3bs2ck1o3.fsf@grouper.coelacanth.com>
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

Roger,
   I think the light is just starting to turn on, or at least I can only
hope... ;-) See if you can help me improve the following description.

   I can think of my HDSP mixer as a device with 52 inputs and 26
outputs. The inputs look like:

1) 26 mixer inputs come from the HDSP's physical inputs 
- numbered 0-25 in the mixer
- called Alsa_pcm:capture_1 - 26 in Jack

2) 26 mixer inputs come from the Alsa:playback group
- numbered 26-51 in the mixer
- called Alsa_pcm:playback_1 - 26 in Jack

The outputs look like:

1) 26 mixer outputs come from the mixer
- numbered 0-25 out of the mixer

   By default, the HDSP driver then takes the Alsa_pcm:playback group
and hooks them to (more or less) matching output destinations:

Alsa_pcm:playback_1 -> HDSP Output 0
Alsa_pcm:playback_2 -> HDSP Output 1
...
Alsa_pcm:playback_26 -> HDSP Output 25

so that if I connect capture_1 to playback_1 then whatever comes in on
the ADAT-1, channel 0 input will get sent back out on ADAT-1, channel 1
output.

To test this idea, and using your headphone mix example, I should be
able to create a hardware monitoring setup by routing physical inputs
directory to physical outputs using something like this:

amixer cset numid=5 0,0,32768
amixer cset numid=5 1,1,32768
...
amixer cset numid=5 25,25,32768

which would route each physical input to each physical output, 1 for 1,
at a volume of unity gain. (As per Marcus's notes again.)

What is not at all clear yet is whether a single input can go to
multiple outs with different gains. For instance, if I execute:

amixer cset numid=5 0,0,10000
amixer cset numid=5 0,1,30000

I am attempting to take physical input 0 and sending it to both the left
and right outputs, but at different volumes. Is this legal? I'm not
sure.


In my case, I use Alsa_pcm:playback_1/2 for my main speakers, and
playback_3/4 for my headphones. The problem I've been having is that I
didn't know how to set the volume on my speakers with no mixer. Using
this information, I could execute:

amixer cset numid=5 26,0,3000
amixer cset numid=5 27,1,3000

and now my playback_1/2 should come out of my speakers, but at
considerably reduced volumes.

I'm going to stop and get feedback, as this is almost making sense. In
the meantime, I might as well try the commands above and see if my
speaker volume is under control.

Thanks very much for your help!

Cheers,
Mark


On Mon, 2003-01-20 at 02:14, Roger Williams wrote:
> >>>>> Mark Knecht <markknecht@attbi.com> writes:
> 
>   > This is very, very helpful.
> 
> What will be "very, very helpful" will be Thomas's TotalMix clone! :)
> 
>   > ... it appears that the MultiFace has a slightly different
>   > numbering system for your analog channels, starting with 0-7
>   > instead of what I think I have which starts with 1-8.
> 
> My "amixer controls" dump looks the same as yours.  I don't know what
> "index=1" means, but it doesn't appear to mean that our cset indexing
> begins at 1.  I've got to assume that Paul or Thomas already know
> everything there is to know about the HDSP mixer, and I hate to
> explore known territory, but when you don't have a map...
> 
>   > When you say 'appear to be numbered like this', how did you determine
>   > this? Was it documented somewhere? Or did you have to test yourself?
> 
> Well, it matches Marcus Andersson's notes on the ALSA HDSP page:
> 
>     input_source: 0-7 (analog), 16-23 (adat), 24-25 (spdif), 26-51 (playback)
>     output_source: 0-7 (analog), 16-23 (adat) 24-25 (spdif), 26-27 (line out)
> 
> I found "output_source" confusing, but it makes sense if I rename it
> "destination".
> 
>   > The MultiFace has 18 inputs ... so I would have expected you to list:
> 
> Some of the numbering is discontinuous (because the Multiface doesn't
> have the Digiface's ADAT2 range of channels), so the full Multiface
> I/O list is:
> 
> Inputs to HDSP Mixer
> ========================================================================
> Multiface analogue inputs 1-8      = amixer source channels 0-7
> Multiface ADAT inputs 1-8          = amixer source channels 16-23
> Multiface SPDIF input              = amixer source channels 24-25
> alsa_pcm:playback_1-26             = amixer source channels 26-51
> 
> Outputs from HDSP Mixer
> ========================================================================
> Multiface analogue outputs 1-8     = amixer destination channels 0-7
> Multiface ADAT outputs 1-8         = amixer destination channels 16-23
> Multiface SPDIF output             = amixer destination channels 24-25
> Multiface line (headphone) output  = amixer destination channels 26-27
> 
> Mapping between Multiface inputs and alsa_pcm:capture channels
> ========================================================================
> Multiface analogue inputs 1-8      = capture_1-8
> Multiface ADAT inputs 1-8          = capture_9-16
> Multiface SPDIF input              = capture_17-18
> 
>   > In my case I am guessing that my physical I/O numbering will be
> 
>   > HDSP 9652 ADAT-1 inputs 1-8	   = amixer source channels 1-8
>   > HDSP 9652 ADAT-2 inputs 9-16   = amixer source channels 8-16
>   > HDSP 9652 ADAT-3 inputs 17-24  = amixer source channels 17-24
>   > HDSP 9652 s/pdif inputs 25-26  = amixer source channels 25-26
> 
> I'm pretty sure that the amixer ranges will be 0-7, 8-15, 16-23, and
> 24-25, respectively.  I believe that matches the Digiface (which also
> has its analogue headphone output on 26-27, as I recall).
> 
> -- 
> Roger Williams <raw@qux.com>
> Qux Tool & Die, Middleborough, Massachusetts
> // Omne tulit punctum qui misquit utile dulci //
> 
> 
> -------------------------------------------------------
> This SF.NET email is sponsored by: FREE  SSL Guide from Thawte
> are you planning your Web Server Security? Click here to get a FREE
> Thawte SSL guide and find the answers to all your  SSL security issues.
> http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0026en
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel




-------------------------------------------------------
This SF.NET email is sponsored by: FREE  SSL Guide from Thawte
are you planning your Web Server Security? Click here to get a FREE
Thawte SSL guide and find the answers to all your  SSL security issues.
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0026en
