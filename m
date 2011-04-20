From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: WM8903: Implement DMIC support
Date: Wed, 20 Apr 2011 12:10:12 +0100
Message-ID: <1303297812.3436.1.camel@odin>
References: <1303181891-25064-1-git-send-email-swarren@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id ADEB91037FC
	for <alsa-devel@alsa-project.org>;
	Wed, 20 Apr 2011 13:10:16 +0200 (CEST)
Received: by wyg36 with SMTP id 36so557132wyg.38
	for <alsa-devel@alsa-project.org>; Wed, 20 Apr 2011 04:10:16 -0700 (PDT)
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
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Mon, 2011-04-18 at 20:58 -0600, Stephen Warren wrote:
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
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>

Acked-by: Liam Girdwood <lrg@ti.com>
