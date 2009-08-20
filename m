From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 4/4] sh: add FSI driver support for
 ms7724se
Date: Thu, 20 Aug 2009 20:06:26 +0100
Message-ID: <20090820190626.GH5032@sirena.org.uk>
References: <utz02d78o.wl%morimoto.kuninori@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 64192103817
	for <alsa-devel@alsa-project.org>;
	Thu, 20 Aug 2009 21:06:34 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <utz02d78o.wl%morimoto.kuninori@renesas.com>
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
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, lethal@linux-sh.org, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, Aug 20, 2009 at 09:01:27PM +0900, Kuninori Morimoto wrote:
> Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>

> o become independent patch

It looks like this should have another change to register the CODEC as
an I2C device?  Other than that it's fine from an ASoC point of view -
is it OK to merge via ASoC due to the dependency on the platform data
for the FSI?
