From: rspier@pobox.com (Robert Spier)
Subject: Re: Using alsa-lib for timing
Date: Mon, 25 Nov 2002 22:03:42 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <15843.3774.714782.12089@rls.cx>
References: <15829.12424.589673.766811@rls.cx>
	<E18Cmqi-00030b-00@sc8-sf-list1.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <E18Cmqi-00030b-00@sc8-sf-list1.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


Paul, 

    Thank you for your clear explanation.  I've submitted a small
    documentation patch to the sf.net project which might prevent the
    next person who comes along from falling into the same trap.

>the basic problem is that you are going about this in the wrong
>way. there have been many discussions here and on LAD about how to do
>this sort of thing. its not easy. your first and most basic problem is
>that you are trying to sync two clocks (the video frame clock and the
>audio frame clock) that do *not* run in sync. any solution that starts
>with this as its approach is going to fail, for better or for worse.

    We've gone back to our standby method of timing everything off the
    audio, using polling to trigger the RTC for a per-frame delay.
    It's CPU intensive, but works well enough for our purposes.
    (Although definitely sub-optimal and quite nasty.)

-R



-------------------------------------------------------
This SF.net email is sponsored by: Get the new Palm Tungsten T 
handheld. Power & Color in a compact size! 
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0002en
