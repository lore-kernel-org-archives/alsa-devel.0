From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: Re: The obsolence of OSS, Was: big smiley
Date: Wed, 25 Feb 2004 10:37:57 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200402251537.i1PFbwSv026765@dhin.linuxaudiosystems.com>
References: <403CBD33.9060302@superbug.demon.co.uk>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Wed, 25 Feb 2004 15:20:19 GMT."
             <403CBD33.9060302@superbug.demon.co.uk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: Adam Tla/lka <atlka@pg.gda.pl>, Alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>The ideal scheduler for realtime apps would be one that has an api that 
>allows for a call like "schedule me at exactly 10ms intervals+-1ms".

no, thats not true.

the system clock does not run in sync with the sample clock. the drift
in this would become noticeable in a few minutes.

the only time to run an audio app is ASAP after the interrupt from the
device is recieved (assuming minimum latency; there is a more
involved, but still interrupt-driven deadline with non-minimal
latency).

--p




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
