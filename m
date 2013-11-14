From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 19/20] ASoC: davinci-mcasp: Support for fck
	reparenting
Date: Thu, 14 Nov 2013 14:59:19 +0200
Message-ID: <5284C927.2040404@ti.com>
References: <1384421737-4467-1-git-send-email-peter.ujfalusi@ti.com>
 <1384421737-4467-20-git-send-email-peter.ujfalusi@ti.com>
 <20131114115110.GH26614@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
 by alsa0.perex.cz (Postfix) with ESMTP id 9679E2616F1
 for <alsa-devel@alsa-project.org>; Thu, 14 Nov 2013 13:59:21 +0100 (CET)
In-Reply-To: <20131114115110.GH26614@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, Michal Bachraty <michal.bachraty@streamunlimited.com>, nsekhar@ti.com, Liam Girdwood <lgirdwood@gmail.com>, jsarha@ti.com, Daniel Mack <zonque@gmail.com>, gururaja.hebbar@ti.com
List-Id: alsa-devel@alsa-project.org

On 11/14/2013 01:51 PM, Mark Brown wrote:
> On Thu, Nov 14, 2013 at 11:35:35AM +0200, Peter Ujfalusi wrote:
> =

>> +- fck_parent : Should contain a valid clock name which will be used as =
parent
>> +	       for the McASP fck
> =

> I'd expect this to be specified using standard clock tree bindings?

As of now we do not have (AM33xx/AM43xx/DRA7xx) clocks in DT so the standard
clock tree bindings can not be added (no phandle to link).
In arch OMAP we have another issue coming from legacy: omap-hwmod will treat
the standard clock bindings as optional clocks and when the device got enab=
led
it enables the main fck and also the optional clocks. This will not cause b=
ig
issue at the end, but the prepare/enable count for the parent clock will be
doubled. fck enable will enable the branch (including parent) and the
omap-hwmod code will enable the optional clocks, which includes the parent
clock :o

For now I would keep the parent clock name and when we have the standard cl=
ock
bindings ready I can switch to use to that.

-- =

P=E9ter
