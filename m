From: "Alexander E. Patrakov" <patrakov@gmail.com>
Subject: Re: [alsa-devel] [PATCH 1/3] sound: Add a quirk to enforce period_bytes
Date: Mon, 16 Jun 2014 20:38:52 +0600
Message-ID: <539F017C.90408@gmail.com>
References: <1402762571-6316-1-git-send-email-m.chehab@samsung.com> <1402762571-6316-2-git-send-email-m.chehab@samsung.com> <539E9F25.7030504@ladisch.de> <20140616112110.3f509262.m.chehab@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <20140616112110.3f509262.m.chehab@samsung.com>
Sender: linux-media-owner@vger.kernel.org
To: Mauro Carvalho Chehab <m.chehab@samsung.com>, Clemens Ladisch <clemens@ladisch.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Mauro Carvalho Chehab <mchehab@infradead.org>, Linux Media Mailing List <linux-media@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

16.06.2014 20:21, Mauro Carvalho Chehab wrote:
> Both xawtv and tvtime use the same code for audio:
> 	http://git.linuxtv.org/cgit.cgi/xawtv3.git/tree/common/alsa_stream.c
>
> There's an algorithm there that gets the period size form both the
> capture and the playback cards, trying to find a minimum period that
> would work properly for both.

I don't see any adaptive resampler (similar to what module-loopback does 
in pulseaudio) there. Without that, or dynamically controlling the audio 
capture clock PLL in the tuner, xruns are unavoidable when transferring 
data between two unrelated cards.

So, until any further evidence appears, I think it is a common bug in 
these audio codes.

-- 
Alexander E. Patrakov
