From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH 5/5] ASoC: pxa: add DT bindings for
	pxa2xx-pcm
Date: Mon, 12 Aug 2013 11:17:21 +0200
Message-ID: <5208A821.6060604@gmail.com>
References: <1376296961-20564-1-git-send-email-zonque@gmail.com>
 <1376296961-20564-6-git-send-email-zonque@gmail.com>
 <5208A424.70704@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f50.google.com (mail-bk0-f50.google.com
 [209.85.214.50])
 by alsa0.perex.cz (Postfix) with ESMTP id 0F20A26030A
 for <alsa-devel@alsa-project.org>; Mon, 12 Aug 2013 11:17:24 +0200 (CEST)
Received: by mail-bk0-f50.google.com with SMTP id mz11so1765628bkb.37
 for <alsa-devel@alsa-project.org>; Mon, 12 Aug 2013 02:17:23 -0700 (PDT)
In-Reply-To: <5208A424.70704@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, eric.y.miao@gmail.com, arnd@arndb.de, s.neumann@raumfeld.com, broonie@kernel.org, haojian.zhuang@linaro.org, rmk+kernel@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On 12.08.2013 11:00, Lars-Peter Clausen wrote:
> On 08/12/2013 10:42 AM, Daniel Mack wrote:
>> The bindings do not carry any resources, as the module only registers
>> the ASoC platform driver.
>>
>> Signed-off-by: Daniel Mack <zonque@gmail.com>
> 
> As this is just a virtual device (and Linux specific) it shouldn't be in the 
> devicetree. Usually when using devicetree you'd register the PCM device from 
> the CPU DAI driver. Take a look at how other platforms (e.g. tegra) do this.

Ok, then please ignore this one for now.


Thanks,
Daniel
