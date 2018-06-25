From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 1/2] ASoC: rt5651: Add support for external
 amplifier enable GPIO
Date: Mon, 25 Jun 2018 14:19:02 +0200
Message-ID: <7cc86f0e-7bdd-2456-f0b8-4e869c228793@redhat.com>
References: <20180624130247.18150-1-hdegoede@redhat.com>
 <20180625104503.GA9413@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com
 [209.85.208.68])
 by alsa0.perex.cz (Postfix) with ESMTP id EA0AF26720C
 for <alsa-devel@alsa-project.org>; Mon, 25 Jun 2018 14:19:04 +0200 (CEST)
Received: by mail-ed1-f68.google.com with SMTP id r7-v6so1119370edq.10
 for <alsa-devel@alsa-project.org>; Mon, 25 Jun 2018 05:19:04 -0700 (PDT)
In-Reply-To: <20180625104503.GA9413@sirena.org.uk>
Content-Language: en-US
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
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Carlo Caione <carlo@endlessm.com>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org

Hi,

On 25-06-18 12:45, Mark Brown wrote:
> On Sun, Jun 24, 2018 at 03:02:46PM +0200, Hans de Goede wrote:
>> The rt5651 does not have a built-in speaker amplifier, so it is often
>> used together with an external amplifier. On some boards the external
>> amplifier's enable pin is driven through a GPIO, add support for this.
> 
> This obviously shouldn't be part of the CODEC driver since it's not part
> of the device, you should make a driver for GPIO controlled amplifiers
> and add it to the card.  There's actually a guy I've been talking to a
> bit on IRC recently who's just written one actually and will hopefully
> be posting it soon.

Hmm, that seems like a complicated solution to use for non DT platforms
I already need to deal with this in the sound/soc/intel/boards/bytcr_rt5651.c
machine driver (call devm_acpi_dev_add_driver_gpios), so I'm tempted to
model this a supply for the speaker (which it in essence is) inside the
machine driver and make that supply directly control the GPIO, would
that be acceptable?

Regards,

Hans
