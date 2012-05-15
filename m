From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] ASoC: twl6040: Support for DT
Date: Tue, 15 May 2012 10:41:53 +0300
Message-ID: <4FB208C1.2080503@ti.com>
References: <20120509133511.GQ3955@opensource.wolfsonmicro.com>
	<4FACF1C2.7050008@ti.com>
	<20120511130816.GB3960@opensource.wolfsonmicro.com>
	<20120514153414.GM5140@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog125.obsmtp.com (na3sys009aog125.obsmtp.com
	[74.125.149.153])
	by alsa0.perex.cz (Postfix) with ESMTP id 951A324C5E
	for <alsa-devel@alsa-project.org>;
	Tue, 15 May 2012 09:41:46 +0200 (CEST)
Received: by laap9 with SMTP id p9so5523814laa.22
	for <alsa-devel@alsa-project.org>; Tue, 15 May 2012 00:41:43 -0700 (PDT)
In-Reply-To: <20120514153414.GM5140@atomide.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Tony Lindgren <tony@atomide.com>
Cc: alsa-devel@alsa-project.org, "Cousson, Benoit" <b-cousson@ti.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Misael Lopez Cruz <misael.lopez@ti.com>, Liam Girdwood <lrg@ti.com>, Samuel Ortiz <sameo@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On 05/14/2012 06:34 PM, Tony Lindgren wrote:
> I agree we should not omit the register ranges from DT. That is
> hardware specific information that other operating systems possibly
> need, and they don't have hwmod.

I was considering to do that for the omap-mcpdm, omap-dmic. I think the
reason I did not done it is that none of the other dt sections for OMAP
devices have this information (most probably for a reason).

-- =

P=E9ter
