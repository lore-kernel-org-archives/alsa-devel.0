From: Timur Tabi <timur@freescale.com>
Subject: Re: snd-soc-cs4270: Convert to a new-style i2c driver
 (work in progress)
Date: Thu, 04 Sep 2008 09:44:00 -0500
Message-ID: <48BFF430.1090201@freescale.com>
References: <20080831161843.227b31f3@hyperion.delvare>
	<ed82fe3e0808310928v18eed8bdh98faa6796a516142@mail.gmail.com>
	<20080831190928.2931b0ed@hyperion.delvare>
	<ed82fe3e0809031247t3085e409x3141f9712ad962a9@mail.gmail.com>
	<ed82fe3e0809031330s5036e9d0g1c2b3e73096f2a6@mail.gmail.com>
	<20080904104224.GE13828@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	by alsa0.perex.cz (Postfix) with ESMTP id A31E424398
	for <alsa-devel@alsa-project.org>;
	Thu,  4 Sep 2008 16:44:06 +0200 (CEST)
In-Reply-To: <20080904104224.GE13828@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>, Jean Delvare <khali@linux-fr.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:

> If you build the codec driver as a module then you also need to build
> the machine driver as a module.  Your Kconfig ought to be enforcing
> that which I guess is the hack you had to put in?

I guess that's my problem, I was just loading the codec driver as a module.

-- 
Timur Tabi
Linux kernel developer at Freescale
