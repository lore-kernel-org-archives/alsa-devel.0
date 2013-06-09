From: Fabio Estevam <festevam@gmail.com>
Subject: Re: Codec driver gets probed prior to the machine
	driver
Date: Sun, 9 Jun 2013 12:41:19 -0300
Message-ID: <CAOMZO5A4AEu=Dx0TFk0GfrRA8SVn43APvO8yBkyS9-E+Kq4GsQ@mail.gmail.com>
References: <CAOMZO5BzaAmt0BNXvSw+a18QorOBmEjGwaA5PoQ_D6mVb6QiUw@mail.gmail.com>
 <51B49B79.2040007@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vc0-f178.google.com (mail-vc0-f178.google.com
 [209.85.220.178])
 by alsa0.perex.cz (Postfix) with ESMTP id A17C1260306
 for <alsa-devel@alsa-project.org>; Sun,  9 Jun 2013 17:41:20 +0200 (CEST)
Received: by mail-vc0-f178.google.com with SMTP id id13so3864907vcb.9
 for <alsa-devel@alsa-project.org>; Sun, 09 Jun 2013 08:41:19 -0700 (PDT)
In-Reply-To: <51B49B79.2040007@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Shawn Guo <shawn.guo@linaro.org>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Troy Kisky <troy.kisky@boundarydevices.com>
List-Id: alsa-devel@alsa-project.org

Hi Lars-Peter,

On Sun, Jun 9, 2013 at 12:12 PM, Lars-Peter Clausen <lars@metafoo.de> wrote:

> This sounds as if the CODEC driver should enable the CODEC clock and not the
> machine driver.

Thanks, this works fine. Will send the patches soon.

Thanks for your help.

Fabio Estevam
