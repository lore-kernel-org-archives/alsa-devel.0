From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [alsa-devel] [PATCH 1/3] sound: Add a quirk to enforce period_bytes
Date: Wed, 18 Jun 2014 10:21:20 +0200
Message-ID: <53A14C00.4060107@ladisch.de>
References: <1402762571-6316-1-git-send-email-m.chehab@samsung.com> <1402762571-6316-2-git-send-email-m.chehab@samsung.com> <539E9F25.7030504@ladisch.de> <20140616112110.3f509262.m.chehab@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <20140616112110.3f509262.m.chehab@samsung.com>
Sender: linux-media-owner@vger.kernel.org
To: Mauro Carvalho Chehab <m.chehab@samsung.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Mauro Carvalho Chehab <mchehab@infradead.org>, Linux Media Mailing List <linux-media@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Mauro Carvalho Chehab wrote:
> Both xawtv and tvtime use the same code for audio:
> 	http://git.linuxtv.org/cgit.cgi/xawtv3.git/tree/common/alsa_stream.c
>
> There's an algorithm there that gets the period size form both the
> capture and the playback cards, trying to find a minimum period that
> would work properly for both.

Why are you trying to match period sizes?  The sample clocks won't be
synchronized anyway, so it is not possible to force them to happen at
the same time.

Please note that for playback devices, the latency is the same as the
buffer length, while for capture device, the latency is the same as the
_period_ length.  Therefore, it does not make sense to put an upper
limit on the size of the capture buffer.

I do not think it is a good idea to stop the capture device when it
overruns.


Regards,
Clemens
