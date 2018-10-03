From: Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [BUG] sound: pci: trident: a possible data race
Date: Wed, 3 Oct 2018 20:50:25 +0800
Message-ID: <864e211c-8be5-6a34-902a-a71f176111db@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com, keescook@chromium.org
Cc: alsa-devel@alsa-project.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

CPU0:
snd_trident_hw_free
     snd_trident_free_voice
             line 3870: spin_lock_irqsave()
             line 3881: voice->substream = NULL; [WRITE]
CPU1:
snd_trident_interrupt
     line 3798: snd_pcm_period_elapsed(voice->substream);  [READ]

As for voice->substream, the WRITE operation in CPU0 is performed
with holding a spinlock, but the READ operation in CPU1 is performed
without holding this spinlock, so there may exist a data race.


Best wishes,
Jia-Ju Bai
