From: Manuel Jander <manuel.jander@usm.cl>
Subject: Re: The ALSA Situation
Date: Fri, 12 Nov 2004 22:15:01 -0300
Message-ID: <1100308501.2337.54.camel@localhost>
References: <200411102113.iAALDLUN001061@localhost.localdomain>
	 <Pine.LNX.4.58.0411101426260.2301@ppc970.osdl.org>
	 <Pine.LNX.4.58.0411110714280.2179@pnote.perex-int.cz>
	 <Pine.LNX.4.58.0411102241240.2301@ppc970.osdl.org>
	 <s5his8cfiot.wl@alsa2.suse.de>
	 <Pine.LNX.4.58.0411110855380.2301@ppc970.osdl.org>
	 <s5hhdnwfgbz.wl@alsa2.suse.de>
	 <Pine.LNX.4.58.0411111021520.2301@ppc970.osdl.org>
	 <s5hekizfo0n.wl@alsa2.suse.de>
	 <Pine.LNX.4.58.0411120741300.2301@ppc970.osdl.org>
	 <20041112230617.41c5073e@mango.fruits.de>
Reply-To: mjander@users.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20041112230617.41c5073e@mango.fruits.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Florian Schmidt <mista.tapas@gmx.net>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi,

On Fri, 2004-11-12 at 23:06 +0100, Florian Schmidt wrote:
> On Fri, 12 Nov 2004 07:50:58 -0800 (PST) 
> > My arguments have really been against blocking. And to some degree an 
> > argument against people thinking it's _good_ to set individual parameters. 
> 
> Historically seen there's a long tradition for sound applications to choose
> their own parameters as different applications serve vastly different
> purposes and thus imply different paramaters to be used.

Nowadays, with so many different hardware around (USB, PCI, ISA,
firewire, etc), it may even happen that two soundcards have mutually
exclusive settings, in other words, you may not able to find a period
number and period size setting that will work on both. Forget about
trying some period setup that will work on every soundcard, even those
still not invented. That is absolutely  nonsense in my opinion. This bad
assumption should be put to an end as soon as possible, if not things
will (they actually are now) very messy, in regard of soundcard
parameter selection.

By now, the only solution i can think of, is doing some measurements at
startup, to determine the feasible period size/count bounds, without
xruns.

> A low latency realtime effects box program will need completely different
> periodsize and periodcount settings than a program without realtime needs
> like a highly reliable harddisc recorder. The former will use a very small
> periodsize and a periodcount of 2 (or the minimum available by the hw), the
> latter will use the opposite (large periodsizes and a high periodcount).

I agree. But again, this is highly hardware dependant, and some setting
may work splendid on your computer, but maybe wont on mine. Even using
the same soundcard, because even the system bus characteristics may
influence a lot.

> The need for software mixing is somewhat orthogonal to this, as it enforces
> a particular set of settings on all programs using this software mixing
> device. The software mixing device might still allow the programs to use
> their own set of parameters, but this would require some sort of
> conversion/translation (and of course a program, using a periodsize/count
> smaller than the ones the software mixing device uses to communicate with
> the hw, doesn't gain anything by doing so).

Application should not need to care about buffer setup. If they do, the
chance to fail is very high; in other words: flaky.
Sometimes things are not optimal, but its better to be sure that it will
work without xruns.

> For compatibility issues this translation/conversion is a must and since
> ALSA aims to provide full compatibility for OSS apps, the software mixing
> and conversion must be available to the OSS emulation layer as well.
> 
> The current "ALSA situation" looks like follows (correct me people if i talk
> BS):
> 
> 1. ALSA infrastructure kernel modules (pcm, seq, ctl, other voodoo stuff)
> 2. ALSA driver modules (using 1.)
> 3. ALSA OSS emulation modules (using 2. used directly by OSS apps)
> 4. ALSA-lib (using 2. used by ALSA apps)
> 5. ALSA-oss-lib (using 4. LD_PRELOAD hack to make OSS apps use ALSA-lib)
> 
> ALSA does provide software mixing and conversion routines. But these reside
> in ALSA-lib, thus to make use of them systemwide, both ALSA apps and OSS
> apps need to go through ALSA-lib. This is a natural thing for ALSA apps as
> it was designed this way. For OSS apps one needs to use the ALSA-oss-lib
> (5]), which is a hack and doesn't work with all OSS apps, as there is no way
> to LD_PRELOAD symbols which are not resolved at runtime (excuse my possibly
> wrong terminology).
> 
> IMHO it would be better to have the software mixing and conversion code in a
> place where the ALSA OSS emulation modules can make use of them. I don't
> know how feasible it is to call userspace stuff from the kernel space, but i
> can imagine it's rather difficult. Thus the software mixing and conversion
> stuff should live in the kernel.
> 
> I'm not arguing against having plugin functionality in ALSA-lib per se.
> There's many uses for this (effects, routing between alsa apps), but i think
> the fundamental mixing/conversion stuff is really needed in the kernel.
> 
> So how to add this functionality to ALSA with the least effort and breakage?
> Personally i think the following is the best approach:
> 
> 1. ALSA infrastructure kernel modules (pcm, seq, ctl, other voodoo stuff) 
> 2. ALSA driver modules (using 1. one instance for every real soundcard driver) 
> 3. ALSA virtual soundcard modules (using 2. sw mixing plus conversion for 2.) 
> 4. ALSA OSS emulation modules (using 2 or 3. used directly by OSS apps) 
> 5. ALSA-lib (using 2 or 3. used by ALSA apps) 
> 
> The ALSA virtual soundcard module (3.) would look to ALSA-lib or to the ALSA
> OSS emulation modules just like a normal soundcard. When used it "opens" the
> underlying ALSA driver module and provides software mixing and conversion by
> allowing umlimited open's and arbitrary parameters to all applications using
> it either through the OSS emulation modules or ALSA-lib.
> 
> Actually thanks to the design of ALSA, this is really all that needs to be
> done to provide software mixing to all OSS apps and to all ALSA apps. The
> distribution/user would only have to make sure that the virtual soundcard
> module is loaded for the card and that both OSS emu modules and ALSA-lib use
> it as default. For professional users neeeddng direct access to the hardware
> they still have the option of using the real ALSA driver (as long as it's not
> in use by the virtual soundcard module of course).
> 
> Sadly i have no idea about how difficult it would be to code up such a
> virtual soundcard module, but i suppose some of the
> resampling/mixing/conversion code in ALSA-lib can be reused. I have never
> attempted to program a module, so i leave judgement about this idea to the
> gurus :)
> 
> What other ways to intergrate this into the ALSA structure are there? And
> how much effort do they take? In the end it all comes down to developer
> time. I own a hardware mixing capable soundcard, so i can happily live with
> the current ALSA state, but IMHO this is a very important thing missing for
> the completely positive ALSA experience. ALSA has improved the situation for
> a serious linux musician/audio user tremendously over OSS (which was really
> a crutch). The final missing building block is providing an equally positive
> experience to the laptop user with his crappy soundcard needing bleeps and
> music at the same time..

Imagine, you have a virtual soundcard module, that mixes together all
the streams you want... How do you make use of it ? Who decides which
hardware stream is going to used ? Who decides if a application is
granted a hardware stream or takes part of the virtual device ? 

IMHO, ALSA requires a resource manager. And before someone starts
hacking any shit, please let us design something well done.


-- 
Manuel Jander
Electronic Engineer



-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
