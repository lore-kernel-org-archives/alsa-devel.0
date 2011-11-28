From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/7] ASoC: AD193X: Make enum items const
	char * const
Date: Mon, 28 Nov 2011 19:03:22 +0000
Message-ID: <20111128190322.GE1586@opensource.wolfsonmicro.com>
References: <1322497692-27868-1-git-send-email-lars@metafoo.de>
	<1322497692-27868-3-git-send-email-lars@metafoo.de>
	<20111128185345.GA1586@opensource.wolfsonmicro.com>
	<4ED3DA92.6050704@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id CF7A91039AE
	for <alsa-devel@alsa-project.org>; Mon, 28 Nov 2011 20:03:24 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4ED3DA92.6050704@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: drivers@analog.com, alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, device-drivers-devel@blackfin.uclinux.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 28, 2011 at 08:01:38PM +0100, Lars-Peter Clausen wrote:
> On 11/28/2011 07:53 PM, Mark Brown wrote:
> > On Mon, Nov 28, 2011 at 05:28:08PM +0100, Lars-Peter Clausen wrote:

> >> -static const char *ad193x_deemp[] = {"None", "48kHz", "44.1kHz", "32kHz"};
> >> +static const char * const ad193x_deemp[] = {"None", "48kHz", "44.1kHz", "32kHz"};

> > Ideally this would be converted to a switch and the driver would
> > automatically select the rate based on the current sample rate.

> Ideally yes, but I'm not sure if this couldn't break some existing setup if it
> expects to find that control.

Well, it might but I'm not sure anyone actually uses deemphasis any more
anyway.
