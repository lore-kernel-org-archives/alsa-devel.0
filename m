From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [RFC 09/14] SoundWire: Add support to handle Slave
 status change
Date: Mon, 14 Nov 2016 11:38:08 -0600
Message-ID: <8f415778-f55a-3038-ec87-4b0ffea32b87@linux.intel.com>
References: <1477053673-16021-1-git-send-email-hardik.t.shah@intel.com>
 <1477053673-16021-10-git-send-email-hardik.t.shah@intel.com>
 <20161114160805.GO1575@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161114160805.GO1575@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Hardik Shah <hardik.t.shah@intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, plai@codeaurora.org, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, patches.audio@intel.com, broonie@kernel.org, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

On 11/14/16 10:08 AM, Charles Keepax wrote:
> There are some issues with this, as the slave driver only probes
> when the device actually shows up on the bus. However often
> (especially in embedded contexts) some things may need to be
> done to enable the slave. For example it may be held in reset or
> its power supplies switched off until they are need. As such it
> generally helps if the device probe can be called before it shows
> up on the bus, the device probe can then do the necessary actions
> to enable the device at which point it will show up on the bus.

Yes, this point was made at the LPC miniconference. What's not clear to 
me is if you would want the codec driver to be notified that the bus is 
operational and let it handle things like sideband power management for 
that device, or is someone else needs to know.
