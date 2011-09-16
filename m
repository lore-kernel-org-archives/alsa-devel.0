From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: davinci-pcm: trivial: replace link
 with actual chan/link
Date: Fri, 16 Sep 2011 10:13:02 +0100
Message-ID: <20110916091302.GI22062@opensource.wolfsonmicro.com>
References: <1315602365-30105-1-git-send-email-bengardiner@nanometrics.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9C06C103D0D
	for <alsa-devel@alsa-project.org>;
	Fri, 16 Sep 2011 11:13:04 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1315602365-30105-1-git-send-email-bengardiner@nanometrics.ca>
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

On Fri, Sep 09, 2011 at 05:06:05PM -0400, Ben Gardiner wrote:
> The ambiguously named variable 'link' is used as a temporary throughout
> davinci-pcm -- its presence makes grepping (and groking) the code
> difficult.

Applied, thanks.
