From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 0/2] ASoC: core: Ignoring pmdown_time
 for playback stream power down
Date: Fri, 14 Oct 2011 20:44:20 +0100
Message-ID: <20111014194420.GP2931@opensource.wolfsonmicro.com>
References: <1318592614-13110-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2A39424475
	for <alsa-devel@alsa-project.org>;
	Fri, 14 Oct 2011 21:44:22 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1318592614-13110-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 14, 2011 at 02:43:32PM +0300, Peter Ujfalusi wrote:

> Changes since v1 (RFC):
> - move the flag to per codec (snd_soc_codec)
> - twl6040 to request to ignore the pmdown_time

I've applied both, thanks.  We will probably want to extend this to be
handlable dynamically - there's a lot of devices will be happy to do
this for speaker but which won't be able to do it unconditionally due to
headphone or line outputs for example.
