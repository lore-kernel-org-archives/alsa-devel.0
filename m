From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [RFC PATCH] ALSA: core: Add DMA share buffer
	support
Date: Mon, 21 Jan 2019 15:15:43 +0100
Message-ID: <f278bb69-7df0-4d14-5e4f-9bcb57d7f2b6@perex.cz>
References: <290f6d3a5fe288b87480cc5fa12c5139728daeca.1547787189.git.baolin.wang@linaro.org>
 <81e894ba-acad-2fd4-996d-8d35edd8825a@perex.cz>
 <20190118190805.GF6260@sirena.org.uk> <s5hzhrxzrez.wl-tiwai@suse.de>
 <20190121124053.GA12679@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 by alsa0.perex.cz (Postfix) with ESMTP id 44F91267333
 for <alsa-devel@alsa-project.org>; Mon, 21 Jan 2019 15:16:10 +0100 (CET)
In-Reply-To: <20190121124053.GA12679@sirena.org.uk>
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
To: Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, bgoswami@codeaurora.org, gustavo@embeddedor.com, srinivas.kandagatla@linaro.org, mchehab+samsung@kernel.org, sr@denx.de, daniel.thompson@linaro.org, corbet@lwn.net, philburk@google.com, willy@infradead.org, jmiller@neverware.com, keescook@chromium.org, arnd@arndb.de, colyli@suse.de, ckeepax@opensource.wolfsonmicro.com, anna-maria@linutronix.de, mathieu.poirier@linaro.org, Baolin Wang <baolin.wang@linaro.org>, sboyd@kernel.org, linux-kernel@vger.kernel.org, vkoul@kernel.org, leo.yan@linaro.org, joe@perches.com
List-Id: alsa-devel@alsa-project.org

Dne 21.1.2019 v 13:40 Mark Brown napsal(a):
> On Fri, Jan 18, 2019 at 08:39:32PM +0100, Takashi Iwai wrote:
>> Mark Brown wrote:
> 
>>>> multiple tasks). I would probably go in this way and add more extended
>>>> permission control for the PCM device, so permissions can be restricted
>>>> for the passed descriptor to the producer or the consumer task. In this
> 
>>> One concern I have with doing some ALSA-specific custom permissions
>>> thing is integration with frameworks like SELinux (they'd presumably
>>> need to learn about the ALSA specific stuff to manage it).  It also
> 
>> Well, I wonder what makes it more difficult by the approach Jaroslav
>> suggested.  With O_APPEND, you can just call mmap() normally, and
>> that's all. What's the merit of dma-buf approach wrt the security?
> 
> It was the bit about adding more extended permission control that I was
> worried about there, not the initial O_APPEND bit.  Indeed the O_APPEND
> bit sounds like it might also work from the base buffer sharing point of
> view, I have to confess I'd not heard of that feature before (it didn't
> come up in the discussion when Eric raised this in Prague).

With permissions, I meant to make possible to restrict the file
descriptor operations (ioctls) for the depending task (like access to
the DMA buffer, synchronize it for the non-coherent platforms and maybe
read/write the actual position, delay etc.). It should be relatively
easy to implement using the snd_pcm_file structure.

Even with the full operation mode, it's difficult imagine what the
depending task can break with the sound interface except probably annoy
users with some cracks for the playback or start/stop the streaming rapidly.

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
