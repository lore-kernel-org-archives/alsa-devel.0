From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/3] soc - pxa2xx-ac97: Add missing clk_enable()
Date: Tue, 15 Apr 2008 15:36:44 +0100
Message-ID: <20080415143644.GA7144@rakim.wolfsonmicro.main>
References: <20080414151128.GA23694@rakim.wolfsonmicro.main>
	<1208185942-27637-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<f17812d70804150432t1fd0e20cpedaba34b47eb807d@mail.gmail.com>
	<20080415122906.GC24498@rakim.wolfsonmicro.main>
	<f17812d70804150711i5f3dbda4xc7cbff889567d46f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
Content-Disposition: inline
In-Reply-To: <f17812d70804150711i5f3dbda4xc7cbff889567d46f@mail.gmail.com>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/lurker/list/linux-arm-kernel.html>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: eric miao <eric.y.miao@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-arm-kernel@lists.arm.linux.org.uk
List-Id: alsa-devel@alsa-project.org

On Tue, Apr 15, 2008 at 10:11:34PM +0800, eric miao wrote:
> On Tue, Apr 15, 2008 at 8:29 PM, Mark Brown

> >  For correctness WRT the clock API it's required on all variants - the
> >  note about PXA3xx is just to indicate how it got through testing.

> I'm OK with this then, and it would be better the commit message been
> modified to a more consistent version :)

It's probably easier to just not mention that it ever worked at all :/

-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
