From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 1/3] ALSA: firewire: Remove superfluous
 snd_info_register() calls
Date: Wed, 6 Feb 2019 23:33:22 +0900
Message-ID: <20190206143322.GA4337@workstation>
References: <20190205160527.8815-1-tiwai@suse.de>
 <20190205160527.8815-2-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com
 [209.85.214.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6EBA5267002
 for <alsa-devel@alsa-project.org>; Wed,  6 Feb 2019 15:33:31 +0100 (CET)
Received: by mail-pl1-f193.google.com with SMTP id gn14so3145031plb.10
 for <alsa-devel@alsa-project.org>; Wed, 06 Feb 2019 06:33:31 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20190205160527.8815-2-tiwai@suse.de>
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

Hi,

On Tue, Feb 05, 2019 at 05:05:25PM +0100, Takashi Iwai wrote:
> The calls of snd_info_register() are superfluous and should be avoided
> at the procfs creation time.  They are called at the end of the whole
> initialization via snd_card_register().  This patch drops such
> superfluous calls.
> 
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  sound/firewire/bebob/bebob_proc.c         | 12 ++----------
>  sound/firewire/dice/dice-proc.c           | 12 ++----------
>  sound/firewire/digi00x/digi00x-proc.c     | 16 ++--------------
>  sound/firewire/fireface/ff-proc.c         | 12 ++----------
>  sound/firewire/fireworks/fireworks_proc.c | 12 ++----------
>  sound/firewire/motu/motu-proc.c           | 12 ++----------
>  sound/firewire/oxfw/oxfw-proc.c           | 12 ++----------
>  sound/firewire/tascam/tascam-proc.c       | 12 ++----------
>  8 files changed, 16 insertions(+), 84 deletions(-)

Reviewed-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Tested-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
 

By the way, would I request you to sync alsa-utils repo in
git.alsa-project.org to the one in github.com? 9 patches
were applied to the latter, but never to the former.


Thanks

Takashi Sakamoto
