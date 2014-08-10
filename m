From: Daniel Mack <daniel@zonque.org>
Subject: Re: can't insmod patched snd-usb-audio
Date: Sun, 10 Aug 2014 13:57:04 +0200
Message-ID: <53E75E10.7080805@zonque.org>
References: <20140809114001.GA7938@x1-orm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id 2CF2F2610A3
 for <alsa-devel@alsa-project.org>; Sun, 10 Aug 2014 13:57:06 +0200 (CEST)
In-Reply-To: <20140809114001.GA7938@x1-orm>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Orm Finnendahl <orm.finnendahl@selma.hfmdk-frankfurt.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 08/09/2014 01:40 PM, Orm Finnendahl wrote:
>  hope it's ok to post it here as it's not (yet) official alsa: After
> having no issues with Tobias Hoffmann's scarlett alsa mixer patch on
> my older kernels, trying to insmod the patched kernel modules on my
> most current kernel (the patch and documentation obtained with
> "git clone http://github.com/trrichard/alsa-driver_scarlett.git")
> fails with the following message:

Interesting. Why isn't this patch mainline? Keeping such things
out-of-tree are likely to cause maintenance overhead in the future, and
people who don't want to (or are unable to) compile a kernel themselves
will not benefit from it.

Tobias doesn't seem to have a public mail address (at least I didn't
find any in his GH profile), so I can't ask him whether he considers
sending a patch for inclusion.

Orm, would you be up for it? It needs to be done by someone with access
to the hardware for testing. There are some things that need cleanup,
but we can best discuss those in replies to a patch.


Thanks,
Daniel
