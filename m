From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH 02/17] firewire-lib: Add macros instead of
 fixed value for AMDTP
Date: Mon, 25 Nov 2013 16:27:00 +0100
Message-ID: <52936C44.7070606@ladisch.de>
References: <1385186884-8259-1-git-send-email-o-takashi@sakamocchi.jp>
 <1385186884-8259-3-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id E2B52261A8F
 for <alsa-devel@alsa-project.org>; Mon, 25 Nov 2013 16:27:04 +0100 (CET)
In-Reply-To: <1385186884-8259-3-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>, tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, ffado-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Sakamoto wrote:
> This patch adds some macros instead of fixed value for AMDTP in IEC 61883-6.
> These macros will also be used by followed patches.

> +++ b/sound/firewire/amdtp.c

> +/*
> + * Audio and Music transfer protocol specific parameters
> + * only "Clock-based rate controll mode" is supported
                             ^^^^^^^^
                             control

> -		return 0xffff; /* no info */
> +		return CIP_SYT_NO_INFO; /* no info */

The comment is now superfluous.


Regards,
Clemens
