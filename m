From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: Sound on Packard Bell V7900 (ALC260): where from
	here?
Date: Fri, 9 Mar 2007 13:08:57 +1030 (CST)
Message-ID: <200703090238.l292cvVv015055@turbo.physics.adelaide.edu.au>
References: <mailman.175427.1173405502.20110.alsa-devel@lists.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <mailman.175427.1173405502.20110.alsa-devel@lists.sourceforge.net>
	from "alsa-devel-request@lists.sourceforge.net" at Mar 08,
	2007 05:58:22 PM
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
Cc: David.Friggens@mcs.vuw.ac.nz, Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
List-Id: alsa-devel@alsa-project.org

Hi David

> I also have an ALC260 - on a (HP) Compaq Presario B1900. With the test 
> model the sound is working through the microphone jack only (and with 
> worse quality than Windows.
> 
> I asked on the list back in October and Jonathan Woithe sounded hopeful, 
> but I haven't heard anything more.

Hmm, sorry about that.  Around that time life got incredibly busy for a
number of reasons and I was dealing with 2 other ALC260 issues at the same
time (both of which we fixed).  Your issue must have dropped off my radar -
sorry.

We can pick up on your problem now if you like (although I'm still very
busy, at least I won't start confusing and merging different ALC260 things).

I guess the first thing to do is to try the latest version of ALSA -
1.0.14rc3 is out now.  There are many fixes in this version and it gives
us a known point of reference.

Give the "test" model a go again from scratch while playing a file and
see what you are able to discover.  In particular, operate the GPIO controls
and see if they do anything - on some HP laptops one or more of these need
to be "on" for sound to come out of various places (speaker, headphone jack,
etc).

Finally, could we have the output of

  cat /proc/asound/card0/codec#0
  lspci
  lspci -nv

Thanks, and sorry once again that things went quiet in October.

Regards
  jonathan

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
