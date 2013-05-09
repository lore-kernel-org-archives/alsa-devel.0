From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v3] ASoC: sgtl5000: Fix driver probe after
	reset
Date: Thu, 9 May 2013 15:07:46 -0300
Message-ID: <CAOMZO5Awf2YG0b1S5inTDDs5yYf4TyPM5GWvB+5ys=k1bFe5Hw@mail.gmail.com>
References: <1368120063-20655-1-git-send-email-fabio.estevam@freescale.com>
 <518BDFF4.2070403@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vc0-f181.google.com (mail-vc0-f181.google.com
 [209.85.220.181])
 by alsa0.perex.cz (Postfix) with ESMTP id E2971260795
 for <alsa-devel@alsa-project.org>; Thu,  9 May 2013 20:07:47 +0200 (CEST)
Received: by mail-vc0-f181.google.com with SMTP id hr11so2891126vcb.26
 for <alsa-devel@alsa-project.org>; Thu, 09 May 2013 11:07:47 -0700 (PDT)
In-Reply-To: <518BDFF4.2070403@metafoo.de>
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, matt@genesi-usa.com, eric.nelson@boundarydevices.com, troy.kisky@boundarydevices.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, May 9, 2013 at 2:42 PM, Lars-Peter Clausen <lars@metafoo.de> wrote:

> I don't see how this is different from v2, except that it is now opencoding
> the register reading and is sharing a driver global variable between
> multiple instances (which is kind of a no-go).

Actually I like v2 better, but Mark stated:

"I'm not sure that removing the defaults is the ideal thing here - it
means that the driver will be stuck with whatever the last booted OS
left the device running which may or may not be sane.  Explicitly
writing in all the values we want seems safer, that way we know how the
device is configured and there's less potential for odd bugs caused by
rebooting at the wrong moment."

So I would appreciate any suggestions.
