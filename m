From: Mark Knecht <markknecht@attbi.com>
Subject: Re: hdsp multiface pci.
Date: 19 Jan 2003 16:34:27 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1042994069.1162.33.camel@Godzilla>
References: <3E2A952E.6060305@boosthardware.com>
	<1042985569.1663.33.camel@satellite.undata.org>
	<3E2AC45F.3070601@boosthardware.com>
	<1042992464.1649.55.camel@satellite.undata.org>
	<3E2AD34D.6070308@boosthardware.com>
	<m3d6mt9is6.fsf@grouper.coelacanth.com>
	<1042978893.1341.108.camel@Godzilla>
	<m3ptqskcay.fsf@grouper.coelacanth.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <m3ptqskcay.fsf@grouper.coelacanth.com>
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
   This is very, very helpful. Thanks for sharing this info. I am trying
to do similar things with the HDSP 9652, which is similar but a bit
different, I'd like to address a couple more things. (Darn...Tennessee
just scored!) :-(((  7-7

   I just want to clearly understand the physical I/O numbering right
now. Once I've got that I'll ask you a couple of questions about the
mixer if I may.

   OK, it appears that the MultiFace has a slightly different numbering
system for your analog channels, starting with 0-7 instead of what I
think I have which starts with 1-8. Is this correct?

   If I look at the HDSP amixer info, I seem to start with an index of
1, not 0. Am I looking at the right stuff? (I've done some sorting to
make this more readable to me. I have this initial section with 9
controls, and then 26 sections that are identical to the second area I
show below, indexing from 1-26. I presume that your first one would
start with index=0?

[mark@Godzilla mark]$ amixer controls
numid=1,iface=PCM,name='IEC958 Playback Default'
numid=3,iface=MIXER,name='IEC958 Playback Con Mask'
numid=4,iface=MIXER,name='IEC958 Playback Pro Mask'
numid=5,iface=PCM,name='Mixer'
numid=6,iface=PCM,name='IEC958 Input Connector'
numid=7,iface=PCM,name='IEC958 Output also on ADAT1'
numid=8,iface=PCM,name='Preferred Sync Source'
numid=9,iface=PCM,name='Passthru'
numid=10,iface=PCM,name='Line Out'


numid=11,iface=MIXER,name='Chn',index=1
numid=12,iface=PCM,name='Input Peak',index=1
numid=13,iface=PCM,name='Output Peak',index=1
numid=14,iface=PCM,name='Playback Peak',index=1
numid=15,iface=PCM,name='Playback RMS',index=1
numid=16,iface=PCM,name='Input RMS',index=1




On Sun, 2003-01-19 at 22:24, Roger Williams wrote:
> >>>>> Mark Knecht <markknecht@attbi.com> writes:
>   > Second, where do the inputs numbered 26-33 come from.
> 
> As far as the Multiface's analogue I/O goes, channels appear to be
> numbered like this:

When you say 'appear to be numbered like this', how did you determine
this? Was it documented somewhere? Or did you have to test yourself?

> 
> Multiface inputs 1-8               = amixer source channels 0-7
> Multiface outputs 1-8              = amixer destination channels 0-7
> Multiface line (headphone) outputs = amixer destination channels 26-27
> alsa_pcm:playback_1-8              = amixer source channels 26-33
> 

OK, here's where you throw me. Let me list out what I thought I knew
about the MultiFace, and then correct me where I'm wrong please.

The MultiFace has 18 inputs - 8 analog, 8 ADAT, 2 s/pdif, and 20 outputs
(including the Headphone outs if they are really separate from
everything else. They may not be...) so I would have expected you to
list:

(Yea!!! Raiders score! 14-7)

MultiFace analog inputs 1-8	= amixer source channels 0-7
MultiFace ADAT inputs 9-16	= amixer source channels W-X (8-16?)
MultiFace s/pdif inputs 17-18	= amixer source channels Y-Z (17-18?)

Basically, to use the 18 inputs, they all must have unique numbers.
Correct?

MultiFace analog outputs 1-8	= amixer dest. channels 0-7
MultiFace ADAT outputs 9-16	= amixer dest. channels W-X (8-16?)
MultiFace s/pdif outputs 17-18	= amixer dest. channels Y-Z (17-18?)
MultiFace Line outputs 1-2	= amixer dest. channels 26-27

Maybe all of the features of the MultiFace not actually supported in the
current driver, so you didn't list them, or maybe you just didn't use
them, so you didn't write them down?

In my case I am guessing that my physical I/O numbering will be as
follows:

HDSP 9652 ADAT-1 inputs 1-8	= amixer source channels 1-8
HDSP 9652 ADAT-2 inputs 9-16	= amixer source channels 8-16
HDSP 9652 ADAT-3 inputs 17-24	= amixer source channels 17-24
HDSP 9652 s/pdif inputs 25-26	= amixer source channels 25-26

and similar numbering for the outputs.

Do you think this is right? Any other thoughts or comments?

Thanks,
Mark




-------------------------------------------------------
This SF.NET email is sponsored by: FREE  SSL Guide from Thawte
are you planning your Web Server Security? Click here to get a FREE
Thawte SSL guide and find the answers to all your  SSL security issues.
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0026en
