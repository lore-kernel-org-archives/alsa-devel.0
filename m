From: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [RFC PATCH 2/7] ASoC: Intel: Kconfig: Simplify-clarify ACPI/PCI
 dependencies
Date: Mon, 20 Nov 2017 15:23:00 +0000
Message-ID: <20171120152300.6d058999@alans-desktop>
References: <20171118000202.22302-1-pierre-louis.bossart@linux.intel.com>
        <20171118000202.22302-3-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171118000202.22302-3-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, broonie@kernel.org, torvalds@linux-foundation.org, vinod.koul@intel.com, liam.r.girdwood@linux.intel.com, andriy.shevchenko@linux.intel.com, arnd@arndb.de, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, 17 Nov 2017 18:01:57 -0600
Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com> wrote:

> PCI/ACPI selections should not happen in Kconfig for machine drivers,
> move to SOC selections.
> 
> Add distinction between PCI and ACPI HiFi2 platforms. The PCI-based
> platforms may be removed at some point since Medfield is not really
> supported by anyone and there is no publicly available firmware for
> Merrifield.

Merrifield is (Intel secret decoder ring translation - 'Edison')

I don't thionk anyone would care if Medfield and Moorestown kicked the
bucket upstream however. Moorestown wouldn't make much difference
code-wise as it has a 'real computer' twin (Oaktrail), but dumping the
Medfield code would be IMHO fine.

Alan
