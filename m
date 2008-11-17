From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH RESEND 1/3] ALSA SOC driver for s3c24xx
	with uda1341
Date: Mon, 17 Nov 2008 11:32:59 +0000
Message-ID: <20081117113259.GB1559@sirena.org.uk>
References: <12267358962868-git-send-email-chripell@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 5C3CB243A3
	for <alsa-devel@alsa-project.org>; Mon, 17 Nov 2008 12:33:00 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <12267358962868-git-send-email-chripell@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Christian Pellegrin <chripell@gmail.com>
Cc: alsa-devel@alsa-project.org, linux-arm-kernel@lists.arm.linux.org.uk, Christian Pellegrin <chripell@fsfe.org>
List-Id: alsa-devel@alsa-project.org

On Sat, Nov 15, 2008 at 08:58:16AM +0100, Christian Pellegrin wrote:

> Signed-off-by: Christian Pellegrin <chripell@fsfe.org>

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

but this

>  sound/soc/codecs/uda134x_codec.h |   36 ++

should just be uda134x.h for consistency with everything else - I'll fix
this up before pushing.
