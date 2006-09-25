From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: ALC260 (Re:  ALSA 1.0.13rc2 release)
Date: Tue, 26 Sep 2006 09:10:35 +0930 (CST)
Message-ID: <200609252340.k8PNeaBN018198@auster.physics.adelaide.edu.au>
References: <1159206933.14557.3.camel@osmosis>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1159206933.14557.3.camel@osmosis> from "Andrea Gozzi" at Sep 25,
	2006 07:55:33 PM
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: andrea.gozzi@linuxrevolution.eu
Cc: tiwai@suse.de, alsa-devel@lists.sourceforge.net, Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
List-Id: alsa-devel@alsa-project.org

Hi Andrea

> > Which options are you trying?  What command line(s) are you using?  If
> > you're trying to use the "model=test" option to modprobe, have you first
> > configured ALSA with the "--enable-debug" option and recompiled/reinstalled?
> > If testing alsa from within a standard kernel tree there's a similarly named
> > configuration option in the alsa section of "make menuconfig".
> >
> > As Takashi said, the "test" model is only available if debugging has been
> > enabled.
> 
> My bad, something must have gone wrong and ALSA didn't compile
> correctly.
> Now snd_hda_intel is loaded with options "disable_msi=1 model=test"

Excellent.  By the way, do you need "disable_msi=1" in order for it to
work correctly?

> After rebooting I have 8 options that can be set:
> :

Yep, that looks about what I'd expect.

> The only way I could get sound to work (at a normal volume) was with
> headphones (connected to the line in plug) and setting "LINE1 pin mode"
> to "Line out".
> Only that option is needed to be set, any other value in the fields
> doesn't change anything and neither do switches.

Good work, I think we're starting to get somewhere.  I would have expected
the headphones to still work if the "LINE1 pin mode" was set to "Headphone"
as well.  Did it?  In any case this result indicates that on your laptop the
"Line out" jack is physically connected to the ALC260's LINE1 output.

Now, what other physical jack sockets do you have on that laptop (besides
"line out")?  Do you also have problems with them or do they "just work"
when you load snd_intel_hda without options?

> Attached to this e-mail are outputs of /proc/asound/card0/codec#0/1 and
> aplay.

Sorry, this didn't seem to be attached - could you please try again?

> I really hope we get to solve this problem.

I think we're getting there.  For my reference could you please remind me of
the make/model of the laptop we're dealing with?

Regards
  jonathan

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
