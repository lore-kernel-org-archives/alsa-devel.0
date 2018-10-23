From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: snd-usb-audio Buffer Sizes and Round Trip Latency
Date: Tue, 23 Oct 2018 09:08:22 -0500
Message-ID: <928c8739-f0bc-339c-f951-6eb6bd001cf4@linux.intel.com>
References: <5fb8650f-5a55-d895-f7b3-bc8a3b1af31b@linux.intel.com>
 <Pine.LNX.4.44L0.1810221112460.1530-100000@iolanthe.rowland.org>
 <CANwerB2wCHRz4E45uqWRVsynhzcFHNDwkHiAefoG0eJ=dCYTKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by alsa0.perex.cz (Postfix) with ESMTP id 0146E2675C3
 for <alsa-devel@alsa-project.org>; Tue, 23 Oct 2018 16:08:25 +0200 (CEST)
In-Reply-To: <CANwerB2wCHRz4E45uqWRVsynhzcFHNDwkHiAefoG0eJ=dCYTKQ@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jonathan Liu <net147@gmail.com>, Alan Stern <stern@rowland.harvard.edu>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA development <alsa-devel@alsa-project.org>, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org


>>>> Linux 4.17.14, Class Compliant Mode (snd-usb-audio, ALSA backend):
>>>> 16/2 32 + 80 ~ 2.333 ms
>> What are these numbers?  Are these lines supposed to in the format
>> expressed by the first formula above?  If they are, how come
>> "block_size/periods" shows up as a pair of numbers "16/2" but
>> "block_size*periods" shows up as a single number "32"?
>>
> To interpret "16/2 32 + 80 ~ 2.333 ms"
> Block size: 16 samples
> Periods: 2 (one period for playback + one period for recording when
> determining round trip latency)
> The minimum round trip latency is: 16 * 2 = 32 samples
> However, I measured 112 samples round trip latency which is an
> additional delay of 80 samples (32 + 80 = 112).
> 112 samples at 48000 Hz is 112 / 48000 * 1000 is approximately 2.333
> ms measured round trip latency.

ok, so what problem are you trying to fix?

Are you concerned about the latency numbers (but then they seem lower on 
Linux and latency concerns with large buffers are a self-negating 
proposition)? are you concerned about the variable delay that doesn't 
seem to exist on MacOS or Windows? Are you trying to match the 
performance of the RME driver on MacOS?

I am not sure how this comparison is done btw, the delay includes both 
buffering on the device side before reaching the analog parts as well as 
buffering on the OS side. While the former should be constant, the 
latter depends a great deal on implementation, not sure there are direct 
lessons to be applied to ALSA. I also see inconsistent/non-linear 
results where with a larger block size the delay is smaller, e.g.

256/2 512 + 650 ~ 24.208 ms
2048/3 6144 + 633 ~ 141.188 ms
