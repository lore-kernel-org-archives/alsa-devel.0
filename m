From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [RFC 03/14] SoundWire: Add error handling and locking
 documentation
Date: Mon, 14 Nov 2016 15:44:35 +0000
Message-ID: <20161114154435.GN1575@localhost.localdomain>
References: <1477053673-16021-1-git-send-email-hardik.t.shah@intel.com>
 <1477053673-16021-4-git-send-email-hardik.t.shah@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1477053673-16021-4-git-send-email-hardik.t.shah@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hardik Shah <hardik.t.shah@intel.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.de, pierre-louis.bossart@linux.intel.com, broonie@kernel.org, lgirdwood@gmail.com, plai@codeaurora.org, patches.audio@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 21, 2016 at 06:11:01PM +0530, Hardik Shah wrote:
> This patch adds following documentation:
>     1. Bus driver locking mechanism.
>     2. Bus driver error handling.
> 
> Signed-off-by: Hardik Shah <hardik.t.shah@intel.com>
> Signed-off-by: Sanyog Kale <sanyog.r.kale@intel.com>
> Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  Documentation/sound/alsa/sdw/error_handling.txt |   71 +++++++++++++++++++++++
>  Documentation/sound/alsa/sdw/locking.txt        |   64 ++++++++++++++++++++
>  2 files changed, 135 insertions(+)
>  create mode 100644 Documentation/sound/alsa/sdw/error_handling.txt
>  create mode 100644 Documentation/sound/alsa/sdw/locking.txt
> 
> diff --git a/Documentation/sound/alsa/sdw/error_handling.txt b/Documentation/sound/alsa/sdw/error_handling.txt
> new file mode 100644
> index 0000000..9441cfa
> --- /dev/null
> +++ b/Documentation/sound/alsa/sdw/error_handling.txt
> @@ -0,0 +1,71 @@
<snip>
> diff --git a/Documentation/sound/alsa/sdw/locking.txt b/Documentation/sound/alsa/sdw/locking.txt
> new file mode 100644
> index 0000000..650162f
> --- /dev/null
> +++ b/Documentation/sound/alsa/sdw/locking.txt
> @@ -0,0 +1,64 @@
> +This document explains locking mechanism of the SoundWire bus driver.
> +Following types of lock are used in SoundWire bus driver.
> +
> +1. Core lock
> +2. Master lock
> +3. Stream lock
> +4. Message lock
> +
> +1. Core lock: Global SoundWire bus driver lock. Core lock is used to
> +serialize each of the following operation(s) within SoundWire bus
> +driver.
> +	- Addition and removal of Master.
> +	- Acquire "Master lock" of each Master associated with the
> +	  aggregated stream.
> +
> +
> +2. Master lock: SoundWire bus instance lock. Master lock is used to
> +serialize each of the following operation(s) within SoundWire bus
> +instance.
> +	- Addition and removal of Slave(s).
> +	- Prepare and enable, disable and de-prepare.
> +
> +
> +3. Stream lock: SoundWire stream lock. Stream lock is used to serialize
> +access of stream data structure for a SoundWire stream.
> +
> +
> +4. Message lock: SoundWire message transfer lock. This lock is used to
> +serialize the message transfers(read/write) within the SoundWire bus
> +instance.
> +
> +
> +Lock Hierarchy
> +==============
> +
> +- Core lock is the parent of Master and Stream lock.
> +- Master lock is parent of Message lock.
> +- Master and Stream locks are independent of each other.
> +

A small diagram might be nice here, just would make it easier to
see the hierarchy at a glance.

Thanks,
Charles
