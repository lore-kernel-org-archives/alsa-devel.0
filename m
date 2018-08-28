From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] sound: Convert to using %pOFn instead of
	device_node.name
Date: Tue, 28 Aug 2018 10:54:39 +0300
Message-ID: <CAHp75VeBTdugxXeM9wj=x-JarLqRcmZzwDLav71RM66FcP-xjQ@mail.gmail.com>
References: <20180828015252.28511-1-robh@kernel.org>
 <20180828015252.28511-50-robh@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qt0-f174.google.com (mail-qt0-f174.google.com
 [209.85.216.174])
 by alsa0.perex.cz (Postfix) with ESMTP id E89BB2676BD
 for <alsa-devel@alsa-project.org>; Tue, 28 Aug 2018 09:54:51 +0200 (CEST)
Received: by mail-qt0-f174.google.com with SMTP id z8-v6so655777qto.9
 for <alsa-devel@alsa-project.org>; Tue, 28 Aug 2018 00:54:51 -0700 (PDT)
In-Reply-To: <20180828015252.28511-50-robh@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Rob Herring <robh@kernel.org>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Johannes Berg <johannes@sipsolutions.net>, "open list:LINUX FOR POWERPC PA SEMI PWRFICIENT" <linuxppc-dev@lists.ozlabs.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 28, 2018 at 4:56 AM Rob Herring <robh@kernel.org> wrote:
>
> In preparation to remove the node name pointer from struct device_node,
> convert printf users to use the %pOFn format specifier.

> +       if (snprintf(node_name, sizeof(node_name), "%pOFn", np) != 5)
>                 return 0;

> +       if (strncmp(np, "i2s-", 4))
>                 return 0;

Shouldn't be node_name here?



-- 
With Best Regards,
Andy Shevchenko
