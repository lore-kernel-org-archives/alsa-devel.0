From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Re: Envy24-VT1712 interleaved channels.
Date: Fri, 25 Apr 2003 19:50:53 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0304251948460.1347-100000@pnote.perex-int.cz>
References: <20030425173849.97413.qmail@web14301.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030425173849.97413.qmail@web14301.mail.yahoo.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Glen Gee <ggeeggee@yahoo.com>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Fri, 25 Apr 2003, Glen Gee wrote:

> Hi Jaroslav,
> 
> We intend to use the Envy24-1712 chip to perform A/D
> conversion for the input capture channels.  Of the 0-7
> analog input channels we want to make them stereo
> pairs and thus end up with 4 input stereo channels. 
> The channels must be independant...meaning no
> mixing..orginal analog data must be preserved in
> digital form.  The digital data will be streamed over
> ethernet and thus latency is an issue as well.  All
> channels must perform A/D activity at the same time. 
> At this point we are trying to figure out if the alsa
> driver supports this...or if you can advise us on how
> to accomplish this.

ALSA supports this possibility. You can grab all 12 channels
at same time and do something with these samples in your software.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
