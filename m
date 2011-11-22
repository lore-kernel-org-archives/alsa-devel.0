From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Device tree support for WM8994 and WM9713.
Date: Tue, 22 Nov 2011 19:43:35 +0000
Message-ID: <20111122194335.GB25453@opensource.wolfsonmicro.com>
References: <CAJuYYwRZcbsRz-+2Swck=PUXT+iHeRWN3fu-R8C7tBYUb1Pgqw@mail.gmail.com>
	<20111122124212.GC30048@opensource.wolfsonmicro.com>
	<CAJuYYwSyTqPn3QfZrMx6_9jwtngOGW5B5pxjuTy4JtrTGgC6pw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A69BE103807
	for <alsa-devel@alsa-project.org>; Tue, 22 Nov 2011 20:43:37 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <CAJuYYwSyTqPn3QfZrMx6_9jwtngOGW5B5pxjuTy4JtrTGgC6pw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Thomas Abraham <thomas.abraham@linaro.org>
Cc: alsa-devel@alsa-project.org, Kukjin Kim <kgene.kim@samsung.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 22, 2011 at 08:09:49PM +0530, Thomas Abraham wrote:

> Though platform data of wm8994 is not required for smdkv310, there are
> other boards 'goni' and 'aquila' which use the platform data. So to
> start with, we can ignore the platform data of wm8994 but having full
> dt support would be required for other boards.

Looking at those they're going to need the regulator bindings for device
tree to do anything useful.  I'd expect that to go into 3.3 but it'll be
hassle propagating the binding bits.
