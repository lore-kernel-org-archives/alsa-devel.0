From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH] ALSA: ASoC: ak4104: add reset line
	property to DT bindings
Date: Wed, 14 Nov 2012 18:54:12 +0800
Message-ID: <CACTFLAM68vtG-oKjV+AQtyeROZx1Ouku+Bz4MsN3EGOz=2uPgQ@mail.gmail.com>
References: <1352888919-25270-1-git-send-email-zonque@gmail.com>
 <20121114104344.GJ7407@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qc0-f179.google.com (mail-qc0-f179.google.com
 [209.85.216.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 0AC2A265261
 for <alsa-devel@alsa-project.org>; Wed, 14 Nov 2012 11:54:14 +0100 (CET)
Received: by mail-qc0-f179.google.com with SMTP id b14so144143qcs.38
 for <alsa-devel@alsa-project.org>; Wed, 14 Nov 2012 02:54:14 -0800 (PST)
In-Reply-To: <20121114104344.GJ7407@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 14, 2012 at 6:43 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Wed, Nov 14, 2012 at 06:28:39PM +0800, Daniel Mack wrote:
>> This device doesn't have a pdata definition for legacy boards, and
>> unless anyone need to control the reset GPIO, it's not worth adding one.
>> So this feature is only available to DT users for now.
>>
>> Signed-off-by: Daniel Mack <zonque@gmail.com>
>> ---
>>  Documentation/devicetree/bindings/sound/ak4104.txt |  5 +++++
>
> This doesn't apply, the bindings file doesn't exist in mainline or -next
> - probably an earlier patch you forgot to submit.

I submitted that some weeks ago - it's in your topic/ak4104 branch :)

  https://git.kernel.org/?p=linux/kernel/git/broonie/sound.git;a=commit;h=ac5dbea
