From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH 1/2] ASoC: soc-generic-dmaengine-pcm: Fix
 error handling
Date: Mon, 26 Feb 2018 11:35:46 -0300
Message-ID: <CAOMZO5AAviObXtDb+TXk+Q3RiMz=0d7OhP=d3Y17xZjsf7DUCQ@mail.gmail.com>
References: <1519326142-26421-1-git-send-email-festevam@gmail.com>
 <d9a1ebd2-b64b-3f2d-7d7d-27e0678cdaa7@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ot0-f174.google.com (mail-ot0-f174.google.com
 [74.125.82.174])
 by alsa0.perex.cz (Postfix) with ESMTP id 96C3A26757B
 for <alsa-devel@alsa-project.org>; Mon, 26 Feb 2018 15:35:48 +0100 (CET)
Received: by mail-ot0-f174.google.com with SMTP id w38so88466ota.8
 for <alsa-devel@alsa-project.org>; Mon, 26 Feb 2018 06:35:48 -0800 (PST)
In-Reply-To: <d9a1ebd2-b64b-3f2d-7d7d-27e0678cdaa7@metafoo.de>
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
Cc: Fabio Estevam <fabio.estevam@nxp.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Feb 26, 2018 at 11:25 AM, Lars-Peter Clausen <lars@metafoo.de> wrote:

> This creates a resource leak. dmaengine_pcm_request_chan_of() requests both
> transmit and receive channels. It might return with an error if one of them
> fails, but the other one succeeded. In this case we need to call
> dmaengine_pcm_release_chan() to free the requested channel.

Ok, I will send a revert.
