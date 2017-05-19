From: Romain Perier <romain.perier@collabora.com>
Subject: Re: [PATCH v3 1/3] SoC: es8328-i2c: Add compatible for
	ES8323
Date: Fri, 19 May 2017 09:00:02 +0200
Message-ID: <39efbb88-2faa-bea5-7862-a43909a8e7f6@collabora.com>
References: <20170512132227.24916-1-romain.perier@collabora.com>
 <20170512132227.24916-10-romain.perier@collabora.com>
 <20170515214138.u63u7j53jogk3prm@rob-hp-laptop>
 <20170516111837.3uf5f5jbdkrnjudi@sirena.org.uk>
 <a052da20-d9c7-69f5-21d9-9111d45702e6@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 by alsa0.perex.cz (Postfix) with ESMTP id 0B4742675CB
 for <alsa-devel@alsa-project.org>; Fri, 19 May 2017 09:00:05 +0200 (CEST)
In-Reply-To: <a052da20-d9c7-69f5-21d9-9111d45702e6@collabora.com>
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
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Heiko Stuebner <heiko@sntech.de>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-rockchip@lists.infradead.org, Kumar Gala <galak@codeaurora.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org



Le 19/05/2017 =E0 08:56, Romain Perier a =E9crit :
> Hello,
>
>
> Le 16/05/2017 =E0 13:18, Mark Brown a =E9crit :
>> On Mon, May 15, 2017 at 04:41:38PM -0500, Rob Herring wrote:
>>> On Fri, May 12, 2017 at 03:22:25PM +0200, Romain Perier wrote:
>>>> This commit adds a compatible string for everest,es8323. This is an
>>>> audio codec that is compatible with es8328 and can be found for example
>>>> on the Firefly-RK3288 board.
>>> If it is compatible with the es8328, then that should be a fallback and =

>>> you don't need the driver change.
>> While people don't strictly need the driver change it doesn't do any
>> harm either and encourages people to get the information into the DT
>> that it's a different chip.  Thinking about it it might be good to have
>> a way for something to validate if fallback compatibles are being listed
>> when they should - the drivers could provide the information fairly
>> easily I guess, or it could go into the binding docs once we have a
>> schema format.
>>
>> Even if it doesn't currently make a difference to software I'd rather
>> get the information in there for mixed signal devices like audio CODECs
>> - it's not that unknown to find later that supposedly register identical
>> chips have some differences in the analog which we want to care about.
> So, what should I do for this patch, finally ? fallback or driver change ?
>
> Thanks,
> Romain

To be honest, the doc is not really clear about this, both codecs seem
compatible but I think that's preferable to have a driver change for
this, just in case (Suppose that we discover a difference later...)

Romain
