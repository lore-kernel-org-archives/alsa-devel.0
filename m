From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] ASoC: wm8996: ensure lower bounds of 1 for timeout
Date: Mon, 9 Mar 2015 14:27:37 +0000
Message-ID: <20150309142737.GC26692@opensource.wolfsonmicro.com>
References: <1425808958-17104-1-git-send-email-hofrat@osadl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1425808958-17104-1-git-send-email-hofrat@osadl.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicholas Mc Guire <hofrat@osadl.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Sun, Mar 08, 2015 at 06:02:38AM -0400, Nicholas Mc Guire wrote:
> wait_for_completion_timeout can be called with timeout == 0 due to
> msecs_to_jiffies(2) == 1 for HZ < 1000 and usecs_to_jiffies(300) == 1
> for all reasonable values of HZ, thus the following timeout /= 2; sets
> timeout to 0. This patch simply adds a lower-bounds of 1.
> 
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Thanks,
Charles
