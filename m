From: Paul Davis <pbd@op.net>
Subject: Re: alsa mmap-mode does not block on poll?
Date: Wed, 22 May 2002 10:00:21 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200205221358.g4MDwNj23290@post2.fast.net>
References: <20020521162616.GB17561@jesus>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: Your message of "Tue, 21 May 2002 12:26:21 EDT."
             <20020521162616.GB17561@jesus>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Andy Wingo <wingo@pobox.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>Hi folks. I have a probably silly issue that will most likely have a
>really quick answer. For some reason, polling on a playback fd is not
>blocking, even though I set avail_min to be one period's worth (for
>example, 1024). Instead it returns immediately, avail_update gives me
>something on the order of 16 frames, and I end up busy-waiting until I
>have one period's worth of data. Would someone mind taking a look at
>this loop? It worked a long time ago, but I can't figure out what the
>problem is now. This is with rc1.

does it do this on different hardware?

_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
