From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: [PATCH 0/2] ASoC: OMAP: Finalizing the DSP mode
	support
Date: Wed, 15 Apr 2009 16:07:59 +0300
Message-ID: <20090415160759.4ceec30b.jarkko.nikula@nokia.com>
References: <1239799136-28729-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id 8CE6E1038EE
	for <alsa-devel@alsa-project.org>;
	Wed, 15 Apr 2009 15:07:56 +0200 (CEST)
In-Reply-To: <1239799136-28729-1-git-send-email-peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Wed, 15 Apr 2009 14:38:54 +0200
"Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com> wrote:

> But, the DSP modes should use single-phase mode instead of the
> dual-phase mode, which is intended to be used with I2S,
> Left-justified, Right-justified modes.
> 
At quick testing seems correct with Beagle but I'll give some more
testing tomorrow and let you know.

> The second patch adds DSP_A mode support to omap-mcbsp.
> 
This looks ok.


Jarkko
