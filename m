From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 1/6] ASoC: davinci-mcbsp: add binding for
 McBSP
Date: Mon, 11 Apr 2016 11:11:18 +0300
Message-ID: <570B5C26.9080402@ti.com>
References: <1459948893-4206-1-git-send-email-petr@barix.com>
 <1459948893-4206-2-git-send-email-petr@barix.com> <570661A6.6020804@ti.com>
 <570778CC.1000600@barix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
 by alsa0.perex.cz (Postfix) with ESMTP id B85CF26070F
 for <alsa-devel@alsa-project.org>; Mon, 11 Apr 2016 10:11:24 +0200 (CEST)
In-Reply-To: <570778CC.1000600@barix.com>
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

On 04/08/16 12:24, Petr Kulhavy wrote:
> On 07.04.2016 15:33, Peter Ujfalusi wrote:
> =

>> Given that the driver is actually a driver for daVinci ASP and it comple=
tely
>> ignores registers introduced when the IP is renamed from ASP to McBSP,
>> should we say something about this? That the ASP is compatible or subset=
 of
>> McBSP (w/o the multichannel support) and these bindings could be used for
>> ASP, with adding new compatible? Or just leave that out and bother with =
it
>> when we have such a device booting with DT? =

> Hi Peter,
> =

> what do you think about the following formulation?
> =

> -- =

> This binding describes the "Multi-channel Buffered Serial Port" (McBSP)
> audio interface found in some TI DaVinci processors like the OMAP-L138 or=
 AM180x.
> =

> Some older DaVinci processors like the DM6446 or DA355 use a simpler vers=
ion of
> the digital audio interface, called ASP. This driver can support them as =
well if
> the appropriate compatible string is added.

Hrm, I don't think we should mention the ASP, it looks out of context.
The ASP will have compatible of ti,dm644x-asp or something similar. We shou=
ld
worry about this when the time comes.

-- =

P=E9ter
