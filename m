From: Krzysztof Halasa <khc@pm.waw.pl>
Subject: Re: RFC: OSS driver removal, a slightly different approach
Date: Thu, 19 Jan 2006 21:24:44 +0100
Message-ID: <m3ek34vucz.fsf__6709.24527007646$1137702395$gmane$org@defiant.localdomain>
References: <20060119174600.GT19398@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from khc.piap.pl (khc.piap.pl [195.187.100.11])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id F158015E
	for <alsa-devel@alsa-project.org>; Thu, 19 Jan 2006 21:24:45 +0100 (MET)
In-Reply-To: <20060119174600.GT19398@stusta.de> (Adrian Bunk's message of "Thu, 19 Jan 2006 18:46:00 +0100")
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, perex@suse.cz
List-Id: alsa-devel@alsa-project.org

Adrian Bunk <bunk@stusta.de> writes:

> 1. ALSA drivers for the same hardware 

[ a list of relatively modern cards, mostly PCI-based ]

> 2. ALSA drivers for the same hardware with known problems

[ same here ]


> 3. no ALSA drivers for the same hardware
>
> SOUND_ACI_MIXER

Never heard

> SOUND_ADLIB

IIRC 8-bit sound, ISA. GUS on DOS used to emulate it

> SOUND_AEDSP16

Never heard

> SOUND_AU1550_AC97

Never heard but ac97 suggests it's not that old

> SOUND_BCM_CS4297A
> SOUND_HAL2
> SOUND_IT8172
> SOUND_KAHLUA

Kahlua is a liquor in Mexico named after some ancient (Mayan or Aztec)
deity :-)

> SOUND_MSNDCLAS
> SOUND_MSNDPIN

Turtle Beach, I think it's newer than (at least the original) GUS.

> SOUND_PAS

Pro Audio Spectrum. Earlier than GUS? 8-bit I think

> SOUND_PSS
> SOUND_SB

The original one (8-bit)? Not sure about relation to Kahlua and PAS

> SOUND_SH_DAC_AUDIO
> SOUND_TRIX
> SOUND_VIDC
> SOUND_VRC5477
> SOUND_VWSND
> SOUND_WAVEARTIST

Look strange.


Don't you all think a large part (if not most) of the "ALSA-unsupported"
cards is no longed in any (Linux-related) use? I wouldn't be surprised
if they just don't exist anymore. Who is to write drivers for them and -
more importantly - who can test them?

The oldest card I currently have is (the original) GUS, it has 16-bit
DACs (and 8-bit ADC) and it's long dead (never bothered to fix it but
I think it could be easy). And I see it would be supported.

My oldest working (or at least installed) card is SB64 ISA, and it's
supported too. Yes, I have few junk-grade machines here.
-- 
Krzysztof Halasa


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
