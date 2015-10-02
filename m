From: Koro Chen <koro.chen@mediatek.com>
Subject: Question about patch ASoC: Prevent components from
 being bound to multiple cards
Date: Fri, 2 Oct 2015 18:34:24 +0800
Message-ID: <1443782064.10151.28.camel@mtksdaap41>
References: <s5hlhcfd5az.wl-tiwai@suse.de>
 <20150909145158.GK9751@sirena.org.uk> <s5hh9n3d4bk.wl-tiwai@suse.de>
 <55F04AA1.3030607@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailgw01.mediatek.com (unknown [210.61.82.183])
 by alsa0.perex.cz (Postfix) with ESMTP id EAAEB260A5D
 for <alsa-devel@alsa-project.org>; Fri,  2 Oct 2015 12:34:46 +0200 (CEST)
In-Reply-To: <55F04AA1.3030607@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, kuninori.morimoto.gx@renesas.com
List-Id: alsa-devel@alsa-project.org

Hi Lars 

I have two cards originally but the second one failed because of the
patch ASoC: Prevent components from being bound to multiple cards.

My configuration is like this:
card0: use platform's DAI component A
card1: use the same platform's DAI component B

The two cards use different DAI components, so it should be OK but still
gets failed. I looked into this and found it is because
snd_soc_register_platform() itself will also add a component, and this
component was bound to the first card so the second probe failed.

It seems like I might need to separate the platform into two platform
drivers, but it is strange since I have only one audio hardware. I
wonder if it is reasonable to prevent a single ASoC platform driver from
being used by multiple cards? Do you have any suggestion how to fix
this?
