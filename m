From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] Add some system information to
	alsa-info.sh output
Date: Mon, 30 Jun 2008 17:42:11 +0100
Message-ID: <20080630164210.GC21804@sirena.org.uk>
References: <1214843497.11032.4.camel@temp-fallen>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 54EA1243C3
	for <alsa-devel@alsa-project.org>;
	Mon, 30 Jun 2008 18:42:12 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1214843497.11032.4.camel@temp-fallen>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Travis Place <wishie@wishie.net>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 01, 2008 at 02:31:37AM +1000, Travis Place wrote:

> +if [ -d $SYSFS ]
> +then
> +BOARD_VENDOR=`cat /sys/devices/virtual/dmi/id/board_vendor`
> +PRODUCT_VERSION=`cat /sys/devices/virtual/dmi/id/product_version`
> +PRODUCT_NAME=`cat /sys/devices/virtual/dmi/id/product_name`

This produces visible errors if the information isn't present (which
would be reasonable enough).  It might be better to check for errors and
include something about being unable to read DMI information in the
report - that'd be a bit less scary.

Also, on my system the DMI information is under /sys/class/dmi rather
than /sys/devices/virtual (this is with 2.6.25).

> +fi

How about bios_vendor, bios_date and bios_version as well?

For embedded devices the relevant information is often in /proc/cpuinfo
so it might be worth adding that too.
