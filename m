From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH] ASoC: core: Configure pin muxing via
 pinctrl when registering a DAI
Date: Mon, 24 Sep 2012 09:38:43 -0600
Message-ID: <50607E83.6010805@wwwdotorg.org>
References: <1348214066-28384-1-git-send-email-peter.ujfalusi@ti.com>
 <20120921111352.GA21524@opensource.wolfsonmicro.com>
 <505C68AA.7080907@ti.com> <505C9496.1050307@wwwdotorg.org>
 <CACRpkdZ=_qm-g-LDth8m43Cug4LoMsD3FuvTiiyQgP=chGTAUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
 by alsa0.perex.cz (Postfix) with ESMTP id B52722615E7
 for <alsa-devel@alsa-project.org>; Mon, 24 Sep 2012 17:38:50 +0200 (CEST)
In-Reply-To: <CACRpkdZ=_qm-g-LDth8m43Cug4LoMsD3FuvTiiyQgP=chGTAUw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Magnus Damm <magnus.damm@gmail.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On 09/24/2012 02:34 AM, Linus Walleij wrote:
> On Fri, Sep 21, 2012 at 6:23 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
>> On 09/21/2012 07:16 AM, Peter Ujfalusi wrote:
>>>
>>> pinctrl_get_select() returns with a pointer to struct pinctrl. If the platform
>>> does not have CONFIG_PINCTRL enabled it will return with NULL.
>>> If no pinctrl has been specified for the device it will return with error
>>> (-ENODEV).
>>> Neither of these cases should be considered as error. We do print out with
>>> dev_info() to notify the developer, but having pinctrl mux should not be
>>> mandatory.
>>
>> Indeed - what about a platform like Tegra which has pinctrl enabled, yet
>> doesn't specify any pinctrl configuration for any device other than the
>> pin controller itself?
> 
> It would be fixed by calling pinctrl_provide_dummies() right?
> 
> Not that it's elegant or anything ...

Right - calling pinctrl_provide_dummies() ends up telling the pinctrl
core never to return an error even when it "should". I don't think it's
appropriate to use that API at all except to help out transitioning a
particular SoC to use pinctrl.
