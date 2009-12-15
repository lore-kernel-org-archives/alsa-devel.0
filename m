From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2] ASoC: ak4642: Add default return
	value	in ak4642_modinit
Date: Tue, 15 Dec 2009 14:54:53 +0000
Message-ID: <20091215145453.GB30710@sirena.org.uk>
References: <ufx7cvbnt.wl%morimoto.kuninori@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id D85FC1037FB
	for <alsa-devel@alsa-project.org>; Tue, 15 Dec 2009 15:54:56 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <ufx7cvbnt.wl%morimoto.kuninori@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Magnus <magnus.damm@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Dec 15, 2009 at 03:54:21PM +0900, Kuninori Morimoto wrote:
> If ak4642 driver was compiled without I2C configs,
> ak4642_modinit return value will become un-stable.
> This patch modify this bug
> 
> Reported-by: Magnus Damm <damm@opensource.se>
> Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>

Applied, thanks.
