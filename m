From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v22 3/3] ASoC: WL1273 FM radio: Access I2C IO functions
 through pointers.
Date: Tue, 1 Mar 2011 13:23:16 +0000
Message-ID: <20110301132315.GD9662@opensource.wolfsonmicro.com>
References: <1298985037-2714-1-git-send-email-matti.j.aaltonen@nokia.com>
 <1298985037-2714-2-git-send-email-matti.j.aaltonen@nokia.com>
 <1298985037-2714-3-git-send-email-matti.j.aaltonen@nokia.com>
 <1298985037-2714-4-git-send-email-matti.j.aaltonen@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-media-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1298985037-2714-4-git-send-email-matti.j.aaltonen@nokia.com>
Sender: linux-media-owner@vger.kernel.org
To: "Matti J. Aaltonen" <matti.j.aaltonen@nokia.com>
Cc: alsa-devel@alsa-project.org, lrg@slimlogic.co.uk, mchehab@redhat.com, hverkuil@xs4all.nl, sameo@linux.intel.com, linux-media@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, Mar 01, 2011 at 03:10:37PM +0200, Matti J. Aaltonen wrote:
> These changes are needed to keep up with the changes in the
> MFD core and V4L2 parts of the wl1273 FM radio driver.
> 
> Use function pointers instead of exported functions for I2C IO.
> Also move all preprocessor constants from the wl1273.h to
> include/linux/mfd/wl1273-core.h.
> 
> Also update the year in the copyright statement.
> 
> Signed-off-by: Matti J. Aaltonen <matti.j.aaltonen@nokia.com>

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

*Please* keep acks unless you're making substantial changes to
repostings.
