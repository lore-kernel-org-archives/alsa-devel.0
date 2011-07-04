From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Ensure we delay long enough
	for	WM8994 FLL to lock when starting
Date: Mon, 4 Jul 2011 03:07:05 +0100
Message-ID: <20110704020705.GA4430@opensource.wolfsonmicro.com>
References: <1309566922-3177-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<032501cc39dd$489c24d0$d9d46e70$@com>
	<20110704004453.GA1178@opensource.wolfsonmicro.com>
	<032b01cc39e7$a5888d00$f099a700$@com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C6A8A2439C
	for <alsa-devel@alsa-project.org>;
	Wed, 27 Jul 2011 14:18:51 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <032b01cc39e7$a5888d00$f099a700$@com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sangbeom Kim <sbkim73@samsung.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, 'Liam Girdwood' <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Jul 04, 2011 at 10:13:56AM +0900, Sangbeom Kim wrote:
> Is there any checking method for locking FLL?
> (ex. Checking register bit for FLL lock)

There is an interrupt which I've got a patch to use (it's in need of a
bit more testing so not yet published).  You can also poll the status
bits but on a lot of systems that works out as being too expensive due
to I/O costs.

> Just using msleep looks not enough to ensure FLL lock.

Practically speaking it's fine; the FLL lock time is specified
performance characteristic of the device.  If we can't lock when we
expect to then the system is in trouble and it's not clear what we can
do about usefully. 
