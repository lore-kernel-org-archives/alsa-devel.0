From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Alsa MMAP emulation
Date: Wed, 05 Mar 2008 18:36:19 +0100
Message-ID: <47CEDA13.6060401@ladisch.de>
References: <47CE7A47.80009@xwaves.net> <47CEC173.2060005@ladisch.de>
	<61445c750803050930j188415e0x3b7fb5cb7a7957b7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id C867E1038E3
	for <alsa-devel@alsa-project.org>; Wed,  5 Mar 2008 18:34:45 +0100 (CET)
In-Reply-To: <61445c750803050930j188415e0x3b7fb5cb7a7957b7@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Pharaoh ." <pharaoh137@gmail.com>
Cc: alsa-devel@alsa-project.org, Mathieu Monney <zittix_all@xwaves.net>
List-Id: alsa-devel@alsa-project.org

Pharaoh . wrote:
> On Wed, Mar 5, 2008 at 7:51 AM, Clemens Ladisch <clemens@ladisch.de> wrote:
> > Mathieu Monney wrote:
> > > use mmap'ing on my DSP plugin ? I saw there is a mmap_emulation flag but
> > > the problem is that it seems to be only available on HW driver and not
> > > on alsa plugins.
> >
> > In alsa-lib 1.0.15, this function was moved into the mmap_emul plugin.
>
> So, the original plugin need not be modified? mmap_emul plugin has to
> be used on top of it?

Yes.


HTH
Clemens
