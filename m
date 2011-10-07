From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v3] ASoC: Add support for cs42l73 codec
Date: Fri, 7 Oct 2011 11:27:41 +0100
Message-ID: <20111007102740.GF19080@opensource.wolfsonmicro.com>
References: <1317917945-32580-1-git-send-email-brian.austin@cirrus.com>
	<CAOZdJXV4+ZUZptZEjqwQugPmmav7wsXkw9ORrsVMPVzOTahc-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B2FAB103AFD
	for <alsa-devel@alsa-project.org>;
	Fri,  7 Oct 2011 12:27:42 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CAOZdJXV4+ZUZptZEjqwQugPmmav7wsXkw9ORrsVMPVzOTahc-g@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Tabi Timur-B04825 <B04825@freescale.com>
Cc: Brian Austin <brian.austin@cirrus.com>, "vinod.koul@linux.intel.com" <vinod.koul@linux.intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "ramesh.babu@intel.com" <ramesh.babu@intel.com>, "joe@nucleusys.com" <joe@nucleusys.com>, "heelrod@heelrod.ad.cirrus.com" <heelrod@heelrod.ad.cirrus.com>, "lrg@ti.com" <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 07, 2011 at 02:13:32AM +0000, Tabi Timur-B04825 wrote:

> > +/* I2C Registers */
> > +/* I2C Address: 1001010[R/W] - 10010100 = 0x94(Write); 10010101 = 0x95(Read) */

> This chip has separate I2C addresses for reading and writing?

This is standard - the I2C address can be quoted in either 8 bit form
(where the lowest bit is a read write flag) or 7 bit form.  The
confusing thing here is that the Linux code uses the 7 bit form
exclusively.
