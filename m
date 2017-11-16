From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v7 03/13] slimbus: Add SLIMbus bus type
Date: Thu, 16 Nov 2017 16:13:58 +0000
Message-ID: <b02bc1c6-1107-f6b5-06d0-670700acdb26@linaro.org>
References: <20171115141043.29202-1-srinivas.kandagatla@linaro.org>
 <20171115141043.29202-4-srinivas.kandagatla@linaro.org>
 <20171116131814.GV3187@localhost>
 <e2fa6b56-965d-74e7-af2f-77baf0f50901@linaro.org>
 <20171116161426.GA3187@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f41.google.com (mail-wm0-f41.google.com [74.125.82.41])
 by alsa0.perex.cz (Postfix) with ESMTP id BB0F9266EE4
 for <alsa-devel@alsa-project.org>; Thu, 16 Nov 2017 17:14:01 +0100 (CET)
Received: by mail-wm0-f41.google.com with SMTP id y80so1318530wmd.0
 for <alsa-devel@alsa-project.org>; Thu, 16 Nov 2017 08:14:01 -0800 (PST)
In-Reply-To: <20171116161426.GA3187@localhost>
Content-Language: en-US
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
Cc: mark.rutland@arm.com, alsa-devel@alsa-project.org, michael.opdenacker@free-electrons.com, poeschel@lemonage.de, andreas.noever@gmail.com, arnd@arndb.de, treding@nvidia.com, devicetree@vger.kernel.org, james.hogan@imgtec.com, pawel.moll@arm.com, linux-arm-msm@vger.kernel.org, sharon.dvir1@mail.huji.ac.il, robh+dt@kernel.org, sdharia@codeaurora.org, alan@linux.intel.com, bp@suse.de, mathieu.poirier@linaro.org, jkosina@suse.cz, linux-kernel@vger.kernel.org, broonie@kernel.org, daniel@ffwll.ch, gregkh@linuxfoundation.org, joe@perches.com, davem@davemloft.net
List-Id: alsa-devel@alsa-project.org



On 16/11/17 16:14, Vinod Koul wrote:
>>>> +static int slim_device_match(struct device *dev, struct device_driver *drv)
>>>> +{
>>>> +	struct slim_device *sbdev = to_slim_device(dev);
>>>> +	struct slim_driver *sbdrv = to_slim_driver(drv);
>>>> +
>>>> +	return slim_match(sbdrv->id_table, sbdev) != NULL;
>>> return !!slim_match() ?
> I guess you missed this one..
Opps, It makes sense I will change it.

> 
