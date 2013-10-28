From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: [alsa-devel] [RFC] ASoC: core: Allow DAI links to be specified
 by using ACPI names
Date: Mon, 28 Oct 2013 11:53:14 +0000
Message-ID: <1382961194.2334.23.camel@loki>
References: <1380803636-24079-1-git-send-email-jarkko.nikula@linux.intel.com>
	 <20131024095118.GH31415@sirena.org.uk> <526A1568.9010100@linux.intel.com>
	 <20131025100618.GR18506@sirena.org.uk> <526A4B11.5000802@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <526A4B11.5000802@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: Mark Brown <broonie@kernel.org>, linux-acpi@vger.kernel.org, alsa-devel@alsa-project.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Fri, 2013-10-25 at 13:42 +0300, Jarkko Nikula wrote:
> On 10/25/2013 01:06 PM, Mark Brown wrote:
> > OK, I was asking because I was thinking of applying the patch for now; 
> > it's not that it's a bad idea it just seems like it's something that 
> > might might make sense solved at that level. Equally well I don't know 
> > if these systems will work with v3.13 anyway so perhaps it's not so 
> > urgent. 
> Yes, I don't see any urgent reason to push this hack in. Better to check 
> dev_name change first. What I'm going to propose there is "spix.y" to 
> "spi-INTABCD:xy" and "x-00yz" to "i2c-INTABCD:xy"
> 

We probably need to be able to match on ACPI name alone as some BIOS
settings can change the I2C bus number and break the name match used at
bind time. e.g. on Haswell the codec can either be on I2C bus 0 or 7.

Liam

