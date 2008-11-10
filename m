From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [alsa-devel] [PATCH] ALSA SOC driver for s3c24xx with uda1341
Date: Mon, 10 Nov 2008 19:22:46 +0000
Message-ID: <20081110192246.GG30417@flint.arm.linux.org.uk>
References: <12261302352402-git-send-email-chripell@gmail.com>
	<20081110133451.GD12804@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
Content-Disposition: inline
In-Reply-To: <20081110133451.GD12804@sirena.org.uk>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/lurker/list/linux-arm-kernel.html>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: Mark Brown <broonie@sirena.org.uk>
Cc: Christian Pellegrin <chripell@gmail.com>, alsa-devel@alsa-project.org, Christian Pellegrin <chripell@fsfe.org>, linux-arm-kernel@lists.arm.linux.org.uk, zdevai@gmail.com
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 10, 2008 at 01:34:52PM +0000, Mark Brown wrote:
> > +	xtal = clk_get(NULL, "xtal");
> > +	pclk = clk_get(NULL, "pclk");
> 
> This should be done in the init function for the device and should
> really check the return value in case it can't get the clock for some
> reason.  Ideally there'd be a dev there, but I'd need to check if the
> s3c24xx stuff does that.

And should not be passing a NULL device to clk_get().

-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
