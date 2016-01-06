From: Mathias Krause <minipli@googlemail.com>
Subject: Re: [PATCH] ASoC: rt5645: Constify ACPI device ids
Date: Wed, 6 Jan 2016 09:01:28 +0100
Message-ID: <CA+rthh-LWKOh+JrKVZU3kZnxnkFWXz+tu-P6NMUcYhPy=xyWWg@mail.gmail.com>
References: <1451773436-25518-1-git-send-email-minipli@googlemail.com>
 <20160104013210.GI16023@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yk0-f176.google.com (mail-yk0-f176.google.com
 [209.85.160.176])
 by alsa0.perex.cz (Postfix) with ESMTP id 2D93E260412
 for <alsa-devel@alsa-project.org>; Wed,  6 Jan 2016 09:01:29 +0100 (CET)
Received: by mail-yk0-f176.google.com with SMTP id x67so308135439ykd.2
 for <alsa-devel@alsa-project.org>; Wed, 06 Jan 2016 00:01:29 -0800 (PST)
In-Reply-To: <20160104013210.GI16023@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org, John Lin <john.lin@realtek.com>
List-Id: alsa-devel@alsa-project.org

On 4 January 2016 at 02:32, Mark Brown <broonie@kernel.org> wrote:
> On Sat, Jan 02, 2016 at 11:23:56PM +0100, Mathias Krause wrote:
>> Constify the ACPI device ID array, no need to have it writable at
>> runtime. Also drop the unused RT5645_INIT_REG_LEN define.
>
> Please don't mix multiple unrelated changes in a single patch,
> especially when there's no content overlap at all :(

I've seen you've applied the patch nonetheless. So I guess you don't
want me to split the patch any more?

Regards,
Mathias
