From: Li Xiubo <B47053@freescale.com>
Subject: Re: [PATCHv2 1/8] ALSA: Add SAI SoC Digital Audio
	Interface driver.
Date: Wed, 6 Nov 2013 09:38:26 +0000
Message-ID: <1DD289F6464F0949A2FCA5AA6DC23F82876FAE@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1383289495-24523-1-git-send-email-Li.Xiubo@freescale.com>
 <1383289495-24523-2-git-send-email-Li.Xiubo@freescale.com>
 <20131101085904.GC28401@MrMyself>
 <1DD289F6464F0949A2FCA5AA6DC23F82874201@039-SN2MPN1-013.039d.mgd.msft.net>
 <5278F1FA.1060706@tabi.org>
 <1DD289F6464F0949A2FCA5AA6DC23F82876A53@039-SN2MPN1-013.039d.mgd.msft.net>
 <5279B822.9010401@tabi.org>
 <1DD289F6464F0949A2FCA5AA6DC23F82876B08@039-SN2MPN1-013.039d.mgd.msft.net>
 <20131106081257.GR19770@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0249.outbound.messaging.microsoft.com [213.199.154.249])
 by alsa0.perex.cz (Postfix) with ESMTP id 1E4A52610A1
 for <alsa-devel@alsa-project.org>; Wed,  6 Nov 2013 10:38:31 +0100 (CET)
In-Reply-To: <20131106081257.GR19770@S2101-09.ap.freescale.net>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "tiwai@suse.de" <tiwai@suse.de>, Huan Wang <B18965@freescale.com>, Timur Tabi <timur@tabi.org>, Shawn Guo <r65073@freescale.com>, "LW@KARO-electronics.de" <LW@KARO-electronics.de>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, Guangyu Chen <B42378@freescale.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "ian.campbell@citrix.com" <ian.campbell@citrix.com>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "broonie@kernel.org" <broonie@kernel.org>, oskar@scara.co
List-Id: alsa-devel@alsa-project.org

> > > >> If there are any comments that say PPC but are not PPC-specific,
> that
> > > >> >should be fixed.
> > > > Yes, find it.
> > > >
> > > > The comments is in "sound/soc/fsl/Makefile" :
> > > > +++++++++++
> > > > "# Freescale PowerPC SSI/DMA Platform Support"
> > > > -----------
> > > >
> > > > But fsl-spdif.o is also under it.
> > > > And this is also support ARM and PowerPC platforms at the same
> time ?
> > > > If so, the comments should be modified to :
> > > > +++++++++++
> > > > "# Freescale PowerPC and ARM SSI/DMA Platform Support"
> > > > -----------
> > >
> > > Yes, this should be changed.
> > >
> >
> > How about :
> > +++++++++
> > "# Freescale PowerPC and ARM SSI/DMA/SAI/SPDIF Platform Support"
> > ---------
> >  ?
> 
> Or we can just drop 'PowerPC and ARM'?
> 

Yes, this will be better.


Best Regards,
Xiubo
