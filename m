From: Xiubo Li-B47053 <B47053@freescale.com>
Subject: RE: [alsa-devel] [PATCHv1 1/8] ALSA: Add SAI SoC Digital Audio
 Interface driver.
Date: Fri, 18 Oct 2013 03:42:13 +0000
Message-ID: <1DD289F6464F0949A2FCA5AA6DC23F8286547C@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1382000477-17304-1-git-send-email-Li.Xiubo@freescale.com>
 <1382000477-17304-2-git-send-email-Li.Xiubo@freescale.com>
 <525FD4C7.3050806@tabi.org> <525FD65B.3040004@metafoo.de>
 <525FE48B.7020709@tabi.org> <525FE728.90403@metafoo.de>
 <525FE815.1040300@tabi.org> <525FEB7A.5040406@metafoo.de>
 <20131017141003.GO2443@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20131017141003.GO2443@sirena.org.uk>
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
To: Mark Brown <broonie@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "tiwai@suse.de" <tiwai@suse.de>, Wang Huan-B18965 <B18965@freescale.com>, Timur Tabi <timur@tabi.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Guo Shawn-R65073 <r65073@freescale.com>, "LW@KARO-electronics.de" <LW@KARO-electronics.de>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, Chen Guangyu-B42378 <B42378@freescale.com>, "oskar@scara.com" <oskar@scara.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "ian.campbell@citrix.com" <ian.campbell@citrix.com>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, linux-arm-ker
List-Id: alsa-devel@alsa-project.org


> > > I understand that, but I'm trying to figure out why of_iomap() is
> > > okay for hundreds of other drivers, but not this one.  I've used it
> > > dozens of times myself, without ever worrying about overlapping
> regions.
> 
> > The driver would work fine with just of_iomap(). But the resource
> > range check comes basically for free and it does help to catch errors,
> > so I'd recommend on using it rather than not using it.
> 
> There's also the fact that it's a devm_ function which means less error
> handling code that we can break which is nice.  There's probably a case
> for an improved OF helper here...


Using this instead of of_iomap() is because "devm_" and resource range check
as Lars and Mark said, and there are more than one SAI device here which will
be added later, maybe the resource range check is needed.



Thanks.
--
BRS
Xiubo
