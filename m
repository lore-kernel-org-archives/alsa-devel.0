From: "Ivica Ico Bukvic" <ico@fuse.net>
Subject: RE: RE: Major problem with RME HDSP/Multiface and a 64-bit AMD laptop -- SOLVED!!! (partially)
Date: Sun, 21 Mar 2004 00:42:30 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040321054228.KUAU1963.smtp3.fuse.net@64BitBadass>
References: <200403210508.i2L58EgU013379@dhin.linuxaudiosystems.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200403210508.i2L58EgU013379@dhin.linuxaudiosystems.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: 'Paul Davis' <paul@linuxaudiosystems.com>
Cc: george@synthax.com, support@synthax.de, linux-audio-dev@music.columbia.edu, linux-audio-user@music.columbia.edu, alsa-devel@lists.sourceforge.net, alsa-user@lists.sourceforge.net, 'Chris Cheney' <ccheney@cheney.cx>
List-Id: alsa-devel@alsa-project.org

Thanks! :-)

I did however realize one more thing and that is if I put my laptop to
either standby or hibernate mode in Windoze, the dreaded distortion returns
back to haunt me. :-( OTOH, a simple reboot does fix it. So, I guess it's
not the best possible solution but at least it works. My guess is that this
is a direct result of a crappy BIOS and/or APCI implementation.

So far I've tested it only with 4 outputs at 44.1KHz and it ran fine at 3ms.
1.5ms does introduce artifacts, but that really does not bother me.

Unfortunately in Linux I am yet to figure out how to fix the distortion. It
is conceivable that the fix could be achieved by simply passing some flags
in the pcmcia config (/etc/sysconfig/pcmcia), but as to which, I don't have
the faintest clue :-(.

Best wishes,

Ivica Ico Bukvic, composer & multimedia sculptor
http://meowing.ccm.uc.edu/~ico/
 
> -----Original Message-----
> From: Paul Davis [mailto:paul@linuxaudiosystems.com]
> Sent: Sunday, March 21, 2004 12:08 AM
> To: Ivica Ico Bukvic
> Cc: george@synthax.com; support@synthax.de; linux-audio-
> dev@music.columbia.edu; linux-audio-user@music.columbia.edu; alsa-
> devel@lists.sourceforge.net; alsa-user@lists.sourceforge.net
> Subject: Re: [Alsa-devel] RE: Major problem with RME HDSP/Multiface and a
> 64-bit AMD laptop -- SOLVED!!! (partially)
> 
> >What I basically did is investigated the current driver in Windoze for
> the
> >carbus and it came up as a "generic cardbus interface." I was by now
> aware
> >that the exact cardbus chipset is/was ENE C1410. So I did some searching
> on
> >the Google for the driver and came up with HP's driver download page for
> one
> >of their laptops (mine is eMachines m6807). So, I said what the heck, at
> >this point I just might as well go ahead and try it. So I downloaded the
> >driver (link:
> >http://h18007.www1.hp.com/support/files/hpcpqnk/us/download/18388.html)
> >installed it, it went without a hitch and asked me to reboot. Upon
> rebooting
> >the device manager listed the pcmcia interface as the "ENE C1410 Cardbus
> >Interface." So far, so good! Upon reconnecting the RME HDSP and playing
> the
> >sound, the sound was absolutely flawless at 3ms latency!!! Yay!
> 
> If I may say so, that is just bloody amazing. Congratulations on
> this bit of sleuthing.
> 
> Its too bad that getting this to work under Linux will likely require
> a lot more effort on the part of many more people.
> 
> --p




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
