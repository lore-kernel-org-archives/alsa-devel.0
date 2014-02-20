From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH] ASoC: Intel: sst-acpi: Add support for
 multiple machine drivers per platform
Date: Thu, 20 Feb 2014 09:04:48 +0200
Message-ID: <5305A910.2000507@linux.intel.com>
References: <1392820558-27548-1-git-send-email-jarkko.nikula@linux.intel.com>
 <20140219161544.GM2669@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id ABDB2265715
 for <alsa-devel@alsa-project.org>; Thu, 20 Feb 2014 08:04:52 +0100 (CET)
In-Reply-To: <20140219161544.GM2669@sirena.org.uk>
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
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi

On 02/19/2014 06:15 PM, Mark Brown wrote:
> On Wed, Feb 19, 2014 at 04:35:58PM +0200, Jarkko Nikula wrote:
>
>> Matching machine driver is found by looking at ACPI ID which would best
>> match with the driver. Typically this would be the ACPI ID of audio codec
>> but is not tied to it.
> You're going to need DMI matching as well, there's going to be quirks of
> some kind.  Otherwise this looks fine if an ugly way of doing it,
> assuming Liam is happy.
Yes, I believe so too. Although we don't have yet a machine that has 
routed audio differently around the same codec in a same platform but 
I'm sure that will happen. Then I think it's a case by case decision 
will that be better to handle in the same machine driver or here in the 
loader.

Our target is to get as much as possible data from ACPI but meanwhile 
there will be machines where only data is basically just the SST and 
codec ACPI IDs + DMI or some other unique identifier.

-- 
Jarkko
