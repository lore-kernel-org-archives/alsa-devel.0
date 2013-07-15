From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH 04/10] ALSA: ua101: Fix unlocked
 snd_pcm_stop() call
Date: Mon, 15 Jul 2013 21:01:58 +0200
Message-ID: <51E44726.6040001@ladisch.de>
References: <1373893582-17116-1-git-send-email-tiwai@suse.de>
 <1373893582-17116-5-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 246BE261A94
 for <alsa-devel@alsa-project.org>; Mon, 15 Jul 2013 21:02:09 +0200 (CEST)
In-Reply-To: <1373893582-17116-5-git-send-email-tiwai@suse.de>
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

Takashi Iwai wrote:
> snd_pcm_stop() must be called in the PCM substream lock context.
>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>

Acked-by: Clemens Ladisch <clemens@ladisch.de>
