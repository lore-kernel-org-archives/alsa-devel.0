From: "Jie, Yang" <yang.jie@intel.com>
Subject: Re: [PATCH] ASoC:rt286: set combo jack by dmi
Date: Wed, 5 Nov 2014 23:05:18 +0000
Message-ID: <E7B1D079BA13FB44A978CC8F69C7D6A901B51DE6@SHSMSX101.ccr.corp.intel.com>
References: <1415164166-15512-1-git-send-email-bardliao@realtek.com>
 <20141105172311.GF8509@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id C9F962614FF
 for <alsa-devel@alsa-project.org>; Thu,  6 Nov 2014 00:09:31 +0100 (CET)
In-Reply-To: <20141105172311.GF8509@sirena.org.uk>
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
To: Mark Brown <broonie@kernel.org>, "bardliao@realtek.com" <bardliao@realtek.com>
Cc: "oder_chiou@realtek.com" <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lars@metafoo.de" <lars@metafoo.de>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "flove@realtek.com" <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org


> -----Original Message-----
> From: Mark Brown [mailto:broonie@kernel.org]
> Sent: Thursday, November 06, 2014 1:23 AM
> To: bardliao@realtek.com
> Cc: lgirdwood@gmail.com; alsa-devel@alsa-project.org; lars@metafoo.de;
> flove@realtek.com; oder_chiou@realtek.com; Jie, Yang
> Subject: Re: [PATCH] ASoC:rt286: set combo jack by dmi
> 
> On Wed, Nov 05, 2014 at 01:09:26PM +0800, bardliao@realtek.com wrote:
> 
> > +static struct dmi_system_id intel_platform[] __initdata = {
> > +	{
> 
> This is fine but can you please rename the variable from intel_platform to
> something more meaningful like the name of the reference design these are
> derived from or something?  That way if we need to add some other quirk
> (and I guess we will) we won't have to rename this table - I guess anything
> that's using a DMI quirk will be some Intel based platform.
[Keyon] maybe we can use something like 'combo_jack_platform'?
