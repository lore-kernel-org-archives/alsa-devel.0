From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: Re: [RFC][ASoC] New device/driver arch
Date: Fri, 15 Jun 2007 16:40:07 +0100
Message-ID: <1181922007.26658.82.camel@localhost.localdomain>
References: <1181842832.26658.42.camel@localhost.localdomain>
	<20070614180656.GA22664@roarinelk.homelinux.net>
	<1181898259.26658.53.camel@localhost.localdomain>
	<8d6898730706150506i5e26a600t35cb0aba0b556890@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (unknown [80.75.67.54])
	by alsa0.perex.cz (Postfix) with ESMTP id 4D7EB103890
	for <alsa-devel@alsa-project.org>;
	Fri, 15 Jun 2007 17:40:09 +0200 (CEST)
In-Reply-To: <8d6898730706150506i5e26a600t35cb0aba0b556890@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Nobin Mathew <nobin.mathew@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, Manuel Lauss <mano@roarinelk.homelinux.net>, alsa-devel <alsa-devel@alsa-project.org>, Timur Tabi <timur@freescale.com>
List-Id: alsa-devel@alsa-project.org

On Fri, 2007-06-15 at 17:36 +0530, Nobin Mathew wrote:
> So in this architecture we will have so many devices registered to the kernel?

We will have more devices than at present, however the Linux device
interface is designed to deal with this and more.

Liam
