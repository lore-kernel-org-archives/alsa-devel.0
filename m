From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: ASoC: Intel: sst: Missing IRQ at index 5 on BYT-T
	device
Date: Wed, 9 Jan 2019 15:10:53 -0600
Message-ID: <235ba68c-1a43-6c9e-3bbb-6872dd39a036@linux.intel.com>
References: <20181216185429.GA20408@gerhold.net>
 <e82d5720-3c73-3dff-1b31-dae9a0b09408@redhat.com>
 <20181217180330.GA845@gerhold.net> <20190109192241.GN10405@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id E2E2226743A
 for <alsa-devel@alsa-project.org>; Wed,  9 Jan 2019 22:10:55 +0100 (CET)
In-Reply-To: <20190109192241.GN10405@sirena.org.uk>
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
To: Mark Brown <broonie@kernel.org>, Stephan Gerhold <stephan@gerhold.net>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org, Jie Yang <yang.jie@linux.intel.com>
List-Id: alsa-devel@alsa-project.org


On 1/9/19 1:22 PM, Mark Brown wrote:
> On Mon, Dec 17, 2018 at 07:03:31PM +0100, Stephan Gerhold wrote:
>
>> Side note:
>> I have considered fixing this in the DSDT table a few times before but
>> have never tried it because it kind of feels wrong to me. It would
>> probably work, but I believe the kernel is at fault here:
>> I've been fixing mistakes and adding missing GPIOs to the DSDT, but is
>> this really the case here? Everything that is needed for the driver
>> exists in the ACPI table. If this was a BYT-CR device, it would work
>> as-is, with no additional modifications.
>> Now, in order to fulfill the current expectations for BYT-T devices,
>> I would need to add 4 additional IRQs that would never be used.
>> But which IRQs would I list there? Dummy/invalid IRQs? To me, that
>> does not sound like the DSDT will become any more valid.
>> Let me know what you think! :)
> This thread appears to have died without a conclusion I can see?  I
> don't have strong feelings here, it seems like it's a choice between
> different evils so people working on the platform should make the call.

this was fixed by the v2 patch applied on January 4?

[alsa-devel] Applied "ASoC: Intel: sst: Fallback to BYT-CR if IRQ 5 is 
missing" to the asoc tree
