From: Xiubo Li-B47053 <B47053@freescale.com>
Subject: Re: [PATCHv1 1/8] ALSA: Add SAI SoC Digital Audio
	Interface driver.
Date: Tue, 29 Oct 2013 09:31:11 +0000
Message-ID: <1DD289F6464F0949A2FCA5AA6DC23F8286D2E8@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1382000477-17304-1-git-send-email-Li.Xiubo@freescale.com>
 <1382000477-17304-2-git-send-email-Li.Xiubo@freescale.com>
 <20131024110543.GA18506@sirena.org.uk>
 <1DD289F6464F0949A2FCA5AA6DC23F8286BDB5@039-SN2MPN1-013.039d.mgd.msft.net>
 <20131029040209.GC8812@MrMyself>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe001.messaging.microsoft.com [207.46.163.24])
 by alsa0.perex.cz (Postfix) with ESMTP id B427E2608ED
 for <alsa-devel@alsa-project.org>; Tue, 29 Oct 2013 10:31:15 +0100 (CET)
In-Reply-To: <20131029040209.GC8812@MrMyself>
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
To: Chen Guangyu-B42378 <B42378@freescale.com>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "tiwai@suse.de" <tiwai@suse.de>, Wang Huan-B18965 <B18965@freescale.com>, "timur@tabi.org" <timur@tabi.org>, Guo Shawn-R65073 <r65073@freescale.com>, "LW@KARO-electronics.de" <LW@KARO-electronics.de>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "ian.campbell@citrix.com" <ian.campbell@citrix.com>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, Mark Brown <broonie@kernel.org>, "oskar@scara.com" <oskar@scara.com>, Estev
List-Id: alsa-devel@alsa-project.org





> -----Original Message-----
> From: Chen Guangyu-B42378
> Sent: Tuesday, October 29, 2013 12:02 PM
> To: Xiubo Li-B47053
> Cc: Mark Brown; Guo Shawn-R65073; timur@tabi.org; lgirdwood@gmail.com;
> Jin Zhengxiong-R64188; rob.herring@calxeda.com; pawel.moll@arm.com;
> mark.rutland@arm.com; swarren@wwwdotorg.org; ian.campbell@citrix.com;
> rob@landley.net; linux@arm.linux.org.uk; perex@perex.cz; tiwai@suse.de;
> grant.likely@linaro.org; Estevam Fabio-R49496; LW@KARO-electronics.de;
> oskar@scara.com; shawn.guo@linaro.org; Wang Huan-B18965;
> devicetree@vger.kernel.org; linux-doc@vger.kernel.org; linux-
> kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org; alsa-
> devel@alsa-project.org; linuxppc-dev@lists.ozlabs.org
> Subject: Re: [PATCHv1 1/8] ALSA: Add SAI SoC Digital Audio Interface
> driver.
> 
> On Tue, Oct 29, 2013 at 12:00:57PM +0800, Xiubo Li-B47053 wrote:
> > > There's a patch in -next that lets the generic dmaengine code figure
> > > out some settings from the dmacontroller rather than requiring the
> > > driver to explicitly provide configuration - it's "ASoC:
> > > dmaengine-pcm: Provide default config".  Please update your driver
> > > to use this, or let's work out what it doesn't do any try to fix it.
> > >
> >
> > I couldn't find the patch in the next and other trees.
> > Does this patch has been submitted to the -next tree ?
> > Or could you tell me how to find the patch please?
> >
> 
> Are you using broonie's repository?

NO.

> git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git
> 
> If you searched the title in for-next branch, you should have found it.
> 
Yes, find it.
Thanks very much.

--
Xiubo
