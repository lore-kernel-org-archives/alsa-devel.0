From: torben hohn <torbenh@gmx.de>
Subject: Re: Re: [Alsa-user] Re: Broken emu10k/SB Live driver?
Date: 11 Oct 2002 21:01:23 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E18038P-00086o-00@usw-sf-list1.sourceforge.net>
References: <200210110751.g9B7pcKa017014@mailgate2.uni-kl.de>
	<1034325263.474.37.camel@diesel>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1034325263.474.37.camel@diesel>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Martin Soto <soto@informatik.uni-kl.de>
Cc: alsa-dev <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On 11 Oct 2002 10:34:23 +0200, Martin Soto wrote:
> Hi all:
> 
> On Fri, 2002-10-11 at 11:53, torben hohn wrote:
> > > 
> > > > Does emu10k1 work at a user settable sample rate? 44100 Hz? 32000Hz?
> 
> I answer to the original poster first.  The Emu10k1 is *locked* at a
> 48Khz rate.  All sources and outputs will be converted to and from this
> rate for processing.  This was a very discussed and criticized design
> decision, but the EMU/Creative people argue it makes thinks easier (and
> certainly cheaper as well).

at least you dont have to deal with different samplerates (filter
coefficients)
when writing patches. 8-)



> 
> > > > MS Windows driver has a good sounding reverb. Could this reverb dsp
> > > > code be extracted from the MS Windows driver and used "as is" in Alsa?
> > > 
> > > It's not so easy and I'm sure that we'll violate some patent doing things 
> > > in this way.
> 
> A doubt it'd violate a patent, but it will violate the copyright of the
> code, for sure.
> 
> > There is a reverb in the oss driver from http://opensource.creative.com
> > it comes as source (i gues it is the same as the windows reverb)
> 
> It could be the same microcode.  Is it GPL'd?

no its not its a port of freeverb. and yes Freeverb is GPL.
i dont know if that url is still working:

-------------------------------snip


    FV10K1 release 0.2.1                    
    
    July 17, 2001

    Oleg Smirnov <smirnov@astron.nl>
    http://www.astron.nl/~smirnov/fv10k1
    

FV10K1 is a set of "surround sound" patches for the EMU10K1 processor,
found in the SoundBlaster Live! series of sound cards. You need the
emu10k1 Linux driver (http://opensource.creative.com) to run this code.

FV10K1 contains a port of Jezar Wakefield's Freeverb reverbration engine
(http://home.onet.co.uk/~jzracc/freeverb.htm). I have also developed my
own
patches for adding [directional] early room reflections, and some simple
programs to generate these patches given a room geometry.

This is very much alpha code, so don't expect a slick user interface or
any bells & whistles. In fact, unless you're a somewhat advanced
emu10k1 hacker, this code won't be of much use to you. I only developed
this because I use an SB Live! to play MP3s in my car, and I wanted to
take full advantage of the 4-speaker output to create surround effects.

I'm releasing this code because I'm hoping that (a) it might be useful
to you, and (b) maybe you can contribute to resolving some of the
issues (see the BUGS section at the end of this file).

This code is released under the terms of the GNU General Public License
version 2. Please see file COPYING for details. 

---------------------------------------------------snap

as10k1 is GPL also and contains some example dsp patches.



> 
> > so if we provide a method for the user to load patches into the dsp we
> > are fine.
> > i will query Martin Soto on his status.
> 
> Now, regarding my status:  I have a little example C program, that
> installs a new microcode (not really a patch but the whole microcode
> program) to the card.  It is not able to load standard patches, so you
> have to put the microcode directly inside the program.  I shamelessly
> stole some of the macros in emufx.c to be able to do that, but it works
> well ;-)

this is a nice method...
this would support compiling graphs into code quite good.
i think i will stop fighting threads a bit and add that into galan 0.2.


> The program deletes all of the mixer controls associated to the standard
> Alsa microcode, and puts in new controls if that's necessary.  
> It'd be really nice to have a decent interactive front end to this
> feature, because it would allow to reconfigure the mixer to offer just
> those controls that the user needs.  That would make SBLive! cards much
> more usable under Linux.
> 
> > (hi martin can you send me your patchloader code ?)
> 
> Unfortunately, I have the code at home, so I'll only be able to post to
> the list today evening (GMT+2).  I wanted to improve it a bit, but have
> been really busy at work lately, and haven't found any time to do it. 
> I'll post what I already have, and keep working on it as time permits.
> 
> I'm however attaching a small patch to emufx.c that fixes a bug in the
> implementation of the CODE_PEEK ioctl.  It must be applied to alsa in
> order for my userland program to work.

Torben Hohn
http://galan.sourceforge.net




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
