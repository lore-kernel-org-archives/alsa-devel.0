From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 0/10] snd_pcm_stop() lock fixes
Date: Tue, 16 Jul 2013 16:54:14 +0200
Message-ID: <51E55E96.1040305@metafoo.de>
References: <1373893582-17116-1-git-send-email-tiwai@suse.de>
 <51E3F527.60801@perex.cz> <s5h61wcynax.wl%tiwai@suse.de>
 <s5h8v16wogt.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-232.synserver.de (smtp-out-236.synserver.de
 [212.40.185.236])
 by alsa0.perex.cz (Postfix) with ESMTP id AC8E426500B
 for <alsa-devel@alsa-project.org>; Tue, 16 Jul 2013 17:01:44 +0200 (CEST)
In-Reply-To: <s5h8v16wogt.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 07/16/2013 04:48 PM, Takashi Iwai wrote:
[...]
> +int snd_pcm_lock_and_stop(struct snd_pcm_substream *substream, snd_pcm_state_t state)

The name makes it sound as if the lock will still be held after the function
call has completed. How about snd_pcm_stop_locked()?

- Lars
