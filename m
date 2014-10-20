From: Anatol Pomozov <anatol.pomozov@gmail.com>
Subject: Re: [PATCH] ASoC: rt5677: add GPIO IRQ support
Date: Mon, 20 Oct 2014 15:24:41 -0700
Message-ID: <CAOMFOmWF3Y86fYb0=XiHGU9cTWG6QyakUSokX628XsZtfywjKA@mail.gmail.com>
References: <1413483866-38815-1-git-send-email-anatol.pomozov@gmail.com>
 <20141017124805.GP1820@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yh0-f47.google.com (mail-yh0-f47.google.com
 [209.85.213.47])
 by alsa0.perex.cz (Postfix) with ESMTP id E0F13260673
 for <alsa-devel@alsa-project.org>; Tue, 21 Oct 2014 00:24:42 +0200 (CEST)
Received: by mail-yh0-f47.google.com with SMTP id c41so4245516yho.34
 for <alsa-devel@alsa-project.org>; Mon, 20 Oct 2014 15:24:41 -0700 (PDT)
In-Reply-To: <20141017124805.GP1820@sirena.org.uk>
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
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi

On Fri, Oct 17, 2014 at 5:48 AM, Mark Brown <broonie@kernel.org> wrote:

> On Thu, Oct 16, 2014 at 11:24:26AM -0700, Anatol Pomozov wrote:
> > This allows to enable Mic Jack detection feature
> >
> > Author: Oder Chiou <oder_chiou@realtek.com>
> > Modified-by: Anatol Pomozov <anatol.pomozov@gmail.com>
> > Signed-off-by: Anatol Pomozov <anatol.pomozov@gmail.com>
>
> I can't really apply this without a signoff from Oder I'm afraid - Oder?
>


A bit of background about this patch. After our off-list discussion about
GPIO support Oder sent us this change. I cleaned up, added more features
(like dts) and tested it. Everything looks good so far. We also agreed that
I help to upstream this patch.

Oder could you please also send "Sign-off:" message? This message says you
are the original author and agreed to upstream the patch.
