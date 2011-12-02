From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v3] sound/soc/codecs: add LAPIS
	Semiconductor ML26124
Date: Fri, 2 Dec 2011 01:06:47 +0000
Message-ID: <20111202010644.GC31948@opensource.wolfsonmicro.com>
References: <1322474755-18785-1-git-send-email-tomoya.rohm@gmail.com>
	<20111128132317.GD8275@opensource.wolfsonmicro.com>
	<CANKRQng3YtYZggVWp3BWyaWyaHAbN1hccJksWELnv2co37rEcQ@mail.gmail.com>
	<20111129122916.GM2851@opensource.wolfsonmicro.com>
	<CANKRQnjpYDJWfJO-G5HsE6es7metHeqgP32R3eo99MaE2zdNpQ@mail.gmail.com>
	<s5hhb1kvix5.wl%tiwai@suse.de>
	<CANKRQniRonz5UcQ-KgnFJptPkqgWWrJsFuW31f8bWCf_xx-tTA@mail.gmail.com>
	<20111201111137.GC2915@opensource.wolfsonmicro.com>
	<CANKRQng4+fKY-3FLMKB_Z-JLB-Xhqpvx90uecFNQCS=NDG55pw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 63E2924588
	for <alsa-devel@alsa-project.org>; Fri,  2 Dec 2011 02:06:51 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <CANKRQng4+fKY-3FLMKB_Z-JLB-Xhqpvx90uecFNQCS=NDG55pw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Tomoya MORINAGA <tomoya.rohm@gmail.com>
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Mike Frysinger <vapier@gentoo.org>, qi.wang@intel.com, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, yong.y.wang@intel.com, kok.howg.ewe@intel.com, Daniel Mack <zonque@gmail.com>, Liam Girdwood <lrg@ti.com>, joel.clark@intel.com
List-Id: alsa-devel@alsa-project.org

On Fri, Dec 02, 2011 at 09:33:23AM +0900, Tomoya MORINAGA wrote:

> Which description do you want ?

> EQ Band1 Volume
> EQ Band1 Switch

> or

> EQ Band1 Input Volume
> EQ Band1 Input Switch

Either is fine, if I had to pick one I'd go with the first one.  The
important thing is that Switch and Volume use the same string.
