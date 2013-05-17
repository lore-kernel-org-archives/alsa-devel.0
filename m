From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 3/6] ASoC: ux500: Drop pinctrl sleep support
Date: Sat, 18 May 2013 00:02:18 +0200
Message-ID: <CACRpkdbZ4Wxx7qsyYOfFES-UpTTcRcfV6GZi-R8YmxhC-sLV8g@mail.gmail.com>
References: <1367997261-32048-1-git-send-email-fabio.baltieri@linaro.org>
 <1367997261-32048-4-git-send-email-fabio.baltieri@linaro.org>
 <20130508105124.GA7478@sirena.org.uk>
 <20130508114216.GB29130@balto.lan>
 <20130508123225.GK7478@sirena.org.uk>
 <20130508131020.GA30503@balto.lan>
 <20130508135413.GR7478@sirena.org.uk>
 <20130508141723.GA12155@balto.lan>
 <20130508142938.GS7478@sirena.org.uk>
 <20130508154805.GA12970@balto.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ie0-f171.google.com (mail-ie0-f171.google.com
 [209.85.223.171])
 by alsa0.perex.cz (Postfix) with ESMTP id EED63261683
 for <alsa-devel@alsa-project.org>; Sat, 18 May 2013 00:02:19 +0200 (CEST)
Received: by mail-ie0-f171.google.com with SMTP id e11so10492231iej.30
 for <alsa-devel@alsa-project.org>; Fri, 17 May 2013 15:02:19 -0700 (PDT)
In-Reply-To: <20130508154805.GA12970@balto.lan>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Baltieri <fabio.baltieri@linaro.org>
Cc: Ola Lilja <ola.o.lilja@stericsson.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Mark Brown <broonie@kernel.org>, Lee Jones <lee.jones@linaro.org>
List-Id: alsa-devel@alsa-project.org

On Wed, May 8, 2013 at 5:48 PM, Fabio Baltieri
<fabio.baltieri@linaro.org> wrote:
> On Wed, May 08, 2013 at 03:29:38PM +0100, Mark Brown wrote:

>> It seems like the code is definitely buggy here but is this really all
>> that's buggy or is it just the symptom you happen to have seen?
>
> For the pinctrl code drop I still think that it should go, but really
> I leave the last word to LinusW as suggested.

Kill it then.

At the time the driver was upstreamed, it was using the old
nmk_config_pins() interface to switch the pins.

All I did was convert them to use pinctrl. See commit
08d98fe0e81cd9424ef2451ed13afe91a9a26f9f

If nobody knows why it was doing that in the first place, let's
just kill it.

Yours,
Linus Walleij
