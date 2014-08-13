From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH 12/15] oxfw: Add support for
	Behringer/Mackie	devices
Date: Wed, 13 Aug 2014 08:41:58 +0200
Message-ID: <53EB08B6.6080908@ladisch.de>
References: <1399991272-5807-1-git-send-email-o-takashi@sakamocchi.jp>
 <1399991272-5807-13-git-send-email-o-takashi@sakamocchi.jp>
 <53E795C5.1010506@ladisch.de> <53E95664.7020707@sakamocchi.jp>
 <53E9C33A.2090508@ladisch.de> <53EAA15D.1030306@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 5E44B2654E9
 for <alsa-devel@alsa-project.org>; Wed, 13 Aug 2014 08:41:59 +0200 (CEST)
In-Reply-To: <53EAA15D.1030306@sakamocchi.jp>
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
> On Aug 12 2014 16:33, Clemens Ladisch wrote:
>> Or just do the detection like the Windows driver, through the vendor/
>> model name strings (this is what my old Fireworks driver did because
>> I didn't know all model IDs; see match_echofire_device_name).  The
>> Mackie driver's .inf file has this list of device identifiers:
>>
>> "AVC\Loud_Technologies_Inc.&Onyxi&typ_1"
>> "AVC\Loud_Technologies_Inc.&Onyx_1640i&typ_1"
>> "AVC\Loud_Technologies_Inc.&Onyx-i&typ_1"
>> "AVC\Loud_Technologies_Inc.&d.Pro&typ_1"
>> "AVC\Loud_Technologies_Inc.&Mackie_Onyx_Satellite&typ_1"
>> "AVC\Loud_Technologies_Inc.&Tapco_LINK.firewire_4x6&typ_1"
>> "AVC\Loud_Technologies_Inc.&U.420&typ_1"
>> "AVC\Mackie&Onyx_Firewire&typ_1"
>
> This is a good idea.
>
> I note that Mackie Onyx-i series has two revisions. OXFW was used for
> the former revision. Dice is used for the latter revision. See:
> http://www.mackie.com/products/onyxiseries/drivers/
>
> When using this idea, we have a need to distinguish these two revisions
> for prevention from applying OXFW driver to the latter revision. Do you
> have any good idea?

The OXFW devices work with Core Audio, so they are marked as AV/C
devices; the DICE devices are not.  So it would be possible to use
different specifier_id/version entries.

Anyway, the Windows DICE driver uses detection by name, too; the .inf
entries show a different vendor name:

 1394\LOUD&Onyxi
 1394\LOUD&OnyxBlackbird


Regards,
Clemens
