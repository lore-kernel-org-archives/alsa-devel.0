From: "Pieter Palmers" <pieter.palmers@student.kuleuven.ac.be>
Subject: RE: Sound Blaster 4.1 problem (ens1371)
Date: Thu, 16 Jan 2003 19:50:28 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <FLELKBEJMNABMIPKPAGMEECNDAAA.pieter.palmers@student.kuleuven.ac.be>
References: <Pine.LNX.4.33.0301142018210.541-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.33.0301142018210.541-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

The simulation approach still has a lot of bugs... so I tried another
approach.
I was reading the datasheets of the ENS-1371 chip, and I noticed that almost
all
configuration is done using IO space registers. So I wrote a little tool to
read
out the contents of these registers in Win98, along with the sample rate
converter
memory and the CODEC registers.
I started to play around with the settings of the SB and found out the
following:

* When switching from/to 4speaker mode register BASE+04h is altered as
follows:
                        v
B404:	24280EC0    0010 0100  0010 1000  0000 1110  1100 0000
                        ^
This bit (bit 26) gets set when in 4speaker mode.
(note: the format of the line is "IO addr: HEX result \t binary formatted
result")

* I also noticed that the windows volume control "Master" alters codec
registers
 0x02 (master volume) and 0x38 (surround out volume) simultaniously and
keeps them
at the same value.

* There seem to be differences in settings of the samplerate convertor
between windows
  and ALSA. Do we have any docs on this SRC?

I'm now going to try put these things in a little patch, and hopefully *1 is
the only
thing that's important.

Pieter



> -----Original Message-----
> From: alsa-devel-admin@lists.sourceforge.net
> [mailto:alsa-devel-admin@lists.sourceforge.net]On Behalf Of Jaroslav
> Kysela
> Sent: dinsdag 14 januari 2003 20:20
> To: Pieter Palmers
> Cc: alsa-devel@lists.sourceforge.net
> Subject: Re: [Alsa-devel] Sound Blaster 4.1 problem (ens1371)
>
>
> On Tue, 14 Jan 2003, Pieter Palmers wrote:
>
> > Anyway, the statement I wanted to make is: maybe I can use the
> same approach
> > to try spying on the ens1371. I already experienced that you
> can obtain a lot
> > of info fast if you know what you're looking for.
> >
> > Should you have any suggestions on how I should build/enhance
> the 'bridge',
> > they are very welcome. I'm new to linux driver design, and
> kernel level code.
>
> Thanks for explaining. Perhaps, you can log all accesses to i/o ports for
> ens1371 hardware from the windows drivers? It might be helpful - we can
> decode the init sequence.
>
> 						Jaroslav
>
> -----
> Jaroslav Kysela <perex@suse.cz>
> Linux Kernel Sound Maintainer
> ALSA Project, SuSE Labs
>
>
>
> -------------------------------------------------------
> This SF.NET email is sponsored by: Take your first step towards giving
> your online business a competitive advantage. Test-drive a Thawte SSL
> certificate - our easy online guide will show you how. Click here to get
> started: http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0027en
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel



-------------------------------------------------------
This SF.NET email is sponsored by: Thawte.com
Understand how to protect your customers personal information by implementing
SSL on your Apache Web Server. Click here to get our FREE Thawte Apache 
Guide: http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0029en
