From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v2 1/2] ASoC: export
 dapm_kcontrol_set/get_value functions
Date: Fri, 30 May 2014 14:50:10 +0200
Message-ID: <53887E82.9030508@metafoo.de>
References: <1401357817-17942-1-git-send-email-vinod.koul@intel.com>
 <5387120B.6090100@metafoo.de> <20140530060918.GN21128@intel.com>
 <5388319F.9030703@metafoo.de> <20140530102944.GP21128@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-092.synserver.de (smtp-out-096.synserver.de
 [212.40.185.96])
 by alsa0.perex.cz (Postfix) with ESMTP id 1B23D264F45
 for <alsa-devel@alsa-project.org>; Fri, 30 May 2014 14:50:20 +0200 (CEST)
In-Reply-To: <20140530102944.GP21128@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, Peter Ujfalusi <peter.ujfalusi@ti.com>, broonie@kernel.org, Kp Jeeja <jeeja.kp@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

On 05/30/2014 12:29 PM, Vinod Koul wrote:
[...]
>> Btw. in this case I think you should just use the default DAPM
>> kcontrol put callback. There doesn't seem to be anything special in
>> here and with the DAPM componentization series the default handler
>> is also able to handle platforms.
> Not for this version sure, but future platforms of our need some custom stuff to
> be done. I will try to minimize those ones and once your component work is
> complete redo these bits. Would be too happy to remove if it works out that way,
> which is not the case with today. So till then we need these bits and exporting
> of the dapm_kcontrol_set_value()
>

You do not need to call dapm_kcontrol_set_value() from your custom put 
handler unless the control is auto-muted or a virtual control, of which 
neither seems to be the case here. So we do not need to export the function.

- Lars
