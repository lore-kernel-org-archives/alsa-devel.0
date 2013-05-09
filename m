From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v3] ASoC: sgtl5000: Fix driver probe after
 reset
Date: Thu, 09 May 2013 20:10:33 +0200
Message-ID: <518BE699.6050409@metafoo.de>
References: <1368120063-20655-1-git-send-email-fabio.estevam@freescale.com>
 <518BDFF4.2070403@metafoo.de>
 <CAOMZO5Awf2YG0b1S5inTDDs5yYf4TyPM5GWvB+5ys=k1bFe5Hw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-141.synserver.de (smtp-out-143.synserver.de
 [212.40.185.143])
 by alsa0.perex.cz (Postfix) with ESMTP id B7EBD260795
 for <alsa-devel@alsa-project.org>; Thu,  9 May 2013 20:11:01 +0200 (CEST)
In-Reply-To: <CAOMZO5Awf2YG0b1S5inTDDs5yYf4TyPM5GWvB+5ys=k1bFe5Hw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, matt@genesi-usa.com, eric.nelson@boundarydevices.com, troy.kisky@boundarydevices.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On 05/09/2013 08:07 PM, Fabio Estevam wrote:
> On Thu, May 9, 2013 at 2:42 PM, Lars-Peter Clausen <lars@metafoo.de> wrote:
> 
>> I don't see how this is different from v2, except that it is now opencoding
>> the register reading and is sharing a driver global variable between
>> multiple instances (which is kind of a no-go).
> 
> Actually I like v2 better, but Mark stated:
> 
> "I'm not sure that removing the defaults is the ideal thing here - it
> means that the driver will be stuck with whatever the last booted OS
> left the device running which may or may not be sane.  Explicitly
> writing in all the values we want seems safer, that way we know how the
> device is configured and there's less potential for odd bugs caused by
> rebooting at the wrong moment."
> 
> So I would appreciate any suggestions.

I think what Mark suggested was to take the register defaults and write them
to the registers in your probe function, so you'll always end up in the same
state.

- Lars
