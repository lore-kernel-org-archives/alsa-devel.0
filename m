From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: soc-dapm: Fix breakage with
	incorrect codec pointer
Date: Fri, 17 Jun 2011 17:01:53 +0100
Message-ID: <20110617160153.GA11241@opensource.wolfsonmicro.com>
References: <1308322347-13512-1-git-send-email-dp@opensource.wolfsonmicro.com>
	<4DFB77AA.8060803@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 01C9D24621
	for <alsa-devel@alsa-project.org>;
	Fri, 17 Jun 2011 18:01:56 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4DFB77AA.8060803@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "patches@opensource.wolfsonmicro.com" <patches@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Jun 17, 2011 at 04:50:02PM +0100, Liam Girdwood wrote:
> On 17/06/11 15:52, Dimitris Papastamos wrote:

> > -		soc_widget_update_bits(w, reg, mask, value);
> > +		snd_soc_update_bits(dapm->codec, reg, mask, value);

> Acked-by: Liam Girdwood <lrg@ti.com>

This'll work just now but it essentially invalidates the change to
support non-CODEC DAPM widgets - we need to fix that change properly,
this means that anything other than a CODEC won't be able to use
registers.
