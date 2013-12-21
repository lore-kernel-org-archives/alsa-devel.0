From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: simple-card: Add cpu_dai and
 codec_dai names NULL check
Date: Sat, 21 Dec 2013 14:42:58 +0000
Message-ID: <20131221144258.GM30815@sirena.org.uk>
References: <1387521591-15262-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 5B5D52616FF
 for <alsa-devel@alsa-project.org>; Sat, 21 Dec 2013 15:43:09 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1387521591-15262-1-git-send-email-Li.Xiubo@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Xiubo Li <Li.Xiubo@freescale.com>
Cc: fabio.estevam@freescale.com, alsa-devel@alsa-project.org, kuninori.morimoto.gx@renesas.com, tiwai@suse.de, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, Dec 20, 2013 at 02:39:50PM +0800, Xiubo Li wrote:
> The name of cpu DAI maybe omitted, and then strlen() will lead
> kernel panic.

Applied, thanks.
