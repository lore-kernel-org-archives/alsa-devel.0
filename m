From: Timo Wischer <twischer@de.adit-jv.com>
Subject: Re: [PATCH 09/10] ALSA: pcm: Add snd_pcm_ops for
	snd_pcm_link()
Date: Tue, 26 Mar 2019 12:25:37 +0100
Message-ID: <3ad5c313-ba2c-b541-8930-3f2515dfca72@de.adit-jv.com>
References: <1553529644-5654-1-git-send-email-twischer@de.adit-jv.com>
 <1553586574-18608-1-git-send-email-twischer@de.adit-jv.com>
 <1553586574-18608-5-git-send-email-twischer@de.adit-jv.com>
 <s5ho95ym3s7.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <s5ho95ym3s7.wl-tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-kernel@vger.kernel.org, broonie@kernel.org, patch@alsa-project.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 3/26/19 09:35, Takashi Iwai wrote:
> On Tue, 26 Mar 2019 08:49:33 +0100,
> <twischer@de.adit-jv.com> wrote:
>> From: Timo Wischer <twischer@de.adit-jv.com>
>>
>> snd_pcm_link() can be called by the user as long as the device is not
>> yet started. Therefore currently a driver which wants to iterate over
>> the linked substreams has to do this at the start trigger. But the start
>> trigger should not block for a long time. Therefore there is no callback
>> which can be used to iterate over the linked substreams without delaying
>> the start trigger.
>> This patch introduces a new callback function which will be called after
>> the linked substream list was updated by snd_pcm_link(). This callback
>> function is allowed to block for a longer time without interfering the
>> synchronized start up of linked substreams.
>>
>> Signed-off-by: Timo Wischer <twischer@de.adit-jv.com>
> Well, the idea appears interesting, but I'm afraid that the
> implementation is still racy.  The place you're calling the new
> callback isn't protected, hence the stream can be triggered while
> calling it.  That is, even during operating your loopback link_changed
> callback, another thread is able to start the stream.

Hi Takashi,

As far as I got you mean the following scenario:

  * snd_pcm_link() is called for a HW sound card
      o loopback_snd_timer_link_changed()
      o loopback_snd_timer_open()
      o spin_lock_irqsave(&dpcm->cable->lock, flags);
  * snd_pcm_start() called for aloop sound card
      o loopback_trigger()
      o spin_lock(&cable->lock) -> has to wait till
        loopback_snd_timer_open() calls spin_unlock_irqrestore()

So far snd_pcm_start() has to wait for loopback_snd_timer_open().

  * loopback_snd_timer_open() will continue with
      o dpcm->cable->snd_timer.instance = NULL;
      o spin_unlock_irqrestore()
  * loopback_trigger() can enter the lock
      o loopback_snd_timer_start() will fail with -EINVAL due to
        (loopback_trigger == NULL)

At least this will not result into memory corruption due to race or any 
other wired behavior.
But my expectation is that snd_pcm_link(hw, aloop) or 
snd_pcm_link(aloop, hw) is only called by the application calling 
snd_pcm_start(aloop)
because the same aloop device cannot be opened by multiple applications 
at the same time.

Do you see an use case where one application would call snd_pcm_start() 
in parallel with snd_pcm_link() (somehow configuring the device)?
May be we should add an additional synchronization mechanism in 
pcm_native.c to avoid call of snd_pcm_link() in parallel with 
snd_pcm_start().

>
> thanks,
>
> Takashi
