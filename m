From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 07/24] ALSA: firewire: Convert to
 snd_card_new() with a device pointer
Date: Fri, 14 Feb 2014 15:56:05 +0900
Message-ID: <52FDBE05.1090702@sakamocchi.jp>
References: <1392201340-27113-1-git-send-email-tiwai@suse.de>
 <1392201340-27113-8-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id 4FF732610CE
 for <alsa-devel@alsa-project.org>; Fri, 14 Feb 2014 07:56:11 +0100 (CET)
In-Reply-To: <1392201340-27113-8-git-send-email-tiwai@suse.de>
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

(Feb 12 2014 19:35), Takashi Iwai wrote:
> Also remove superfluous snd_card_set_dev() calls.
>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>

It's a good idea.

Reviewed-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>


Regards

Takashi Sakamoto
o-takashi@sakamocchi.jp
