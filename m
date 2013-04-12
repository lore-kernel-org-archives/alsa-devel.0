From: "Gabriel M. Beddingfield" <gabrbedd@gmail.com>
Subject: Re: [PATCH] ASoC: define playback and capture streams
	in dummy codec
Date: Fri, 12 Apr 2013 08:24:55 -0700
Message-ID: <51682747.9070300@gmail.com>
References: <5167E7C4.7080501@list.ru>
 <20130412105943.GU9243@opensource.wolfsonmicro.com>
 <20130412181943.0338083b@stas> <516824B4.20802@gmail.com>
 <51682633.70008@list.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f172.google.com (mail-pd0-f172.google.com
 [209.85.192.172])
 by alsa0.perex.cz (Postfix) with ESMTP id CED562616C1
 for <alsa-devel@alsa-project.org>; Fri, 12 Apr 2013 17:25:04 +0200 (CEST)
Received: by mail-pd0-f172.google.com with SMTP id 5so1469151pdd.17
 for <alsa-devel@alsa-project.org>; Fri, 12 Apr 2013 08:25:03 -0700 (PDT)
In-Reply-To: <51682633.70008@list.ru>
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
Cc: ALSA devel <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Lars-Peter Clausen <lars@metafoo.de>, stsp@users.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On 04/12/2013 08:20 AM, Stas Sergeev wrote:
>> He means that the commit message. Your commit message says what the
>> patch does. It does not say why the patch is needed.
> Yes.
> But what should I add to the commit message, if the
> only thing I know about this patch, is that I am not getting
> any sound without it? :) The reason should be obvious for
> whoever is familiar with that subsystem, but its not me.
>

Yep, just formalize the "I am not getting any sound with it" statement. 
:-)  Maybe something like: "Because snd-soc-dummy didn't declare any 
DAI, it was unable to be used for any audio streams."

-gabriel
