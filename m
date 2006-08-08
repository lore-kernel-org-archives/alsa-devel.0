From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: [ALSA - driver 0002339]: No sound with ALC260 chip
Date: Tue, 8 Aug 2006 09:37:46 +0930 (CST)
Message-ID: <200608080007.k7807kJ5002704@auster.physics.adelaide.edu.au>
References: <mailman.46106.1154929731.19399.alsa-devel@lists.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <mailman.46106.1154929731.19399.alsa-devel@lists.sourceforge.net>
	from "alsa-devel-request@lists.sourceforge.net" at Aug 06,
	2006 10:48:51 PM
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

"Lubomir" posted via the bugtracker:
> I own an Acer c204 and am the only one person who use linux on it. I can
> not get sound out of my headphone or the normal speaker. ...

The bugtracker is currently unreachable and has been for the past 14 hours
(at least for me) so I figured I'd respond to the list on the off-chance
Lubomir (the original reporter) is listening.

It sounds like this particular Acer laptop needs more than the basic
ALC260 model.  There are a number of predefined models which can be selected
using the "model" option to the snd-hda-intel module.  For example:

  modprobe snd-hda-intel model=acer

AFAIK there are currently four machine-specific models to choose from for
the ALC260 codec: basic, acer, hp, fujitsu.  Basic is I believe the default,
and acer is the most likely to work for you.  Please give each of these a go
in turn and see if you manage to get any sound.  Note that the snd-hda-codec
module will need to be unloaded before trying a different model so the
change takes effect.

If none of the existing models work, try the "test" model.  This shows
controls for all features of the ALC260 even if they aren't used in your
particular laptop.  See if you can get sound by manipulating the controls
provided.  Note that you'll have to enable debug support in ALSA for the
"test" model to be available.

Report back your findings and we'll then work towards adding support as
required.

If you need assistance comprehending the test model controls contact me
off-list or check the list archives for previous posts from me on this
subject.

Regards
  jonathan

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
