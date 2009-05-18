From: =?UTF-8?B?T3phbiDDh2HEn2xheWFu?= <ozan@pardus.org.tr>
Subject: Problems with maintaining a separate alsa-driver in a
	distribution
Date: Mon, 18 May 2009 13:33:10 +0300
Message-ID: <4A113966.5070807@pardus.org.tr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from pardus.org.tr (comar.uludag.org.tr [193.140.100.220])
	by alsa0.perex.cz (Postfix) with ESMTP id 68AEA24346
	for <alsa-devel@alsa-project.org>;
	Mon, 18 May 2009 12:33:12 +0200 (CEST)
Received: from [192.168.1.2] (unknown [88.249.178.198])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested) (Authenticated sender: ozan)
	by pardus.org.tr (Postfix) with ESMTP id AB26D669FEE5
	for <alsa-devel@alsa-project.org>;
	Mon, 18 May 2009 13:33:05 +0300 (EEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

I'm maintaining the ALSA stack as a separate alsa-driver using the
supplied tarballs from www.alsa-project.org unlike some popular distros
which uses the in-kernel sound/ stack. This has the advantage of quickly
acting against latest quirk or driver support changes and pushing a
driver update instead of whole the kernel update.

But there is a big disadvantage that I'm not able to figure out how to
solve:

When we enable the SND Kconfig option in kernel, some other sound
support for some DVB devices(e.g. SAA7134 sound support, etc.) are
enabled as well. So if you're using the in-kernel ALSA, you can enable
and use them happily but in my case, those additional sound supports
can't be enabled in kernel.

Is there a way to hack around this when a separate alsa-driver is used
in a distro? Is it technically possible to patch those tiny drivers onto
alsa-driver and compile them if the .config file from the kernel source
has enabled those DVB devices?

Or maybe I should enable ALSA in-kernel, compile those DVB sound stuff
and remove the sound/ directory from the kernel package? (Even the idea
sounds really *dirty*, dunno if it's technically possible too)

Thanks,
Ozan Caglayan

http://www.pardus.org.tr/eng
