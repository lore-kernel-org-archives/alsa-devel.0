From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [alsa-devel] [RFC] ASoC: core: Allow DAI links to be specified
 by using ACPI names
Date: Mon, 28 Oct 2013 17:23:45 +0200
Message-ID: <526E8181.2030208@linux.intel.com>
References: <1380803636-24079-1-git-send-email-jarkko.nikula@linux.intel.com> <20131024095118.GH31415@sirena.org.uk> <526A1568.9010100@linux.intel.com> <20131025100618.GR18506@sirena.org.uk> <526A4B11.5000802@linux.intel.com> <1382961194.2334.23.camel@loki> <20131028150639.GA10936@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20131028150639.GA10936@sirena.org.uk>
Sender: linux-acpi-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, linux-acpi@vger.kernel.org, alsa-devel@alsa-project.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 10/28/2013 05:06 PM, Mark Brown wrote:
> On Mon, Oct 28, 2013 at 11:53:14AM +0000, Liam Girdwood wrote:
>> On Fri, 2013-10-25 at 13:42 +0300, Jarkko Nikula wrote:
>>> Yes, I don't see any urgent reason to push this hack in. Better to check
>>> dev_name change first. What I'm going to propose there is "spix.y" to
>>> "spi-INTABCD:xy" and "x-00yz" to "i2c-INTABCD:xy"
>> We probably need to be able to match on ACPI name alone as some BIOS
>> settings can change the I2C bus number and break the name match used at
>> bind time. e.g. on Haswell the codec can either be on I2C bus 0 or 7.
> Indeed.  The way I initially read the suggestion above the idea was to
> replace the bus number with the ACPI name for the device which seemed
> sensible but now I reread the bus number is still there.
Sorry, my textual proposal above was confusing and should have used 
different variables for ACPI name. What I meant was "spix.y" -> 
"spi-INTABCD:ij" and "x-00yz" to "i2c-INTABCD:ij" where "INTABCD:ij" was 
the ACPI device name which contains the device instance in "ij".

-- 
Jarkko
