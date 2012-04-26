From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] ASoC: mxs-saif: Use devm_clk_get()
Date: Thu, 26 Apr 2012 08:35:03 -0300
Message-ID: <CAOMZO5DeSs3QnL2NuZm1ZKBOQY=Dt9qBuvpp=QSd7b4Mg2ouMQ@mail.gmail.com>
References: <1335414802-4972-1-git-send-email-festevam@gmail.com>
	<20120426092506.GB3207@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 6FE7910BA67
	for <alsa-devel@alsa-project.org>;
	Thu, 26 Apr 2012 13:35:04 +0200 (CEST)
Received: by eaak11 with SMTP id k11so271495eaa.38
	for <alsa-devel@alsa-project.org>; Thu, 26 Apr 2012 04:35:04 -0700 (PDT)
In-Reply-To: <20120426092506.GB3207@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 26, 2012 at 6:25 AM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:

> This is fine but devm_clk_get() is only in Russell's tree so it'll need
> to wait for after the merge window - can you please resend then?

devm_clk_get() is in linux-next. Isn't this ok?
