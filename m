From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 06/17] Documentation: Define the MOP500
 Audio Machine Driver Device Tree bindings
Date: Tue, 11 Sep 2012 17:08:42 +0800
Message-ID: <20120911090840.GA9381@opensource.wolfsonmicro.com>
References: <1345816913-4113-1-git-send-email-lee.jones@linaro.org>
 <1345816913-4113-7-git-send-email-lee.jones@linaro.org>
 <20120910164413.GC24506@gmail.com>
 <504EFEF8.6020707@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 66DBC264F53
 for <alsa-devel@alsa-project.org>; Tue, 11 Sep 2012 11:08:54 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <504EFEF8.6020707@stericsson.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ola Lilja <ola.o.lilja@stericsson.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Linus WALLEIJ <linus.walleij@stericsson.com>, "arnd@arndb.de" <arnd@arndb.de>, Roger NILSSON1 <roger.xr.nilsson@stericsson.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, STEricsson_nomadik_linux <STEricsson_nomadik_linux@list.st.com>, Lee Jones <lee.jones@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Sep 11, 2012 at 11:06:00AM +0200, Ola Lilja wrote:
> On 09/10/2012 06:44 PM, Lee Jones wrote:

> >> +	msp1: msp@80124000 {
> >> +		compatible = "stericsson,ux500-msp-i2s";
> >> +		reg = <0x80124000 0x1000>;
> >> +		interrupts = <0 62 0x4>;
> >> +		v-ape-supply = <&db8500_vape_reg>;

> I'm no DT-expert, but why are you adding MSP-stuff in the machine-driver? They
> are also added in the next patch.

This is context for the example - the example is just informative and
tends to include other things so they can be referenced by the main bit
of the example, it's the documentation at the top that's the bindings
themselves.
