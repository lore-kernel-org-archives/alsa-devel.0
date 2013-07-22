From: Antonio Ospite <ospite@studenti.unina.it>
Subject: Re: [PATCH] ALSA: usb-audio: hiface: return correct
 XRUN indication
Date: Mon, 22 Jul 2013 23:47:07 +0200
Message-ID: <20130722234707.0338af00f49527a271fbef07@studenti.unina.it>
References: <1374514704-4211-1-git-send-email-eldad@fogrefinery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp208.alice.it (smtp208.alice.it [82.57.200.104])
 by alsa0.perex.cz (Postfix) with ESMTP id F11AD261AA5
 for <alsa-devel@alsa-project.org>; Mon, 22 Jul 2013 23:47:11 +0200 (CEST)
In-Reply-To: <1374514704-4211-1-git-send-email-eldad@fogrefinery.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Eldad Zack <eldad@fogrefinery.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, 22 Jul 2013 19:38:24 +0200
Eldad Zack <eldad@fogrefinery.com> wrote:

> Return SNDRV_PCM_POS_XRUN (snd_pcm_uframes_t) instead of
> SNDRV_PCM_STATE_XRUN (snd_pcm_state_t) from the pointer
> function of 6fire, as expected by snd_pcm_update_hw_ptr0().
> 
> Caught by sparse.
> 
> Signed-off-by: Eldad Zack <eldad@fogrefinery.com>

I too was going to send this one, I verified that the fix is OK, thanks
Eldad for anticipating me.

Would you please fix the commit message as Clemens pointed out?

Regards,
   Antonio

-- 
Antonio Ospite
http://ao2.it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
