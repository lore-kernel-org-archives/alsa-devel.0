From: Thierry Vignaud <tvignaud@mandrakesoft.com>
Subject: Re: current buglets
Date: Mon, 19 Aug 2002 17:26:29 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <m2wuqmrhsq.fsf@vador.mandrakesoft.com>
References: <s5hbs84tesw.wl@alsa2.suse.de>
	<m2eld0rzer.fsf@vador.mandrakesoft.com> <s5h3ctgm7c0.wl@alsa2.suse.de>
	<m265ycqeal.fsf@vador.mandrakesoft.com> <s5h8z32ubpn.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h8z32ubpn.wl@alsa2.suse.de> (Takashi Iwai's message of "Mon,
 19 Aug 2002 17:09:40 +0200")
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai <tiwai@suse.de> writes:

> anyway, there is another better solution for such a situation.
> you can set the running mode for oss emulation
>
> 	# echo "wine 0 0 direct" > /proc/asound/card0/pcm0p/oss
>
> so that wine runs on the "direct" mode without plugin.

this is clean enought so that we can do this on firt wine invocation.



-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
