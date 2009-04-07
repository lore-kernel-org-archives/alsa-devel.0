From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: [PATCH 0/6] ASoC: 4 channel support for twl4030
	and omap-mcbsp
Date: Tue, 7 Apr 2009 08:45:36 +0300
Message-ID: <20090407084536.bae7bcb0.jarkko.nikula@nokia.com>
References: <1239020372-8457-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id EE5242443C
	for <alsa-devel@alsa-project.org>;
	Tue,  7 Apr 2009 07:44:56 +0200 (CEST)
In-Reply-To: <1239020372-8457-1-git-send-email-peter.ujfalusi@nokia.com>
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
Cc: "sakoman@gmail.com" <sakoman@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Mon, 6 Apr 2009 14:19:26 +0200
"Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com> wrote:

> As an example, the board file for Beagle is modified to add support
> for stereo and TDM mode depending on the stream's channel count, so
> the stereo and the four channel mode are supported on Beagle.
> 
Peter, before starting to hack on this, did I interpret TWL block
diagram correctly so that I can route both R1/R2 and L1/L2 into same
outputs? It seems that only codec outputs available in Beagle are the
HSOL and HSOR. There seems to be no test pads for PreDriv and IHF
outputs.


Jarkko
