From: "Lu, Han" <han.lu@intel.com>
Subject: Re: [PATCH v2 1/8] ASoC: Intel: add function to load
	firmware image
Date: Wed, 11 Mar 2015 06:48:51 +0000
Message-ID: <B51200AC81AB024499A3C2C9A1BB90A8373CA7@SHSMSX101.ccr.corp.intel.com>
References: <1425955287-29661-1-git-send-email-han.lu@intel.com>
 <20150310203837.GO28806@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 050A5265015
 for <alsa-devel@alsa-project.org>; Wed, 11 Mar 2015 07:49:56 +0100 (CET)
In-Reply-To: <20150310203837.GO28806@sirena.org.uk>
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
To: Mark Brown <broonie@kernel.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Mark Brown [mailto:broonie@kernel.org]
> Sent: Wednesday, March 11, 2015 4:39 AM
> To: Lu, Han
> Cc: alsa-devel@alsa-project.org; Girdwood, Liam R
> Subject: Re: [PATCH v2 1/8] ASoC: Intel: add function to load firmware image
> 
> On Tue, Mar 10, 2015 at 10:41:20AM +0800, han.lu@intel.com wrote:
> > From: "Lu, Han" <han.lu@intel.com>
> >
> > Add a general method to load firmware image, and apply to base
> > firmware image loading. With the method, the driver will support
> > loading multiple different modules in order to support different features.
> 
> This doesn't apply against current code - you should be sending things against
> my git tree (or -next is often close enough).

[Han] sorry, I made patches against for-next branch, and I just run
	$ git clone git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git
	$ cd sound
	$ git checkout origin/for-next -b for-next
And apply the patches manually
	$ patch -p1 < 0001-ASoC-Intel-add-function-to-load-firmware-image.patch
	$ patch -p1 < 0002-ASoC-Intel-add-function-to-load-sound-effect-module-.patch
	...
	$ patch -p1 < 0008-ASoC-Intel-enable-parameter-restore-for-sound-effect.patch
But didn't find conflict. Is there any mistake in my operation, or could you please share the error log so I can correct my patch? Very sorry for inconvenient.
