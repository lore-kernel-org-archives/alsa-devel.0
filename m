From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH] ALSA: pcm: Remove set_fs() in PCM core code
Date: Tue, 23 May 2017 09:09:53 +0900
Message-ID: <8289fd42-4662-db4c-9a2e-99c3e53c4754@sakamocchi.jp>
References: <20170519203059.20972-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id 5AE3A267049
 for <alsa-devel@alsa-project.org>; Tue, 23 May 2017 02:09:59 +0200 (CEST)
In-Reply-To: <20170519203059.20972-1-tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On May 20 2017 05:30, Takashi Iwai wrote:
> PCM core code has a few usages of set_fs(), mostly for two codepaths:
> - The DELAY ioctl call from pcm_compat.c
> - The ioctl wrapper in kernel context for PCM OSS and other
> 
> This patch removes the set_fs() usage in these places by a slight code
> refactoring.  For the former point, snd_pcm_delay() is changed to
> return the  value directly instead of putting the value to the given
> address.  Each caller stores the result in an appropriate manner.
> 
> For fixing the latter, snd_pcm_lib_kernel_ioctl() is changed to call
> the functions directly as well.  For achieving it, now the function
> accepts only the limited set of ioctls that have been used, so far.
> The primary user of this function is the PCM OSS layer, and the only
> other user is USB UAC1 gadget driver.  Both drivers don't need the
> full set of ioctls.
> 
> Signed-off-by: Takashi Iwai <tiwai@suse.de>

Reviewed-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>


Regards

Takashi Sakamoto
