From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/3] ASoC: TWL4030: Enable voice filters
 for voice sidetone
Date: Fri, 19 Jun 2009 10:58:08 +0100
Message-ID: <20090619095808.GD5270@sirena.org.uk>
References: <67059DBF19D7214F9C66BB0EA91BA90E3543F31C@dlee04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 5B8E310389A
	for <alsa-devel@alsa-project.org>;
	Fri, 19 Jun 2009 11:58:15 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <67059DBF19D7214F9C66BB0EA91BA90E3543F31C@dlee04.ent.ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Lopez Cruz, Misael" <x0052729@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Peter Ujfalusi <peter.ujfalusi@nokia.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Jun 19, 2009 at 03:23:41AM -0500, Lopez Cruz, Misael wrote:
> Digital voice loopback (sidetone) requires voice filters
> to be enabled: VTXL, VTXR, VRX.

Is it possible to handle this by inserting DAPM widgets for these
filters into the bypass paths and letting DAPM power them up?  I'm also
wondering if with the new bias level management stuff which keeps the
codec in BIAS_ON while any DAPM widgets are powered some of the bypass
mode stuff can be removed or simplified?

I'm OK with the change if Peter acks it, I've not got detailed knowledge
of the TWL4030.
