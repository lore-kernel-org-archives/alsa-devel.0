From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [alsa-devel] [PATCH 01/15] Input - arizona-haptics: Fix double
	lock of dapm_mutex
Date: Tue, 18 Feb 2014 14:53:34 +0000
Message-ID: <20140218145334.GA5438@opensource.wolfsonmicro.com>
References: <1392655903-24537-1-git-send-email-ckeepax@opensource.wolfsonmicro.com> <1392655903-24537-2-git-send-email-ckeepax@opensource.wolfsonmicro.com> <20140217192025.GB19223@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140217192025.GB19223@core.coreip.homeip.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, eric.y.miao@gmail.com, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, haojian.zhuang@gmail.com, linux-kernel@vger.kernel.org, peter.ujfalusi@ti.com, cw00.choi@samsung.com, broonie@kernel.org, myungjoo.ham@samsung.com, linux@arm.linux.org.uk, jarkko.nikula@bitmer.com
List-Id: alsa-devel@alsa-project.org

On Mon, Feb 17, 2014 at 11:20:26AM -0800, Dmitry Torokhov wrote:
> HI Charles,
> 
> On Mon, Feb 17, 2014 at 04:51:29PM +0000, Charles Keepax wrote:
> > snd_soc_dapm_sync takes the dapm_mutex internally, but we currently take
> > it externally as well. This patch fixes this.
> 
> Hmm, from the first glance this needs to go into current release,
> however it seems that it has been broken by
> a73fb2df01866b772a48fab93401fe3edbe0b38d 2 years ago so nobody cares...
> 
> Looking at the series I am not sure that this is right direction. You
> actually do want unlocked versions of snd_soc_dapm_* functions so that
> callers can take dapm mutex and then perform sequence of operations. The
> currect callers that were taking the mutex should probbaly be changed so
> that they do not drop it until they called unlocked version of
> snd_soc_dapm_sync().

Having looked over this again I would prefer to go with the
current fix. It means the fix can be sent to the stable trees and
the haptics driver has no requirement for multiple pin updates to
be done atomically, so there is not a huge amount to be gained
from bundling things under an external lock.

Thanks,
Charles
