From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH] ALSA: usb-audio: hiface: return correct
 XRUN indication
Date: Mon, 22 Jul 2013 22:09:58 +0200
Message-ID: <51ED9196.5000507@ladisch.de>
References: <1374514704-4211-1-git-send-email-eldad@fogrefinery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id E9E45261A50
 for <alsa-devel@alsa-project.org>; Mon, 22 Jul 2013 22:10:14 +0200 (CEST)
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

Eldad Zack wrote:
> Return SNDRV_PCM_POS_XRUN (snd_pcm_uframes_t) instead of
> SNDRV_PCM_STATE_XRUN (snd_pcm_state_t) from the pointer
> function of 6fire, as expected by snd_pcm_update_hw_ptr0().
              ^^^^^
              ???

Regards,
Clemens
