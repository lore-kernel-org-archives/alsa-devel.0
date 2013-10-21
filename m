From: Timur Tabi <timur@tabi.org>
Subject: Re: [PATCHv1 5/8] ASoC: sgtl5000: Revise the bugs
 about the sgt15000 codec.
Date: Mon, 21 Oct 2013 06:21:03 -0500
Message-ID: <52650E1F.9030102@tabi.org>
References: <1382000477-17304-1-git-send-email-Li.Xiubo@freescale.com>	<1382000477-17304-6-git-send-email-Li.Xiubo@freescale.com>
 <20131017121721.43e1b34b@ipc1.ka-ro>
 <1DD289F6464F0949A2FCA5AA6DC23F82866756@039-SN2MPN1-013.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from muin.pair.com (muin.pair.com [209.68.1.55])
 by alsa0.perex.cz (Postfix) with ESMTP id B887E2602AD
 for <alsa-devel@alsa-project.org>; Mon, 21 Oct 2013 13:21:07 +0200 (CEST)
In-Reply-To: <1DD289F6464F0949A2FCA5AA6DC23F82866756@039-SN2MPN1-013.039d.mgd.msft.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Xiubo Li-B47053 <B47053@freescale.com>, =?UTF-8?B?TG90aGFyIFdhw59tYW5u?= <LW@KARO-electronics.de>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "tiwai@suse.de" <tiwai@suse.de>, Wang Huan-B18965 <B18965@freescale.com>, Guo Shawn-R65073 <r65073@freescale.com>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, Chen Guangyu-B42378 <B42378@freescale.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "ian.campbell@citrix.com" <ian.campbell@citrix.com>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "broonie@kernel.org" <broonie@kernel.org>, "oskar@scara.com" <oskar@scara.com>, Estevam Fabio-R49496 <r49496@freescal>
List-Id: alsa-devel@alsa-project.org

Xiubo Li-B47053 wrote:
> The CONFIG_SND_SOC_FSL_SGTL5000 micro will be renamed to CONFIG_SND_SOC_FSL_SGTL5000_VF610.
> In VF610, there has not Power Manager Module, so whether the CONFIG_REGULATOR is enable or
> Disabled, there will always some errors booting...

That's just not acceptable.  You have to fix the code so that it works 
with CONFIG_REGULATOR both set and not set.
