From: Frank Rowand <frowand.list@gmail.com>
Subject: Re: [RESEND PATCH v2 1/2] device property: Add
 function to search for named child of device
Date: Mon, 13 Jun 2016 12:32:32 -0700
Message-ID: <575F0A50.1090107@gmail.com>
References: <cover.1464802265.git.Adam.Thomson.Opensource@diasemi.com>
 <7105258db927c65dfa41a8abeef4b9735871d023.1464802265.git.Adam.Thomson.Opensource@diasemi.com>
 <97f80018-7cc4-0a50-498d-89d27dfa2fd1@intel.com>
 <2E89032DDAA8B9408CB92943514A0337D46421B6@SW-EX-MBX01.diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f67.google.com (mail-pa0-f67.google.com
 [209.85.220.67])
 by alsa0.perex.cz (Postfix) with ESMTP id 3357426577A
 for <alsa-devel@alsa-project.org>; Mon, 13 Jun 2016 21:32:40 +0200 (CEST)
Received: by mail-pa0-f67.google.com with SMTP id hf6so3203930pac.2
 for <alsa-devel@alsa-project.org>; Mon, 13 Jun 2016 12:32:40 -0700 (PDT)
In-Reply-To: <2E89032DDAA8B9408CB92943514A0337D46421B6@SW-EX-MBX01.diasemi.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Adam, Adam.Thomson.Opensource@diasemi.com, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Jaroslav Kysela <perex@perex.cz>, Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>, Rob Herring <rob.herring@linaro.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Support Opensource <Support.Opensource@diasemi.com>, Hanjun Guo <hanjun.guo@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Takashi Iwai <tiwai@suse.com>, Robert Moore <robert.moore@intel.com>, Liam Girdwood <lgirdwood@gmail.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Mark Brown <broonie@kernel.org>, Lv Zheng <lv.zheng@intel.com>, Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>, Bjorn Helgaas <bhelgaas@google.com>, Andrew Morton <akpm@linux-foundation.org>, "devel@acpica.org" <devel@acpica.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi Adam,

(comment below and adding Rob to the cc:)

On 06/10/16 02:58, Opensource [Adam Thomson] wrote:
> On 10 June 2016 00:11, Rafael J. Wysocki wrote:
> 
>> For some reason that didn't make it into the linux-acpi list, or at
>> least I can't see it there.
> 
> That's strange. I'm not a subscriber to that mailing list, but I assume that
> shouldn't matter here? Strangely though the only mailing list these seem to have
> made it to is the ALSA one. :( Will see if I can find out why as I've not
> seen this problem before.
> 
>>> + * device_get_named_child_node - Return first matching named child node
>> handle
>>> + * @dev: Device to find the named child node for.
>>> + * @childname: String to match child node name against.
>>> + */
>>> +struct fwnode_handle *device_get_named_child_node(struct device *dev,
>>> +						  const char *childname)
>>> +{
>>> +	struct fwnode_handle *child;
>>> +
>>> +	/*
>>> +	 * Find first matching named child node of this device.
>>> +	 * For ACPI this will be a data only sub-node.
>>> +	 */
>>> +	device_for_each_child_node(dev, child) {
>>> +		if (is_of_node(child)) {
>>> +			if (!strcasecmp(to_of_node(child)->name, childname))
>>
>> Why do you use strcasecmp() here?
> 
> DT node names are case insensitive. The of.h header does provide a helper macro
> which is equivalent to this, but that macro is part of the '#ifdef CONFIG_OF'
> block. If I were to use it then it would cause non-DT builds to fail. I opted
> for strcasecmp() directly as I didn't think for just this one scenario it made
> sense to reorganise the of.h header with regards to the helper macros. Of course
> if there are other opinions on this then am happy to listen.

DT node names are not always case insensitive.  Please us of_node_cmp().

-Frank

> 
>>> +static inline bool acpi_data_node_match(struct fwnode_handle *fwnode,
>>> +					const char *name)
>>> +{
>>> +	return is_acpi_data_node(fwnode) ?
>>> +		(!strcasecmp(to_acpi_data_node(fwnode)->name, name)) : false;
>>> +}
>>
>> Is there any particular reason to introduce this function instead of
>> doing the test in device_get_named_child_node() directly?
> 
> Again this is a build related design option (I mention it in the patch
> description). In a non-DT build there is no access to the acpi_data_node struct
> (returned by to_acpi_data_node() call) so if we call this in that scenario then
> the build will fail. I could have added some #ifdefs to the
> device_get_named_child_node() function directly, but that would have been a bit
> messy I think. To me it made more sense to have this helper function which can
> be called regardless of build type, and for non-ACPI builds its definition
> always returns false.
> 
