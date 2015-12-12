From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH 02/10] ALSA: dice: wait for ensuring
	phase	lock
Date: Sat, 12 Dec 2015 12:42:18 +0100
Message-ID: <566C081A.1000804@ladisch.de>
References: <1449889570-26641-1-git-send-email-o-takashi@sakamocchi.jp>
 <1449889570-26641-3-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 9418F2606E6
 for <alsa-devel@alsa-project.org>; Sat, 12 Dec 2015 12:42:40 +0100 (CET)
In-Reply-To: <1449889570-26641-3-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Takashi Sakamoto wrote:
> Some users have reported that their Dice based models generate packet
> discontinuity at the beginning of streaming. When standing on an
> assumption that the value of SYT field in transferred AMDTP packet comes
> from phase lock circuit, this comes from phase unlocking with current
> clock source. Just waiting for dice notification is not enough to prevent
> from packet discontinuity.
>
> This commit checks the register of phase lock after clock state change for
> this purpose.

Is this patch actually known to help?

This discontinuity could also come from an unexpected initial DBC value.
I think it would be a good idea to unconditionally enable
CIP_SKIP_INIT_DBC_CHECK for all devices.


Regards,
Clemens
