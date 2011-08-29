From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: davinci-mcasp: add support for
	unsigned PCM formats
Date: Mon, 29 Aug 2011 10:12:01 +0100
Message-ID: <20110829091201.GA10838@opensource.wolfsonmicro.com>
References: <1314374564-10291-1-git-send-email-bengardiner@nanometrics.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7A69424563
	for <alsa-devel@alsa-project.org>;
	Mon, 29 Aug 2011 11:12:04 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1314374564-10291-1-git-send-email-bengardiner@nanometrics.ca>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ben Gardiner <bengardiner@nanometrics.ca>
Cc: davinci-linux-open-source@linux.davincidsp.com, alsa-devel@alsa-project.org, Sekhar Nori <nsekhar@ti.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Aug 26, 2011 at 12:02:44PM -0400, Ben Gardiner wrote:
> Although the McASP supports sign-extending samples in RX or TX [1]; the
> davinci-mcasp driver does not touch the {R,X}PBIT or {R,X}PAD field of the
> {R,X}FMT registers meaning that the McASP will serialize the bytes it is given
> regardless of their signedness. So supporting unsigned formats is as simple
> as adding them to the metadata of the davinci-mcasp driver.

Applied, thanks.
