From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [PATCH V2 0/9] mpc5200 audio rework for AC97
Date: Sat, 23 May 2009 19:20:31 -0400
Message-ID: <9e4733910905231620m29510186mc983c9c4e568f4bb@mail.gmail.com>
References: <20090523231148.17919.46103.stgit@terra>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f103.google.com (mail-qy0-f103.google.com
	[209.85.221.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 5036024430
	for <alsa-devel@alsa-project.org>;
	Sun, 24 May 2009 01:20:34 +0200 (CEST)
Received: by qyk1 with SMTP id 1so3519537qyk.16
	for <alsa-devel@alsa-project.org>; Sat, 23 May 2009 16:20:31 -0700 (PDT)
In-Reply-To: <20090523231148.17919.46103.stgit@terra>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: grant.likely@secretlab.ca, linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, broonie@sirena.org.uk
List-Id: alsa-devel@alsa-project.org

On Sat, May 23, 2009 at 7:12 PM, Jon Smirl <jonsmirl@gmail.com> wrote:
> The following series implements audio support for the mpc5200. It adds an AC97 driver and STAC9766 codec driver. Board support for the Efika and Phytec pcm030 are also included.

Series is based on branch for-2.6.31 commit
0154724d487586241c1ad57cfd348ed2ff2274e2  at
git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git

-- 
Jon Smirl
jonsmirl@gmail.com
