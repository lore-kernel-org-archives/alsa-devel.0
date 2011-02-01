From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: soc-core: Ensure codec_reg has fixed
 length fields
Date: Tue, 1 Feb 2011 14:31:29 +0000
Message-ID: <20110201143129.GL12743@opensource.wolfsonmicro.com>
References: <1296563048-8137-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C97011039AD
	for <alsa-devel@alsa-project.org>; Tue,  1 Feb 2011 15:31:30 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1296563048-8137-1-git-send-email-dp@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, Feb 01, 2011 at 12:24:08PM +0000, Dimitris Papastamos wrote:
> Make the format of the codec_reg file more easily parsable.  Remove
> the header field which gives the codec name.  These changes are important
> when it comes to extend the debugfs codec_reg file to dump more than
> PAGE_SIZE bytes to make it easier to calculate offsets within the
> file.

Applied, thanks.
