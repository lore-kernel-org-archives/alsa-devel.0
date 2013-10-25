From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [RFC] ASoC: core: Allow DAI links to be specified by using ACPI
 names
Date: Fri, 25 Oct 2013 13:42:25 +0300
Message-ID: <526A4B11.5000802@linux.intel.com>
References: <1380803636-24079-1-git-send-email-jarkko.nikula@linux.intel.com> <20131024095118.GH31415@sirena.org.uk> <526A1568.9010100@linux.intel.com> <20131025100618.GR18506@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20131025100618.GR18506@sirena.org.uk>
Sender: linux-acpi-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, linux-acpi@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On 10/25/2013 01:06 PM, Mark Brown wrote:
> OK, I was asking because I was thinking of applying the patch for now; 
> it's not that it's a bad idea it just seems like it's something that 
> might might make sense solved at that level. Equally well I don't know 
> if these systems will work with v3.13 anyway so perhaps it's not so 
> urgent. 
Yes, I don't see any urgent reason to push this hack in. Better to check 
dev_name change first. What I'm going to propose there is "spix.y" to 
"spi-INTABCD:xy" and "x-00yz" to "i2c-INTABCD:xy"

-- 
Jarkko
