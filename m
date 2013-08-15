From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH 2/5] ASoC: pxa: pxa-ssp: add DT bindings
Date: Thu, 15 Aug 2013 12:51:31 +0200
Message-ID: <520CB2B3.9050804@gmail.com>
References: <1376296961-20564-1-git-send-email-zonque@gmail.com>
 <1376296961-20564-3-git-send-email-zonque@gmail.com>
 <20130815103358.GY2401@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ea0-f171.google.com (mail-ea0-f171.google.com
 [209.85.215.171])
 by alsa0.perex.cz (Postfix) with ESMTP id 01B81261A9C
 for <alsa-devel@alsa-project.org>; Thu, 15 Aug 2013 12:51:33 +0200 (CEST)
Received: by mail-ea0-f171.google.com with SMTP id n15so286666ead.16
 for <alsa-devel@alsa-project.org>; Thu, 15 Aug 2013 03:51:33 -0700 (PDT)
In-Reply-To: <20130815103358.GY2401@sirena.org.uk>
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
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, eric.y.miao@gmail.com, arnd@arndb.de, s.neumann@raumfeld.com, haojian.zhuang@linaro.org, rmk+kernel@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On 15.08.2013 12:33, Mark Brown wrote:
> On Mon, Aug 12, 2013 at 10:42:38AM +0200, Daniel Mack wrote:
>> The pxa ssp DAI acts as a user of a pxa ssp port, and needs an
>> appropriate 'port' phandle in DT to reference the upstream.
> 
> I've applied this and the rest of the series though I'm not really that
> happy about having a binding for the DAI in the DT since there's at best
> tenouous hardware there.
> 

Hmm, and you don't like the approach either of having upstream ports and
assign users to it via phandles?

Also note that the last patch in that series ("ASoC: pxa: add DT
bindings for pxa2xx-pcm") can be omitted, as Lars pointed out. I'll have
to care for a proper solution at some point.


Daniel
