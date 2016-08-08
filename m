From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 06/39] ALSA: seq: obsolete address mode in
 compatibility layer
Date: Mon, 8 Aug 2016 21:19:50 +0900
Message-ID: <da681afe-e92e-158a-f212-cd5e4d3a18df@sakamocchi.jp>
References: <1470563355-18368-1-git-send-email-o-takashi@sakamocchi.jp>
 <1470563355-18368-7-git-send-email-o-takashi@sakamocchi.jp>
 <s5hvazbohxj.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 8851B2695B1
 for <alsa-devel@alsa-project.org>; Mon,  8 Aug 2016 14:19:53 +0200 (CEST)
In-Reply-To: <s5hvazbohxj.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, clemens@ladisch.de
List-Id: alsa-devel@alsa-project.org

On Aug 8 2016 16:09, Takashi Iwai wrote:
> It's better to pass a snd_seq_client pointer to this function and
> evaluate client->port in the function instead of referencing to
> client->port from each caller.

?

I don't understand to what you addressed. Neither snd_seq_do_ioctl() and 
snd_seq_kernel_client_ctl() have differences about port referencing.


Regards

Takashi Sakamoto
