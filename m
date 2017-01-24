From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] ASoC: ux500: do not moan on deferrals
Date: Tue, 24 Jan 2017 13:49:15 +0100
Message-ID: <CACRpkdZd4UZKYhB7KazM2+LDtA=CiwG97u3vjhPa4fXPGAUNJQ@mail.gmail.com>
References: <20170120132011.1147-1-linus.walleij@linaro.org>
 <20170123181516.tr55l7mmqkhr25s6@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-it0-f54.google.com (mail-it0-f54.google.com
 [209.85.214.54])
 by alsa0.perex.cz (Postfix) with ESMTP id 4846C261740
 for <alsa-devel@alsa-project.org>; Tue, 24 Jan 2017 13:49:18 +0100 (CET)
Received: by mail-it0-f54.google.com with SMTP id c7so84650000itd.1
 for <alsa-devel@alsa-project.org>; Tue, 24 Jan 2017 04:49:18 -0800 (PST)
In-Reply-To: <20170123181516.tr55l7mmqkhr25s6@sirena.org.uk>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 23, 2017 at 7:15 PM, Mark Brown <broonie@kernel.org> wrote:
> On Fri, Jan 20, 2017 at 02:20:11PM +0100, Linus Walleij wrote:

>> This removes the "error" print on probe deferral, it's
>> unnecessary and confusing. Also cut a few debug prints we do
>> not need.
>
> I know I took the other patch doing this (along with some other changes)
> but in general I'm not super comfortable with just silently ignoring
> probe deferral errors as it makes it hard to debug practical systems -
> the device is there, the driver is there but it fails to instantiate
> with no indication as to why.

You're right. Let's drop this, the only improvement could I guess
be to print explicitly that things get deferred instead, unless by now
every kernel developer in the world knows what -517 means.

Yours,
Linus Walleij
