From: "Pierre-Louis Bossart" <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] ALSA: usb: refine delay information with
	USB	frame counter
Date: Tue, 30 Aug 2011 10:34:55 -0500
Message-ID: <24910.5588453405$1314718521@news.gmane.org>
References: <1314642732-8909-1-git-send-email-pierre-louis.bossart@linux.intel.com>
	<4E5C9866.9060901@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by alsa0.perex.cz (Postfix) with ESMTP id 6B49D246D5
	for <alsa-devel@alsa-project.org>;
	Tue, 30 Aug 2011 17:34:58 +0200 (CEST)
In-Reply-To: <4E5C9866.9060901@ladisch.de>
Content-Language: en-us
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: 'Clemens Ladisch' <clemens@ladisch.de>
Cc: sarah.a.sharp@linux.intel.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> /*
>  * Multi-line comments are supposed to use this formatting style.
>  */

Ok

> This could be replaced with just:
> 	frame_diff = (current_frame_number - subs->last_frame_number) &
> 0xff;

ok
 
> Do you know how large the difference actually becomes?
> 
> I'm not sure if it might be possible to construct a scenario where
> rounding errors could accumulate ...

I don't think so. I've use a classic technique, I've seen similar code used
to improve a/v sync when the audio time is updated in steps. The estimate
starts from the delay as computed before (number of samples queued), then
decreased down (possibly to zero) using the frame counter. When the urbs are
retired, the delay is reset as previously. The frame number is only used to
predict the delay more accurately, and the delay is always based on 2 reads
of the frame counter. Worst case one case be off by one ms on each read.
