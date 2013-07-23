From: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH] ARM: kirkwood: enable S/PDIF
Date: Tue, 23 Jul 2013 15:12:56 +0200
Message-ID: <51EE8158.4050300@gmail.com>
References: <20130723102320.56bc4555@armhf>
 <20130723084347.GP24642@n2100.arm.linux.org.uk>
 <20130723130622.GB9858@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f54.google.com (mail-bk0-f54.google.com
 [209.85.214.54])
 by alsa0.perex.cz (Postfix) with ESMTP id 392FE262626
 for <alsa-devel@alsa-project.org>; Tue, 23 Jul 2013 15:13:00 +0200 (CEST)
Received: by mail-bk0-f54.google.com with SMTP id it16so2979376bkc.27
 for <alsa-devel@alsa-project.org>; Tue, 23 Jul 2013 06:12:59 -0700 (PDT)
In-Reply-To: <20130723130622.GB9858@sirena.org.uk>
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
Cc: Jean-Francois Moine <moinejf@free.fr>, alsa-devel@alsa-project.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, Takashi Iwai <tiwai@suse.de>, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 07/23/13 15:06, Mark Brown wrote:
> On Tue, Jul 23, 2013 at 09:43:47AM +0100, Russell King - ARM Linux wrote:
>> On Tue, Jul 23, 2013 at 10:23:20AM +0200, Jean-Francois Moine wrote:
>>> This patch enables S/PDIF.
>
>>> Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
>
>> I'm not submitting my patch to do this because:
>
>> (a) we don't know what effect this has on other hardware.
>
> This patch will do absolutely nothing unless it's used in a machine
> driver which connects a S/PDIF CODEC to it.  I see no reason not to
> apply it, someone with hardware with more complex needs can always build
> on it later.
>

Mark,

the mask that is changed in the patch is what will be written
into i2s controller's registers. So, if there is no S/PDIF in that 
specific controller that bit can possibly have a different meaning.
Also, enabling both I2S playback and SPDIF playback can cause the
controller to behave differently.

I share Russell's concern about it and would rather like to use
multiple codecs per DAI (DPCM) for that. I see Daniel Mack picked
that up again, maybe he submits something soon.

Sebastian
