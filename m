From: Xiubo Li-B47053 <B47053@freescale.com>
Subject: RE: [PATCHv1 8/8] Documentation: Add device tree bindings for
 Freescale VF610 sound.
Date: Fri, 18 Oct 2013 03:27:03 +0000
Message-ID: <1DD289F6464F0949A2FCA5AA6DC23F82865447@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1382000477-17304-1-git-send-email-Li.Xiubo@freescale.com>
 <1382000477-17304-9-git-send-email-Li.Xiubo@freescale.com>
 <1382003190.4093.38.camel@weser.hi.pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1382003190.4093.38.camel@weser.hi.pengutronix.de>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lucas Stach <l.stach@pengutronix.de>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "tiwai@suse.de" <tiwai@suse.de>, Wang Huan-B18965 <B18965@freescale.com>, "timur@tabi.org" <timur@tabi.org>, "perex@perex.cz" <perex@perex.cz>, Guo Shawn-R65073 <r65073@freescale.com>, "LW@KARO-electronics.de" <LW@KARO-electronics.de>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, Chen Guangyu-B42378 <B42378@freescale.com>, "oskar@scara.com" <oskar@scara.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "ian.campbell@citrix.com" <ian.campbell@citrix.com>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "broonie@kernel.org" <broonie@kernel.>
List-Id: alsa-devel@alsa-project.org

Hi,



> > Documentation/devicetree/bindings/sound/fsl-sgtl5000.txt
> >
> > diff --git a/Documentation/devicetree/bindings/sound/fsl-sgtl5000.txt
> > b/Documentation/devicetree/bindings/sound/fsl-sgtl5000.txt
> > new file mode 100644
> > index 0000000..43e350f
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/sound/fsl-sgtl5000.txt
> 
> This document name is overly generic, there are more than one FSL
> platforms with SGTL5000 codecs. Please include the vf610 here.
> 

Yes, it is.

This will be renamed to "fsl_vf610_audio_sgt15000.txt" or others.


Thanks,
--
BRS,
Xiubo
