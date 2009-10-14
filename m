From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCHv2 5/7] ASoC: TWL6030: Add support for
 low-power mode
Date: Wed, 14 Oct 2009 16:57:31 +0100
Message-ID: <20091014155731.GA31863@rakim.wolfsonmicro.main>
References: <67059DBF19D7214F9C66BB0EA91BA90E90A391E3@dlee04.ent.ti.com>
	<20090928132800.GD31899@rakim.wolfsonmicro.main>
	<67059DBF19D7214F9C66BB0EA91BA90E90D5EE30@dlee04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2D46A103912
	for <alsa-devel@alsa-project.org>;
	Wed, 14 Oct 2009 17:57:32 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <67059DBF19D7214F9C66BB0EA91BA90E90D5EE30@dlee04.ent.ti.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 13, 2009 at 03:15:45PM -0500, Lopez Cruz, Misael wrote:

> From TWL6030 CODEC driver pespective, the DAI link supported rate
> should be 48kHz or 96kHz? If the final goal is to explicitly represent
> all links in the system (ABE, Phoenix, McBSP, etc), then ABE link
> should expose somehow that it delives upsampled data. If that assumption
> is true, then TWL6030 DAI should support 96kHz.

Yes, that sounds like the way to go.

> A second concern is that runtime constraints will prevent rates
> supported by the system, when the constraints are only valid for the
> link. For example, if the TWL6030 CODEC adds a contraint for 96kHz,
> then it prevents the whole system to play 48kHz, which is supported
> when ABE is enabled since ABE upsamples it.

Initially I'd say that we should only represent the requirements on each
end of a given link and make the devices responsible for imposing
constraints that come from routing between two interfaces.  We'd need to
see how all this works in practice, though.
