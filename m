From: Glen Gee <ggeeggee@yahoo.com>
Subject: Re: Envy24-VT1712 interleaved channels.
Date: Fri, 25 Apr 2003 10:38:49 -0700 (PDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030425173849.97413.qmail@web14301.mail.yahoo.com>
References: <E198tch-0001hH-00@sc8-sf-list2.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <E198tch-0001hH-00@sc8-sf-list2.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi Jaroslav,

We intend to use the Envy24-1712 chip to perform A/D
conversion for the input capture channels.  Of the 0-7
analog input channels we want to make them stereo
pairs and thus end up with 4 input stereo channels. 
The channels must be independant...meaning no
mixing..orginal analog data must be preserved in
digital form.  The digital data will be streamed over
ethernet and thus latency is an issue as well.  All
channels must perform A/D activity at the same time. 
At this point we are trying to figure out if the alsa
driver supports this...or if you can advise us on how
to accomplish this.

Thanks.

> All input lines are captured at once in interleaved
> sample frames.
> There is 12 capture channels. Hardware vendors
> usually connects 0-7 
> channels as analog, 8-9 as S/PDIF and 10-11 is the
> digital stereo mixer 
> which contains result of playback and captured
> channels controlled with
> a matrix mixer.
> 
>       Jaroslav
> 
> -----
> Jaroslav Kysela <perex@suse.cz>
> Linux Kernel Sound Maintainer
> ALSA Project, SuSE Labs
> 
> 
>

__________________________________________________
Do you Yahoo!?
The New Yahoo! Search - Faster. Easier. Bingo
http://search.yahoo.com


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
