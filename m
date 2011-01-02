From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: sh: fsi-da7210: remove unnecessary
 format settings
Date: Sun, 2 Jan 2011 13:50:59 +0000
Message-ID: <20110102135059.GF4935@opensource.wolfsonmicro.com>
References: <w3psjxi8mqm.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B498F245FA
	for <alsa-devel@alsa-project.org>; Sun,  2 Jan 2011 14:50:41 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <w3psjxi8mqm.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, Dec 28, 2010 at 02:55:45PM +0900, Kuninori Morimoto wrote:
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Applied, though if this is the default setup it'd not be a problem to
keep the code so that when the driver does support other configurations
the machine driver doesn't need modification.
