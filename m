From: Roger Williams <raw@qux.com>
Subject: Re: hdsp multiface pci.
Date: 19 Jan 2003 21:14:36 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <m3bs2ck1o3.fsf@grouper.coelacanth.com>
References: <3E2A952E.6060305@boosthardware.com>
	<1042985569.1663.33.camel@satellite.undata.org>
	<3E2AC45F.3070601@boosthardware.com>
	<1042992464.1649.55.camel@satellite.undata.org>
	<3E2AD34D.6070308@boosthardware.com>
	<m3d6mt9is6.fsf@grouper.coelacanth.com>
	<1042978893.1341.108.camel@Godzilla>
	<m3ptqskcay.fsf@grouper.coelacanth.com>
	<1042994069.1162.33.camel@Godzilla>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1042994069.1162.33.camel@Godzilla>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Mark Knecht <markknecht@attbi.com>
Cc: Alsa-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

>>>>> Mark Knecht <markknecht@attbi.com> writes:

  > This is very, very helpful.

What will be "very, very helpful" will be Thomas's TotalMix clone! :)

  > ... it appears that the MultiFace has a slightly different
  > numbering system for your analog channels, starting with 0-7
  > instead of what I think I have which starts with 1-8.

My "amixer controls" dump looks the same as yours.  I don't know what
"index=1" means, but it doesn't appear to mean that our cset indexing
begins at 1.  I've got to assume that Paul or Thomas already know
everything there is to know about the HDSP mixer, and I hate to
explore known territory, but when you don't have a map...

  > When you say 'appear to be numbered like this', how did you determine
  > this? Was it documented somewhere? Or did you have to test yourself?

Well, it matches Marcus Andersson's notes on the ALSA HDSP page:

    input_source: 0-7 (analog), 16-23 (adat), 24-25 (spdif), 26-51 (playback)
    output_source: 0-7 (analog), 16-23 (adat) 24-25 (spdif), 26-27 (line out)

I found "output_source" confusing, but it makes sense if I rename it
"destination".

  > The MultiFace has 18 inputs ... so I would have expected you to list:

Some of the numbering is discontinuous (because the Multiface doesn't
have the Digiface's ADAT2 range of channels), so the full Multiface
I/O list is:

Inputs to HDSP Mixer
========================================================================
Multiface analogue inputs 1-8      = amixer source channels 0-7
Multiface ADAT inputs 1-8          = amixer source channels 16-23
Multiface SPDIF input              = amixer source channels 24-25
alsa_pcm:playback_1-26             = amixer source channels 26-51

Outputs from HDSP Mixer
========================================================================
Multiface analogue outputs 1-8     = amixer destination channels 0-7
Multiface ADAT outputs 1-8         = amixer destination channels 16-23
Multiface SPDIF output             = amixer destination channels 24-25
Multiface line (headphone) output  = amixer destination channels 26-27

Mapping between Multiface inputs and alsa_pcm:capture channels
========================================================================
Multiface analogue inputs 1-8      = capture_1-8
Multiface ADAT inputs 1-8          = capture_9-16
Multiface SPDIF input              = capture_17-18

  > In my case I am guessing that my physical I/O numbering will be

  > HDSP 9652 ADAT-1 inputs 1-8	   = amixer source channels 1-8
  > HDSP 9652 ADAT-2 inputs 9-16   = amixer source channels 8-16
  > HDSP 9652 ADAT-3 inputs 17-24  = amixer source channels 17-24
  > HDSP 9652 s/pdif inputs 25-26  = amixer source channels 25-26

I'm pretty sure that the amixer ranges will be 0-7, 8-15, 16-23, and
24-25, respectively.  I believe that matches the Digiface (which also
has its analogue headphone output on 26-27, as I recall).

-- 
Roger Williams <raw@qux.com>
Qux Tool & Die, Middleborough, Massachusetts
// Omne tulit punctum qui misquit utile dulci //


-------------------------------------------------------
This SF.NET email is sponsored by: FREE  SSL Guide from Thawte
are you planning your Web Server Security? Click here to get a FREE
Thawte SSL guide and find the answers to all your  SSL security issues.
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0026en
