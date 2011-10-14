From: Julian Scheel <julian@jusst.de>
Subject: Re: [PATCH] ASoC: WM8903: Implement DMIC support
Date: Fri, 14 Oct 2011 12:34:21 +0200
Message-ID: <1318588461.2686.9.camel@localhost.localdomain>
References: <1303181891-25064-1-git-send-email-swarren@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp1.work.de (smtp1.work.de [212.12.40.178])
	by alsa0.perex.cz (Postfix) with ESMTP id EC8DB2441D
	for <alsa-devel@alsa-project.org>;
	Fri, 14 Oct 2011 12:34:22 +0200 (CEST)
In-Reply-To: <1303181891-25064-1-git-send-email-swarren@nvidia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@nvidia.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

Am Montag, den 18.04.2011, 20:58 -0600 schrieb Stephen Warren:
> In addition to the currently supported analog capture path, the WM8903
> also supports digital mics.
> 
> The analog and digital capture paths are exclusive; a mux is present to
> select the capture source.
> 
> Logically, the mux exists to select the decimator's input, from either
> the ADC or DMIC block outputs. However, the ADC power domain also
> includes the DMIC interface. Consequently, this change represents the
> mux as existing immediately before the ADC, and selecting between the
> Input PGA and DMIC block outputs.
> 
> An alternative might be to represent the mux in its correct location,
> and associate the ADC power enable controls with both the real ADC, and
> a fake ADC for the DMIC?

Hi,

actually the wm8903 codec needs GPIO1 and GPIO2 to be configured
properly to be able to use DMIC actually. I would propose to
automatically configure these to DMIC-mode whenever ADCINPUT is set to
DMIC. Would you agree with this procedure?
I would prepare a patch which changes all relevant registers then.

Regards,
Julian
