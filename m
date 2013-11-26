From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [alsa-cvslog] [ALSA GIT]ALSA utilities repository
 branch master updated. v1.0.27.2-14-gd2d9b6f
Date: Tue, 26 Nov 2013 13:51:08 +0100
Message-ID: <5294993C.1060505@ladisch.de>
References: <20131126104603.9E13326509E@alsa0.perex.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 68428260815
 for <alsa-devel@alsa-project.org>; Tue, 26 Nov 2013 13:51:14 +0100 (CET)
In-Reply-To: <20131126104603.9E13326509E@alsa0.perex.cz>
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

GIT server wrote:
> - Log -----------------------------------------------------------------
> commit d2d9b6fc8d20fca1e06fc261ac20fd6cfd8a8d1b
> Author: Takashi Iwai <tiwai@suse.de>
> Date:   Tue Nov 26 11:44:40 2013 +0100
>
>     alsactl: Add monitor command

>	mask = snd_ctl_event_elem_get_mask(event);
>	if (mask & SND_CTL_EVENT_MASK_VALUE)
>		printf(" VALUE");
>	if (mask & SND_CTL_EVENT_MASK_INFO)
>		printf(" INFO");
>	if (mask & SND_CTL_EVENT_MASK_ADD)
>		printf(" ADD");
>	if (mask & SND_CTL_EVENT_MASK_TLV)
>		printf(" TLV");
>	if (mask == SND_CTL_EVENT_MASK_REMOVE)
>		printf(" REMOVE");

The documentation of SND_CTL_EVENT_MASK_REMOVE says:
| Warning: test this first and if set don't test the other masks


Regards,
Clemens
