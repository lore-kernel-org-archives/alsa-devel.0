From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: [PATCH 1/2] ASoC: rt5677: Add ACPI device probing
Date: Tue, 25 Nov 2014 14:28:06 +0000
Message-ID: <1416925686.7260.28.camel@loki>
References: <1416034608-24238-1-git-send-email-benzh@chromium.org>
 <CACxGe6stjCvaQZkh=hFcF-56v5qJVar11jRZz0PRSd2wz6EUyA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 129E226582D
 for <alsa-devel@alsa-project.org>; Tue, 25 Nov 2014 15:30:16 +0100 (CET)
In-Reply-To: <CACxGe6stjCvaQZkh=hFcF-56v5qJVar11jRZz0PRSd2wz6EUyA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel <alsa-devel@alsa-project.org>, Darren Hart <dvhart@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Liam Girdwood <lgirdwood@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ben Zhang <benzh@chromium.org>, Mark Brown <broonie@kernel.org>, Anatol Pomozov <anatol@google.com>, Bard Liao <bardliao@realtek.com>, Dylan Reid <dgreid@chromium.org>, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

On Tue, 2014-11-25 at 12:11 +0000, Grant Likely wrote:
> On Sat, Nov 15, 2014 at 6:56 AM, Ben Zhang <benzh@chromium.org> wrote:
> > The rt5677 codec driver looks for ACPI device ID "RT5677CE",
> > which is specified in coreboot. This patch allows platform
> > data to be obtained via ACPI
> >
> > Signed-off-by: Ben Zhang <benzh@chromium.org>
> 
> This looks like an ideal time to talk about shared DT and ACPI driver
> bindings. This driver /already/ has a firmware binding. It is
> documented in the kernel under
> Documentation/bindings/sound/rt5677.txt. We now have a standard method
> for sharing bindings between DT and ACPI in the _DSD method[1].
> Support for DSD is in linux-next and getting merged into v3.19. This
> is exactly the case that _DSD should be used for passing additional
> data to the driver, and it should use the existing binding.
> 
> [1] http://www.uefi.org/sites/default/files/resources/_DSD-device-properties-UUID.pdf
> 
> For a long time we've had the rule on DT that new bindings must be
> documented before we merge a patch. That rule I think has been a good
> one, even if it is a little chaoitc. I think when it comes to ACPI
> drivers that we should be requiring the same: Document the binding,
> either in the kernel as a DT binding, or point to somewhere else that
> has the binding documented.
> 
> Also, since this patch is targeted at v3.19 or later, the
> device-properties API should be used. Don't create something custom.
> 

My sentiments exactly, there would be little point having bespoke device
properties for every single device. Btw, we also need to align here with
Windows too !

Liam
