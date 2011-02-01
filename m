From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Support 8 bit samples in soc-util
Date: Tue, 1 Feb 2011 11:00:06 +0000
Message-ID: <20110201110005.GA12743@opensource.wolfsonmicro.com>
References: <1296505848-29532-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<alpine.LNX.2.00.1101312325010.6272@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 11EE3103943
	for <alsa-devel@alsa-project.org>; Tue,  1 Feb 2011 12:00:08 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1101312325010.6272@eeebox2.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 31, 2011 at 11:27:41PM +0100, Jaroslav Kysela wrote:
> On Mon, 31 Jan 2011, Mark Brown wrote:

> >Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

> Is any reason to avoid using the snd_pcm_format_width() function here?

Poor documentation.
