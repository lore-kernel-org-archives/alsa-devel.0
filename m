From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v2 2/6] ASoC: Davinci: McBSP: add device
 tree support for McBSP
Date: Mon, 18 Apr 2016 13:35:43 +0300
Message-ID: <5714B87F.1000408@ti.com>
References: <1460375117-4311-1-git-send-email-petr@barix.com>
 <1460375117-4311-3-git-send-email-petr@barix.com> <5710B516.2000006@ti.com>
 <5714A864.5050505@barix.com> <5714B469.1040408@ti.com> <5714B5F6.9@barix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 by alsa0.perex.cz (Postfix) with ESMTP id D00A7265132
 for <alsa-devel@alsa-project.org>; Mon, 18 Apr 2016 12:35:49 +0200 (CEST)
In-Reply-To: <5714B5F6.9@barix.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Petr Kulhavy <petr@barix.com>, nsekhar@ti.com, khilman@kernel.org, lgirdwood@gmail.com, broonie@kernel.org, devicetree@vger.kernel.org
Cc: mark.rutland@arm.com, alsa-devel@alsa-project.org, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, robh+dt@kernel.org, galak@codeaurora.org
List-Id: alsa-devel@alsa-project.org

On 04/18/16 13:24, Petr Kulhavy wrote:
> =

> =

> On 18.04.2016 12:18, Peter Ujfalusi wrote:
>> On 04/18/16 12:27, Petr Kulhavy wrote:
>>
>>> Or what do you think the pdata should carry?
>> Good question. Since the driver itself does not care about pdata I would
>> remove it. On the other hand if you implement the FIFO handling you will=
 need
>> pdata for legacy mode to select the FIFO threshold.
>> Currently there is one pdata structure for legacy mode used by the McASP,
>> McBSP and the Voice Codec. It contains mixed options applicable for all =
and
>> some which applicable only for one of the drivers...
>> I think if we want to make things clean and neat we would aim to have se=
parate
>> pdata for each of the drivers.
>>
>> I would probably drop the current pdata for McBSP and when I see what da=
ta I
>> need for the driver later I would create one for the McBSP only.
>>
> =

> Thanks, Peter. I agree with you.
> I don't have the time to implement the FIFO now, so it makes sense to dro=
p the
> pdata for now and add a dedicated one if needed later.
> Shall I remove the pdata also from the EVK legacy board drivers?

Yes please. It is not used and not applicable either.

> I'm going to prepare another patch set.

-- =

P=E9ter
