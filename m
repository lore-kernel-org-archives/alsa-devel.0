From: Tommi Sakari Uimonen <tuimonen@cc.hut.fi>
Subject: Re: Multiple Delta 1010LT woes: UPDATE
Date: Sat, 21 Feb 2004 11:34:39 +0200 (EET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.OSF.4.58.0402211123450.414035@kosh.hut.fi>
References: <4036521E.9070407@sun.ac.za> <403716BA.7010505@comcast.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <403716BA.7010505@comcast.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Doug <nostar@comcast.net>
Cc: Ludwig Schwardt <schwardt@sun.ac.za>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> Are you in possesion of multiple cards at the moment?  If so, have you
> tested any multitrack recording of analog inputs from both cards
> simultaneously yet?  I have 1 1010LT now, and am planning on a second
> one within the month, to create a 16 track live recording studio.  This

I have successfully used Delta 1010LT and Delta Audiophile 2496 (2
ana + 2 digi channels) together to have 10 analog channels (1010LT has 8
analog, right?). I synced the cards through the S/PDIF since 2496 doesn't
have word clock i/o. But I had to reset alsa drivers after every capture,
since I experienced sometimes some driver lockups. I think the spdif code
had some bug and it was pathced later, but I didn't have the recording
setup anymore to test if that patch helped.

For recording I used ecasound. Also tried to hack around with .asoundrc
and JACK, but no luck. This was about 6 months ago, things might be
different now.

Tommi Uimonen


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
