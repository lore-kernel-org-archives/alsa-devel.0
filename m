From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Questions for dummy codec driver
Date: Mon, 26 Sep 2011 22:47:38 +0100
Message-ID: <20110926214738.GA3517@opensource.wolfsonmicro.com>
References: <1316502540.4269.1.camel@phoenix> <4E794A96.9040206@marvell.com>
	<20110921125607.GC25620@sirena.org.uk> <4E7A9276.803@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 56381245F1
	for <alsa-devel@alsa-project.org>;
	Mon, 26 Sep 2011 23:47:41 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4E7A9276.803@marvell.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Leo Yan <leoy@marvell.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 22, 2011 at 09:42:14AM +0800, Leo Yan wrote:

> On our platform, there have some devices (like hdmi/bt) do not need
> config from the CODEC driver, they have their own s/w stack and
> interface to configure; for the audio driver, just need to set the
> I2S/PCM timing for them. So if there have a common dummy codec
> driver, then it can meet our requirement well. Otherwise, there will
> have some duplicate codes for these dummy codecs.

The general thought here has been that for dumb CODECs the boilerplate
is sufficiently small and simple to mean that the discoverability from
writing a skeletal driver outweighs the cost of having it kicking around
- while there is some boilerplate there it's easier for someone to grab
and use this code than it is to work out how exactly to translate the
datasheets into code each time they encounter the part.  However, a
sufficiently well written generic driver would maintain that advantage
while reducing the duplication.
