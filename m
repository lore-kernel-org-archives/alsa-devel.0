From: Paul Davis <pbd@Op.Net>
Subject: Re: Re: Playback stutters - Correction
Date: Wed, 20 Mar 2002 03:06:56 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200203201306.IAA00621@renoir.op.net>
References: <20020320164838.A32243@getsystems.com>
In-Reply-To: Your message of "Wed, 20 Mar 2002 16:48:38 +1100."
             <20020320164838.A32243@getsystems.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Zenaan Harkness <zen@getsystems.com>
Cc: alsa-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

>CORRECTION:
>Just retested with full hdparm (added -u setting) settings on
>2.4.19-pre3-ac+preempt, and no skipping with above activities. This
>seems pretty good.
>
>I could generate skips when switching from X to text console. Could not
>generate skip when cycling virtual desktops within X (at high key repeat
>rate). Again this seems pretty good.

this is a know deficiency in the vt "driver", and is noted in Andrew
Morton's "Things Not To Do" while requiring low scheduling latency. it
would be nice if the vt code was fixed sometime, but right now, i
think it can cause a scheduling delay for up to about 50ms.

btw, i think it is still the case the Andrew's patch provides more
reliable and lower absolute latency than the preemption patch.

--p

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
