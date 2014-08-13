From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH 12/15] oxfw: Add support for
	Behringer/Mackie	devices
Date: Wed, 13 Aug 2014 09:07:55 +0200
Message-ID: <53EB0ECB.2060109@ladisch.de>
References: <1399991272-5807-1-git-send-email-o-takashi@sakamocchi.jp>	<1399991272-5807-13-git-send-email-o-takashi@sakamocchi.jp>	<53E795C5.1010506@ladisch.de>
 <53E95664.7020707@sakamocchi.jp>	<53E9C33A.2090508@ladisch.de>
 <53EAA15D.1030306@sakamocchi.jp> <53EB08B6.6080908@ladisch.de>
 <53EB0D29.5070001@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 41FFE2654D3
 for <alsa-devel@alsa-project.org>; Wed, 13 Aug 2014 09:07:57 +0200 (CEST)
In-Reply-To: <53EB0D29.5070001@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: alsa-devel@alsa-project.org, stefanr@s5r6.in-berlin.de, "fen >> Jay Fenlason" <fenlason@redhat.com>
List-Id: alsa-devel@alsa-project.org

Takashi Sakamoto wrote:
> On Aug 13 2014 15:41, Clemens Ladisch wrote:
>> Anyway, the Windows DICE driver uses detection by name, too; the .inf
>> entries show a different vendor name:
>>
>>  1394\LOUD&Onyxi
>>  1394\LOUD&OnyxBlackbird
>
> The latter revisions use "Onyxi", however the former revisons use
> "Onyx-i". That's nice to distinguish.

The OXFW driver has entries for both names:

"AVC\Loud_Technologies_Inc.&Onyxi&typ_1"
"AVC\Loud_Technologies_Inc.&Onyx-i&typ_1"


Regards,
Clemens
