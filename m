From: Eldad Zack <eldad@fogrefinery.com>
Subject: Re: [PATCH] ALSA: usb-audio: hiface: return correct
 XRUN indication
Date: Tue, 23 Jul 2013 11:11:44 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1307231109330.1025@xoschi>
References: <1374514704-4211-1-git-send-email-eldad@fogrefinery.com>
 <20130722234707.0338af00f49527a271fbef07@studenti.unina.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f46.google.com (mail-bk0-f46.google.com
 [209.85.214.46])
 by alsa0.perex.cz (Postfix) with ESMTP id 805D6261B1F
 for <alsa-devel@alsa-project.org>; Tue, 23 Jul 2013 11:11:50 +0200 (CEST)
Received: by mail-bk0-f46.google.com with SMTP id na10so2852183bkb.33
 for <alsa-devel@alsa-project.org>; Tue, 23 Jul 2013 02:11:50 -0700 (PDT)
In-Reply-To: <20130722234707.0338af00f49527a271fbef07@studenti.unina.it>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Antonio Ospite <ospite@studenti.unina.it>, Clemens Ladisch <clemens@ladisch.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org



On Mon, 22 Jul 2013, Antonio Ospite wrote:

> On Mon, 22 Jul 2013 19:38:24 +0200
> Eldad Zack <eldad@fogrefinery.com> wrote:
> 
> > Return SNDRV_PCM_POS_XRUN (snd_pcm_uframes_t) instead of
> > SNDRV_PCM_STATE_XRUN (snd_pcm_state_t) from the pointer
> > function of 6fire, as expected by snd_pcm_update_hw_ptr0().
> > 
> > Caught by sparse.
> > 
> > Signed-off-by: Eldad Zack <eldad@fogrefinery.com>
> 
> I too was going to send this one, I verified that the fix is OK, thanks
> Eldad for anticipating me.
> 
> Would you please fix the commit message as Clemens pointed out?

Oops - sure, will send it out corrected in a moment.

Cheers,
Eldad
