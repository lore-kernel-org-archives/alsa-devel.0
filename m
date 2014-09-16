From: Liam Girdwood <liam.r.girdwood@intel.com>
Subject: Re: [PATCH v2] ASoC: rt286: Set cbj_en for ACPI devices
Date: Tue, 16 Sep 2014 08:31:54 +0100
Message-ID: <1410852714.23184.49.camel@loki>
References: <1410399654-10371-1-git-send-email-bardliao@realtek.com>
 <20140912135558.GW7960@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 0B6E226567F
 for <alsa-devel@alsa-project.org>; Tue, 16 Sep 2014 09:36:47 +0200 (CEST)
In-Reply-To: <20140912135558.GW7960@sirena.org.uk>
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
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, graeme.gregory@linaro.org, lgirdwood@gmail.com, bardliao@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

On Fri, 2014-09-12 at 14:55 +0100, Mark Brown wrote:
> On Thu, Sep 11, 2014 at 09:40:54AM +0800, bardliao@realtek.com wrote:
> 
> > +/* the default platform data for acpi devices */
> > +static struct rt286_platform_data rt286_acpi_data = {
> > +	.cbj_en = true,
> > +	.gpio2_en = false,
> > +};
> > +
> >  static const struct acpi_device_id rt286_acpi_match[] = {
> > -	{ "INT343A", 0 },
> > +	{ "INT343A", (unsigned long)&rt286_acpi_data },
> >  	{},
> >  };
> 
> Why does this platform data apply to all boards using this ACPI ID?
> Shouldn't this be _DSD data instead, or should we be doing quirks based
> on DMI data?

Sadly there is no data within most/all current BIOSes that have this
ACPI id for the RT286. The BIOSes are a little behind in the development
here compared to the codec driver. So it's probably we will have to
support this and _DSD with this particular driver.

Liam

---------------------------------------------------------------------
Intel Corporation (UK) Limited
Registered No. 1134945 (England)
Registered Office: Pipers Way, Swindon SN3 1RJ
VAT No: 860 2173 47

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.
