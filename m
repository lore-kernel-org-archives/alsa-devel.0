From: Paul Davis <pbd@op.net>
Subject: Re: pcm_peak code in aplay
Date: Sun, 02 Jun 2002 09:40:03 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E17EVWP-0002qi-00@usw-sf-list1.sourceforge.net>
References: <1023001914.10073.9.camel@psuedomode>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: Your message of "02 Jun 2002 03:11:53 EDT."
             <1023001914.10073.9.camel@psuedomode>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Ed Sweetman <safemode@speakeasy.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>It seems to me that the pcm_peak code in aplay doesn't work or maybe i
>dont understand it's actual function.  It shows the same thing over and
>over no matter what the volume of the audio going through it (captured
>from mic).  

then its probably not working on your system for some other reason,
since it works just as you think it does on my system (and at least 2
others).

are you sure you really have a variable signal arriving at the input
connector that is currently being used for capture?

--p

_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
