From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: SDP3430: Fix TWL GPIO6 pin mux
 request
Date: Tue, 25 Aug 2009 19:30:16 +0100
Message-ID: <20090825183016.GB4317@sirena.org.uk>
References: <2256F256009DAA4CBE661E9F41EAC84B72A1D84E@dlee01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id E629524344
	for <alsa-devel@alsa-project.org>;
	Tue, 25 Aug 2009 20:30:22 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <2256F256009DAA4CBE661E9F41EAC84B72A1D84E@dlee01.ent.ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Candelaria Villareal, Jorge" <x0107209@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Peter Ujfalusi <peter.ujfalusi@nokia.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 25, 2009 at 10:13:25AM -0500, Candelaria Villareal, Jorge wrote:
> Fix the write to PMBR1 register through I2C. Also, the constant which
> holds the value to write is now called TWL4030_GPIO6_PWM0_MUTE. This
> name is based on TRM to avoid confusion.

> Signed-off-by: Jorge Eduardo Candelaria <x0107209@ti.com>

Applied thanks (with Peter's ack for the previous submission).
