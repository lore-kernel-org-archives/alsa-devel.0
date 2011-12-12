From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v3] sound/soc/lapis: add machine driver v3
	updated
Date: Mon, 12 Dec 2011 14:57:52 +0800
Message-ID: <20111212065751.GA20343@opensource.wolfsonmicro.com>
References: <1323428632-29309-1-git-send-email-tomoya.rohm@gmail.com>
	<20111209122457.GA29492@opensource.wolfsonmicro.com>
	<CANKRQnj+x=QDgAoAi7MBq9Kjvin8kO8OjMrDJSZFW5+4Mz89pQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B26D724377
	for <alsa-devel@alsa-project.org>; Mon, 12 Dec 2011 07:57:57 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <CANKRQnj+x=QDgAoAi7MBq9Kjvin8kO8OjMrDJSZFW5+4Mz89pQ@mail.gmail.com>
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

On Mon, Dec 12, 2011 at 03:56:47PM +0900, Tomoya MORINAGA wrote:

> I just started developing plat form driver.
> According to platform.txt, soc/pxa/pxa2xx-pcm.c is shown as example.
> Can I believes this description ?
> If the driver is not modern, let me know the modern platform driver.

It's pretty old but there's not been many updates in the world of
platform drivers.  In general if you're looking for modern drivers git
log is your friend - look for things that are being actively worked on.
