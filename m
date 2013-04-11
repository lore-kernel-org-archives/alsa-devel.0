From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] asoc: add dummy codec
Date: Thu, 11 Apr 2013 12:41:23 +0200
Message-ID: <51669353.7090903@metafoo.de>
References: <51669249.8090100@list.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-204.synserver.de (smtp-out-204.synserver.de
 [212.40.185.204])
 by alsa0.perex.cz (Postfix) with ESMTP id 91E4A265FFC
 for <alsa-devel@alsa-project.org>; Thu, 11 Apr 2013 12:42:19 +0200 (CEST)
In-Reply-To: <51669249.8090100@list.ru>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stas Sergeev <stsp@list.ru>
Cc: ALSA devel <alsa-devel@alsa-project.org>, Steve Chen <schen@mvista.com>
List-Id: alsa-devel@alsa-project.org

On 04/11/2013 12:36 PM, Stas Sergeev wrote:
> Hi.
> 
> The attached patch adds a dummy codec for the
> asoc subsystem.
> I use it with the driver that programs the soc to drive
> I2S from an internal PLLs, and the audio then goes to
> HDMI, so no external codec is used.
> I've found spdif_transciever.c, which exactly is such a
> dummy driver, but it is bound to the particular plat
> device, so I made the device name a config option, and
> if not set, the plat device is created with the default
> name.
> 
> It may be possible to avoid the usage of the codec driver
> at all, but I haven't succeeded with this, and the existance
> of spdif_transciever.c suggests there is no such way.
> Thoughts?
> 
> Signed-off-by: Stas Sergeev <stsp@users.sourceforge.net>
> 

Hi,

There is already a dummy codec driver.

Please take a look at sound/soc/soc-utils.c

- Lars
