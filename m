From: Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [BUG] ALSA: core: seq: a possible double-lock bug in
 snd_seq_midisynth_remove()
Date: Mon, 29 Jul 2019 11:54:07 +0800
Message-ID: <50b3b4c4-fe36-8c65-345b-f0a51193726c@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, Takashi Iwai <tiwai@suse.de>, gregkh@linuxfoundation.org, rfontana@redhat.com, allison@lohutok.net, tglx@linutronix.de
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

In snd_seq_midisynth_remove(), there is a possible double-lock bug:
snd_seq_midisynth_remove()
     mutex_lock(&register_mutex); -- line 421
     snd_seq_delete_kernel_client() --- line 436
         seq_free_client() -- line 2244
             mutex_lock(&register_mutex); -- line 294

This bug is found by a static analysis tool STCheck written by us.

I do not know how to correctly fix this bug, so I only report it.
A possible fix is to release the mutex lock before calling 
seq_free_client() in snd_seq_delete_kernel_client() and then acquiring 
the lock again after calling seq_free_client().


Best wishes,
Jia-Ju Bai
