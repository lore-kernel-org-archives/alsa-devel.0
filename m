From: Fabio Estevam <festevam@gmail.com>
Subject: ASoC: Failed to create component debugfs directory
Date: Mon, 19 Feb 2018 15:49:11 -0300
Message-ID: <CAOMZO5D071pPr4fL7eLwWgX6h8Mppwic2u4mUCGzUZiss-+3MQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ot0-f178.google.com (mail-ot0-f178.google.com
 [74.125.82.178])
 by alsa0.perex.cz (Postfix) with ESMTP id 71268266DFD
 for <alsa-devel@alsa-project.org>; Mon, 19 Feb 2018 19:49:13 +0100 (CET)
Received: by mail-ot0-f178.google.com with SMTP id p8so6482468otf.2
 for <alsa-devel@alsa-project.org>; Mon, 19 Feb 2018 10:49:13 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

On linux-next I see the following errors on imx6 wandboard:

[    3.040897] fsl-ssi-dai 2028000.ssi: ASoC: Failed to create
component debugfs directory
[    3.065722] fsl-spdif-dai 2004000.spdif: ASoC: Failed to create
component debugfs directory

I haven't started debugging this yet and not sure if this is something
fsl driver specific.

Any ideas?

Thanks
