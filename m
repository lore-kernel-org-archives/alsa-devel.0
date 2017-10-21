From: Carlo Caione <carlo@endlessm.com>
Subject: Re: [PATCH] ASoC: rt5651: Convert rt5651 micbias1 to a
	supply widget
Date: Sat, 21 Oct 2017 15:51:41 +0100
Message-ID: <CAL9uMOF4mnAB5t052-rM7djqnQyHEKQcStBZKRTryk7PPLWZPQ@mail.gmail.com>
References: <20171018170631.9189-1-carlo@caione.org>
 <20171021100948.xsjekidnls6ookoo@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vk0-f65.google.com (mail-vk0-f65.google.com
 [209.85.213.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 8EF24266CE2
 for <alsa-devel@alsa-project.org>; Sat, 21 Oct 2017 16:51:43 +0200 (CEST)
Received: by mail-vk0-f65.google.com with SMTP id k195so8888540vke.10
 for <alsa-devel@alsa-project.org>; Sat, 21 Oct 2017 07:51:43 -0700 (PDT)
In-Reply-To: <20171021100948.xsjekidnls6ookoo@sirena.org.uk>
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
Cc: Oder Chiou <oder_chiou@realtek.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Carlo Caione <carlo@caione.org>, Bard Liao <bardliao@realtek.com>, Linux Upstreaming Team <linux@endlessm.com>
List-Id: alsa-devel@alsa-project.org

On Sat, Oct 21, 2017 at 11:09 AM, Mark Brown <broonie@kernel.org> wrote:
> On Wed, Oct 18, 2017 at 06:06:31PM +0100, Carlo Caione wrote:
>> From: Carlo Caione <carlo@endlessm.com>
>>
>> MICBIAS widget type has been deprecated. Convert it to a SUPPLY widget.
>
> Do we have any machine drivers using this?  If it was just a simple
> substitution then we'd have just done the conversion but the routing for
> MICBIAS was funky, requiring that it be looped into the path.

We have bytcr_rt5651.c already using it as a supply (source) widget.
Also this change is required to have the jack detection working fine
using the set of patches posted in [0]

thanks,

[0] https://www.spinics.net/lists/kernel/msg2630096.html

-- 
Carlo Caione  |  +39.340.80.30.096  |  Endless
