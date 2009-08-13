From: Barry Song <21cnbao@gmail.com>
Subject: Re: [PATCH 2/3] add set_tdm_slot in tdm dai to define
	the relationship between audio channel and tdm slot
Date: Thu, 13 Aug 2009 12:16:17 +0800
Message-ID: <3c17e3570908122116j3b859b11yacc768469ab476e9@mail.gmail.com>
References: <1250051574-25119-1-git-send-email-21cnbao@gmail.com>
	<1250051574-25119-2-git-send-email-21cnbao@gmail.com>
	<1250051574-25119-3-git-send-email-21cnbao@gmail.com>
	<20090812135608.GD11898@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f176.google.com (mail-yx0-f176.google.com
	[209.85.210.176])
	by alsa0.perex.cz (Postfix) with ESMTP id E5FCE24893
	for <alsa-devel@alsa-project.org>;
	Thu, 13 Aug 2009 06:16:37 +0200 (CEST)
Received: by yxe6 with SMTP id 6so686963yxe.16
	for <alsa-devel@alsa-project.org>; Wed, 12 Aug 2009 21:16:37 -0700 (PDT)
In-Reply-To: <20090812135608.GD11898@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Aug 12, 2009 at 9:56 PM, Mark
Brown<broonie@opensource.wolfsonmicro.com> wrote:
> On Wed, Aug 12, 2009 at 12:32:53PM +0800, Barry Song wrote:
>> For ad1938, the audio channel n just uses slot n, but for ad1836, it's
>> different, channel 0 uses slot 0, channel 1 uses slot 4, channels 2 uses
>> slot1, ... So add set_tdm_slot entry and use the mask field to define
>> the relationship between audio channel and slot number.
>
>> Signed-off-by: Barry Song <21cnbao@gmail.com>
>
> OK but this needs updating to the new tdm_slot() API too.
>
Fixed
