From: Wu Fengguang <fengguang.wu@intel.com>
Subject: Re: [alsa-devel]  [PATCH]Support MCP89 and GT21x hdmi audio
Date: Tue, 2 Mar 2010 13:43:07 +0800
Message-ID: <20100302054307.GA6165@localhost>
References: <6B4D417B830BC44B8026029FD256F7F1C068B2BA8B@HKMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6B4D417B830BC44B8026029FD256F7F1C068B2BA8B@HKMAIL01.nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wei Ni <wni@nvidia.com>
Cc: 'Takashi Iwai' <tiwai@suse.de>, 'akpm' <akpm@linux-foundation.org>, 'alsa-devel' <alsa-devel@alsa-project.org>, 'linux-kernel' <linux-kernel@vger.kernel.org>, 'Pavel Hofman' <pavel.hofman@insite.cz>
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 01, 2010 at 07:27:53PM +0800, Wei Ni wrote:
> Hi, Takashi
> I developed the hdmi audio driver for new chipset MCP89 and GT21x.
> The new HAD controller and codec support standard HDMI operation.
> 
> I attached the patch file, please check it.

Wei Ni,

Can we avoid the big copy&paste and do more code reuse?
This benefits all of us in long term.

Thanks,
Fengguang
