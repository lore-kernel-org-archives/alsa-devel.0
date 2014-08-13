From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 12/15] oxfw: Add support for
	Behringer/Mackie devices
Date: Wed, 13 Aug 2014 16:00:57 +0900
Message-ID: <53EB0D29.5070001@sakamocchi.jp>
References: <1399991272-5807-1-git-send-email-o-takashi@sakamocchi.jp>	<1399991272-5807-13-git-send-email-o-takashi@sakamocchi.jp>	<53E795C5.1010506@ladisch.de>
 <53E95664.7020707@sakamocchi.jp>	<53E9C33A.2090508@ladisch.de>
 <53EAA15D.1030306@sakamocchi.jp> <53EB08B6.6080908@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp302.phy.lolipop.jp (smtp302.phy.lolipop.jp [210.157.22.85])
 by alsa0.perex.cz (Postfix) with ESMTP id 491B22654CD
 for <alsa-devel@alsa-project.org>; Wed, 13 Aug 2014 09:01:08 +0200 (CEST)
In-Reply-To: <53EB08B6.6080908@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org, stefanr@s5r6.in-berlin.de, "fen >> Jay Fenlason" <fenlason@redhat.com>
List-Id: alsa-devel@alsa-project.org

On Aug 13 2014 15:41, Clemens Ladisch wrote:
> The OXFW devices work with Core Audio, so they are marked as AV/C
> devices; the DICE devices are not.  So it would be possible to use
> different specifier_id/version entries.

OK. As long as using SPECIFIER_1394TA (0x00a02d) and
VERSION_AVC(0x010001), OXFW driver doesn't probe Mackie devices based on
Dice.

> Anyway, the Windows DICE driver uses detection by name, too; the .inf
> entries show a different vendor name:
> 
>  1394\LOUD&Onyxi
>  1394\LOUD&OnyxBlackbird

The latter revisions use "Onyxi", however the former revisons use
"Onyx-i". That's nice to distinguish.


Thanks

Takashi Sakamoto
(In summer vacation)
o-takashi@sakamocchi.jp
