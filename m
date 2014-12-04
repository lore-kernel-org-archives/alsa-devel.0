From: Andrew Jackson <Andrew.Jackson@arm.com>
Subject: Re: [PATCH 4/5] ASoC: dwc: Add devicetree support for
 Designware I2S
Date: Thu, 04 Dec 2014 09:43:57 +0000
Message-ID: <54802CDD.6080000@arm.com>
References: <547F3CAC.9050105@arm.com> <2041200.ZjakFFAZAU@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cam-smtp0.cambridge.arm.com (fw-tnat.cambridge.arm.com
 [217.140.96.140])
 by alsa0.perex.cz (Postfix) with ESMTP id C4A7E2606D3
 for <alsa-devel@alsa-project.org>; Thu,  4 Dec 2014 10:43:57 +0100 (CET)
In-Reply-To: <2041200.ZjakFFAZAU@wuerfel>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnd Bergmann <arnd@arndb.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, Liviu Dudau <Liviu.Dudau@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rajeev Kumar <rajeevkumar.linux@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 12/03/14 20:13, Arnd Bergmann wrote:
> On Wednesday 03 December 2014 16:39:08 Andrew Jackson wrote:
>> Convert to driver to use either platform_data or device-tree for configuration
>> of the device.  When using device-tree, the I2S block's configuration is read
>> from the relevant registers: this reduces the amount of information required in
>> the device tree.
>>
>> Signed-off-by: Andrew Jackson <Andrew.Jackson@arm.com>
> 
> I don't think we even have to worry about the platform_data case here:
> the only platform using this hardware in Linux is arm/mach-spear, and
> it defines a device node with a binding that is similar to the one you
> document here but that is not implemented in the driver.
> 
> So, I think for all practical purposes we can assume that nobody cares
> if you make incompatible changes as long as you don't introduce build
> regression.
> 
> Also, please adapt the 	arch/arm/boot/dts/spear13*.dts{,i} files
> as good as you can. They are broken in other ways too that you don't
> have to fix, just make them conform to the binding you add.
> 

Will do.  Although I had noticed those DT entries, I couldn't find anything in support of them.  I wasn't sure whether someone else was waiting in the wings (so as to speak) with a DT enabled Designware I2S driver. 

> 	Arnd
> 
> 
