From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [RFC] ASoC: core: Allow DAI links to be specified by using ACPI
 names
Date: Fri, 25 Oct 2013 09:53:28 +0300
Message-ID: <526A1568.9010100@linux.intel.com>
References: <1380803636-24079-1-git-send-email-jarkko.nikula@linux.intel.com> <20131024095118.GH31415@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20131024095118.GH31415@sirena.org.uk>
Sender: linux-acpi-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, linux-acpi@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On 10/24/2013 12:51 PM, Mark Brown wrote:
> On Thu, Oct 03, 2013 at 03:33:56PM +0300, Jarkko Nikula wrote:
>> This patch adds alternative way to specify DAI links by using ACPI names.
>> ACPI name here is considered to be used as an alias for device name during
>> DAI link binding time.
> Did anything happen with the idea of making dev_name() use the ACPI
> name?
Well, looks like I manage to put it aside. I'll spin it again as next 
merge window starts to be too near now.

-- 
Jarkko
