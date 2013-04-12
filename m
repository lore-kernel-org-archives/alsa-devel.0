From: "Gabriel M. Beddingfield" <gabrbedd@gmail.com>
Subject: Re: [PATCH] ASoC: define playback and capture streams
	in dummy codec
Date: Fri, 12 Apr 2013 08:13:56 -0700
Message-ID: <516824B4.20802@gmail.com>
References: <5167E7C4.7080501@list.ru>
 <20130412105943.GU9243@opensource.wolfsonmicro.com>
 <20130412181943.0338083b@stas>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f179.google.com (mail-pd0-f179.google.com
 [209.85.192.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 802492616C1
 for <alsa-devel@alsa-project.org>; Fri, 12 Apr 2013 17:14:11 +0200 (CEST)
Received: by mail-pd0-f179.google.com with SMTP id x11so1456391pdj.38
 for <alsa-devel@alsa-project.org>; Fri, 12 Apr 2013 08:14:10 -0700 (PDT)
In-Reply-To: <20130412181943.0338083b@stas>
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
Cc: ALSA devel <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Lars-Peter Clausen <lars@metafoo.de>, stsp@users.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On 04/12/2013 07:19 AM, Stas Sergeev wrote:
> On Fri, 12 Apr 2013 11:59:44 +0100
> Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:
>>> This patch adds a playback and capture streams to the dummy codec DAI
>>> configuration. Most permissive set of sampling rates and formats is used.
>> The changelog ought to explain why this is required...
> I can only tell that without this patch I am not getting any
> sound at all... which is probably a rather poor statement for
> the changelog. Could you please correct the changelog with the
> better knowledge of the details?

He means that the commit message.  Your commit message says what the 
patch does.  It does not say why the patch is needed.

-gabriel
