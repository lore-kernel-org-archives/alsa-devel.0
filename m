From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH] ALSA: firewire-lib: add missing
	description for kerneldoc
Date: Thu, 13 Nov 2014 01:11:57 +0900
Message-ID: <546386CD.9090306@sakamocchi.jp>
References: <1415800527-5723-1-git-send-email-o-takashi@sakamocchi.jp>
 <s5h1tp8mseb.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp301.phy.lolipop.jp (smtp301.phy.lolipop.jp [210.157.22.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 80E7B265756
 for <alsa-devel@alsa-project.org>; Wed, 12 Nov 2014 17:12:03 +0100 (CET)
In-Reply-To: <s5h1tp8mseb.wl-tiwai@suse.de>
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

HI,

On Nov 12 2014 22:59, Takashi Iwai wrote:
> Could you fix these as well?
> (amdtp.h enum errors look stupid, though...)

OK.

> Warning(amdtp.h:44): Enum value 'CIP_SKIP_DBC_ZERO_CHECK' not described in enum 'cip_flags'

This is due to my typo.

> Warning(amdtp.h:58): Enum value 'CIP_SFC_32000' not described in enum 'cip_sfc'
> Warning(amdtp.h:58): Enum value 'CIP_SFC_44100' not described in enum 'cip_sfc'
> Warning(amdtp.h:58): Enum value 'CIP_SFC_48000' not described in enum 'cip_sfc'
> Warning(amdtp.h:58): Enum value 'CIP_SFC_88200' not described in enum 'cip_sfc'
> Warning(amdtp.h:58): Enum value 'CIP_SFC_96000' not described in enum 'cip_sfc'
> Warning(amdtp.h:58): Enum value 'CIP_SFC_176400' not described in enum 'cip_sfc'
> Warning(amdtp.h:58): Enum value 'CIP_SFC_192000' not described in enum 'cip_sfc'
> Warning(amdtp.h:58): Enum value 'CIP_SFC_COUNT' not described in enum 'cip_sfc'

A lack of descriptions.
I think it good to refer to IEC 61883-1 in these description.


Regards

Takashi Sakamoto
o-takashi@sakamocchi.jp
