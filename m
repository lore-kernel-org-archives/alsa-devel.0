From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [PATCH V1 00/13] mpc5200 audio rework for AC97
Date: Wed, 13 May 2009 22:03:24 -0400
Message-ID: <9e4733910905131903n1f57347ak71872fbfd8d073ee@mail.gmail.com>
References: <20090514015729.28145.30483.stgit@terra>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f103.google.com (mail-qy0-f103.google.com
	[209.85.221.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 872C524351
	for <alsa-devel@alsa-project.org>;
	Thu, 14 May 2009 04:03:28 +0200 (CEST)
Received: by qyk1 with SMTP id 1so1846182qyk.16
	for <alsa-devel@alsa-project.org>; Wed, 13 May 2009 19:03:27 -0700 (PDT)
In-Reply-To: <20090514015729.28145.30483.stgit@terra>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: grant.likely@secretlab.ca, broonie@sirena.org.uk
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, May 13, 2009 at 9:58 PM, Jon Smirl <jonsmirl@gmail.com> wrote:
> The following series implements audio support for the
> mpc5200. It adds an AC97 driver and STAC9766 codec
> driver. Board support for the Efika and Phytec pcm030
> are also included. I'm sure everyone will have some
> edits on this first version.

Series is based on 13e2c86c20f5d07b20d5a6dee24bcdd2b30b859f from
broonie/for-2.6.31
git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git

I pushed the tree out to http://git.digispeaker.com

-- 
Jon Smirl
jonsmirl@gmail.com
