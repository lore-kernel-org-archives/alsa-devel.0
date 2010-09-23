From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/3] ASoC: Remove unneeded WM9713 header
 include from SMDK WM9713 driver
Date: Thu, 23 Sep 2010 15:49:21 +0100
Message-ID: <20100923144921.GI25663@rakim.wolfsonmicro.main>
References: <1285252845-24171-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<AANLkTinyw_wMdRvup4HJ5kuUYY=N-Y6kFEM4N88hz_PR@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D23C5103941
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Sep 2010 16:49:22 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <AANLkTinyw_wMdRvup4HJ5kuUYY=N-Y6kFEM4N88hz_PR@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Jassi Brar <jassi.brar@samsung.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 23, 2010 at 11:46:20PM +0900, Jassi Brar wrote:

> If it compiles now,

> Acked-by: Jassi Brar <jassi.brar@samsung.com>

Yes, the change to multi-component means that there's no direct
references to the DAI structures or CODEC device in the machine drivers
(it's just directly written strings) and since the SMDKs use the
standard AC'97 clock there's no need for any reconfiguration of the
clocking, the defines for which are the normal reason machine drivers
still need to include the CODEC header.
