From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Re: [linux-audio-dev] muse and /dev/rtc
Date: Mon, 22 Nov 2004 19:32:39 -0500
Message-ID: <1101169959.3689.19.camel@krustophenia.net>
References: <200411202259.57503.lad@koloro.de>
	 <20041122150120.GB20860@bth05w.ABSp.alcatel.be>
	 <Pine.LNX.4.58.0411221633160.23424@wotan.suse.de>
	 <200411221813.23092.rj@spamatica.se>
	 <20041122175312.GA20957@bth05w.ABSp.alcatel.be>
	 <1101147668.2873.29.camel@krustophenia.net>  <s5hekilvho7.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hekilvho7.wl@alsa2.suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: The Linux Audio Developers' Mailing List <linux-audio-dev@music.columbia.edu>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Mon, 2004-11-22 at 19:54 +0100, Takashi Iwai wrote:
> Yes, I agree that ALSA timer API would be useful for such a case.  The
> app can reject to run or do some workaround if the queried timer 
> resolution is worse than requirements.
> 
> Well, my guess for the next reaction is "the lack of documentation" ;)

I think the only issue is that adding timer support to a driver is not
documented.  I did not even know ALSA had a timer API until it was
pointed out to me on the list, as the driver guide was my main
reference.  Adding a chapter to the guide would ensure that new drivers
get timer support.


Lee




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
