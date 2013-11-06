From: Timur Tabi <timur@tabi.org>
Subject: Re: [PATCHv2 1/8] ALSA: Add SAI SoC Digital Audio
	Interface driver.
Date: Tue, 05 Nov 2013 21:31:46 -0600
Message-ID: <5279B822.9010401@tabi.org>
References: <1383289495-24523-1-git-send-email-Li.Xiubo@freescale.com>
 <1383289495-24523-2-git-send-email-Li.Xiubo@freescale.com>
 <20131101085904.GC28401@MrMyself>
 <1DD289F6464F0949A2FCA5AA6DC23F82874201@039-SN2MPN1-013.039d.mgd.msft.net>
 <5278F1FA.1060706@tabi.org>
 <1DD289F6464F0949A2FCA5AA6DC23F82876A53@039-SN2MPN1-013.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from muin.pair.com (muin.pair.com [209.68.1.55])
 by alsa0.perex.cz (Postfix) with ESMTP id D269726080A
 for <alsa-devel@alsa-project.org>; Wed,  6 Nov 2013 04:31:51 +0100 (CET)
In-Reply-To: <1DD289F6464F0949A2FCA5AA6DC23F82876A53@039-SN2MPN1-013.039d.mgd.msft.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Li Xiubo <B47053@freescale.com>, Guangyu Chen <B42378@freescale.com>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "tiwai@suse.de" <tiwai@suse.de>, Huan Wang <B18965@freescale.com>, Shawn Guo <r65073@freescale.com>, "LW@KARO-electronics.de" <LW@KARO-electronics.de>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "ian.campbell@citrix.com" <ian.campbell@citrix.com>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "broonie@kernel.org" <broonie@kernel.org>, "oskar@scara.com" <oskar@scara.com>, Fabio Estevam <r49496@freescale.com>, lgir
List-Id: alsa-devel@alsa-project.org

Li Xiubo wrote:
>> If there are any comments that say PPC but are not PPC-specific, that
>> >should be fixed.
> Yes, find it.
>
> The comments is in "sound/soc/fsl/Makefile" :
> +++++++++++
> "# Freescale PowerPC SSI/DMA Platform Support"
> -----------
>
> But fsl-spdif.o is also under it.
> And this is also support ARM and PowerPC platforms at the same time ?
> If so, the comments should be modified to :
> +++++++++++
> "# Freescale PowerPC and ARM SSI/DMA Platform Support"
> -----------

Yes, this should be changed.
