From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: soc-core: Ensure codec_reg has fixed
 length fields
Date: Tue, 01 Feb 2011 14:25:33 +0000
Message-ID: <1296570333.3327.38.camel@odin>
References: <1296563048-8137-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 7119C103944
	for <alsa-devel@alsa-project.org>; Tue,  1 Feb 2011 15:25:37 +0100 (CET)
Received: by wyi11 with SMTP id 11so6680511wyi.38
	for <alsa-devel@alsa-project.org>; Tue, 01 Feb 2011 06:25:37 -0800 (PST)
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Tue, 2011-02-01 at 12:24 +0000, Dimitris Papastamos wrote:
> Make the format of the codec_reg file more easily parsable.  Remove
> the header field which gives the codec name.  These changes are important
> when it comes to extend the debugfs codec_reg file to dump more than
> PAGE_SIZE bytes to make it easier to calculate offsets within the
> file.
> 
> We still need to handle the case when the snd_soc_read() call fails
> and <no data: %d> is outputted.
> 
> Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
