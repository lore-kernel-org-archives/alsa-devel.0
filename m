From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [alsa-devel] [PATCH 08/11] ALSA: vsnd: Add timer for period
 interrupt emulation
Date: Mon, 7 Aug 2017 15:55:25 +0200
Message-ID: <e857f6cf-0e82-aa2b-9291-6d0c40ac918a@ladisch.de>
References: <1502091796-14413-1-git-send-email-andr2000@gmail.com>
 <1502091796-14413-9-git-send-email-andr2000@gmail.com>
 <ba0dd78b-8853-5cf9-197f-bed3b9f4bdb8@ladisch.de>
 <f2f54b55-3145-2533-c74a-9c3ea803739e@gmail.com>
 <4ce45eec-8657-66c4-c8c7-b851250da46a@ladisch.de>
 <45738e58-7ed2-8315-8d9c-138c3d3a2ecc@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <45738e58-7ed2-8315-8d9c-138c3d3a2ecc@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Oleksandr Andrushchenko <andr2000@gmail.com>
Cc: alsa-devel@alsa-project.org, xen-devel@lists.xen.org, linux-kernel@vger.kernel.org, Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>, tiwai@suse.com
List-Id: alsa-devel@alsa-project.org

Oleksandr Andrushchenko wrote:
> On 08/07/2017 04:11 PM, Clemens Ladisch wrote:
>> How does that interface work?
>
> For the buffer received in .copy_user/.copy_kernel we send
> a request to the backend and get response back (async) when it has copied
> the bytes into HW/mixer/etc, so the buffer at frontend side can be reused.

So if the frontend sends too many (too large) requests, does the
backend wait until there is enough free space in the buffer before
it does the actual copying and then acks?

If yes, then these acks can be used as interrupts.  (You still
have to count frames, and call snd_pcm_period_elapsed() exactly
when a period boundary was reached or crossed.)

Splitting a large read/write into smaller requests to the backend
would improve the granularity of the known stream position.

The overall latency would be the sum of the sizes of the frontend
and backend buffers.


Why is the protocol designed this way?  Wasn't the goal to expose
some 'real' sound card?


Regards,
Clemens
