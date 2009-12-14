From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2 v2] ASoc: Add DA7210 codec device
	support for ALSA
Date: Mon, 14 Dec 2009 12:19:10 +0000
Message-ID: <20091214121910.GE22388@rakim.wolfsonmicro.main>
References: <utyvuchi3.wl%morimoto.kuninori@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 15FB010380B
	for <alsa-devel@alsa-project.org>; Mon, 14 Dec 2009 13:19:12 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <utyvuchi3.wl%morimoto.kuninori@renesas.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Magnus <magnus.damm@gmail.com>, Jason Coughlan <jason.coughlan@diasemi.com>, Dajun Chen <Dajun.Chen2@diasemi.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Dec 14, 2009 at 01:21:56PM +0900, Kuninori Morimoto wrote:
> This original driver was created by Dialog Semiconductor,
> and cleanuped by Kuninori Morimoto.
> Special thanks to David Chen.
> This became very simple ASoC codec driver,
> and it is tested by EcoVec24 board.

Applied both, thanks.  Clearly the CODEC driver is far from ideal and
will need updates to work on other systems but it gets you basic audio
up and running.
