From: Fons Adriaensen <fons.adriaensen@skynet.be>
Subject: Re: [linux-audio-dev] muse and /dev/rtc
Date: Tue, 23 Nov 2004 01:09:57 +0100
Message-ID: <20041123000957.GB4892@linux>
References: <200411202259.57503.lad@koloro.de> <20041122150120.GB20860@bth05w.ABSp.alcatel.be> <Pine.LNX.4.58.0411221633160.23424@wotan.suse.de> <200411221813.23092.rj@spamatica.se> <20041122175312.GA20957@bth05w.ABSp.alcatel.be> <1101147668.2873.29.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <1101147668.2873.29.camel@krustophenia.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: The Linux Audio Developers' Mailing List <linux-audio-dev@music.columbia.edu>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 22, 2004 at 01:21:07PM -0500, Lee Revell wrote:

> Yes, my thoughts exactly.  You don't even have to use the ALSA sequencer
> API, you can use the ALSA timer API directly.  You get multiple timer
> sources (system, RTC, sound card).  It should also be more portable.

Yes, but using the sequencer's timing should require less process swaps.

-- 
FA







-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
