From: Inha Song <ideal.song@samsung.com>
Subject: Re: [alsa-devel] [PATCH] mfd: wm8994: use PLATFORM_DEVID_AUTO for
 regulator devs creation to avoid conflicts
Date: Tue, 30 Dec 2014 20:46:24 +0900
Message-ID: <20141230204624.7fb94518@songinha-Samsung-DeskTop-System>
References: <1419918320-12693-1-git-send-email-ideal.song@samsung.com>
 <20141230112821.GL11764@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20141230112821.GL11764@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, sameo@linux.intel.com, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, lgirdwood@gmail.com, ckeepax@opensource.wolfsonmicro.com, lee.jones@linaro.org
List-Id: alsa-devel@alsa-project.org

Hi Mark,
Thanks for your reply.

Sure, Understand. I missed that part.

I will just fix id base to 0 from -1.
If not, duplicate filename error was reported like this.
- sysfs: cannot create duplicate filename '/devices/.../wm8994-ldo'

Best Regards,
Inha Song.

On Tue, 30 Dec 2014 11:28:21 +0000
Mark Brown <broonie@kernel.org> wrote:

> On Tue, Dec 30, 2014 at 02:45:20PM +0900, Inha Song wrote:
> > After commit: 6e3f62f0793e ("mfd: core: Fix platform-device id generation")
> > We must set the id base when register a duplicate name of mfd_cell.
> > but, if we use PLATFORM_DEVID_AUTO flag, cell ids are automatically
> > allocated and managed without cell id setting.
> 
> The driver relies on getting those specific IDs in order to work out
> which LDO it's working with, automatically generated numbers may be the
> same now but can you guarantee that in future?
