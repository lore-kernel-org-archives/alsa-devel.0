From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: Prolem with ALC260 soundcard
Date: Thu, 5 Oct 2006 11:01:23 +0930 (CST)
Message-ID: <200610050131.k951VNRG020959@turbo.physics.adelaide.edu.au>
References: <mailman.50380.1159956166.16222.alsa-devel@lists.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <mailman.50380.1159956166.16222.alsa-devel@lists.sourceforge.net>
	from "alsa-devel-request@lists.sourceforge.net" at Oct 04,
	2006 03:02:46 AM
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
Cc: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
List-Id: alsa-devel@alsa-project.org

> Hello, i have an acer c204 Notebook with an ALC260 chip inside. Since one
> month i have sound on it, because of the ALC883 patch for acer notebooks.

Hmm, that's marginally odd.  I wouldn't expect the ALC883 patch to have any
effect on your laptop if you truly have an ALC260.  The ALC260 hasn't had
any major changes for a while so it's a little strange that things have
changed recently.

Could you send me the output of 
  lspci -v
as well as the result of the command
  cat /proc/asound/card0/codec#0

> When i set "options snd-hda-intel model=acer" in the modprobe.conf, then i
> have sound over my headphones, but no sound is comming out of the speaker.

If this Acer is anything like others and it truly does use the ALC260 (eg:
Travelmates) it could be that we need to activate more than just GPIO0 on
your particular laptop.  Currently the ALC260 Acer model turns GPIO0 on
which on the Travelmates means both the headphone jack and the internal
speaker can work.  Perhaps the c204 uses GPIO0 for the headphone jack (since
you report that working) and GPIO1 (for instance) for the internal speaker.

However before proceeding we have to confirm exactly which chip is in your
notebook, as described previously.

> I olso saw, that when i put my headphones inside the mic, then i olso have
> sound. That sound have not as good quality as that from the headphones
> jack and its louder.

Now *that's* odd.  This seems to suggest that the c204 may be wired
totally differently to the Travelmate from the point of view of which
pins on the ALC260 chip go where.

Could you give me a complete list of the audio jacks provided on your
laptop.  I guess there's at least a "headphone" jack and one labelled "mic".
If there are any others, what are they?

> Can someone tell me what i could do to get sound out of my speaker?

Are you comfortable/familiar with configuring and compiling ALSA?  We
are possibly going to have to get you to run some tests with the "test"
ALC260 model but that will require you recompile ALSA.

Regards
  jonathan

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
