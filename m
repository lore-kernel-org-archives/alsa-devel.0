From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] ASoC: davinci-mcasp: enable ping-pong
	SRAM buffers
Date: Thu, 19 May 2011 14:13:45 -0700
Message-ID: <20110519211344.GD18849@opensource.wolfsonmicro.com>
References: <cover.1305723716.git.bengardiner@nanometrics.ca>
	<f28f86fbe10a8cafeb04b4066b781efb7b3913b8.1305723716.git.bengardiner@nanometrics.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 559751039B9
	for <alsa-devel@alsa-project.org>;
	Thu, 19 May 2011 23:13:42 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <f28f86fbe10a8cafeb04b4066b781efb7b3913b8.1305723716.git.bengardiner@nanometrics.ca>
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
Cc: davinci-linux-open-source@linux.davincidsp.com, Subhasish Ghosh <subhasish@mistralsolutions.com>, Sekhar Nori <nsekhar@ti.com>, alsa-devel@alsa-project.org, Troy Kisky <troy.kisky@boundarydevices.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Wed, May 18, 2011 at 09:27:45AM -0400, Ben Gardiner wrote:
> The davinci-i2s driver copies the platform data for playback and capture
> sram sizes which is in turn used by davinci-pcm to allocate ping-pong
> buffers.
> 
> Copy also the platform data in davinci-mcasp probe.
> 
> Signed-off-by: Ben Gardiner <bengardiner@nanometrics.ca>

Applied, thanks.
