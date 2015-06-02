From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: ASoC: PATCH: wm8731 - reinitialize regmap
	cache	after hardware reset
Date: Tue, 2 Jun 2015 12:55:43 +0100
Message-ID: <20150602115543.GF3449@opensource.wolfsonmicro.com>
References: <CA+abuVebbr9Cif_SfB+JcNhUOMV70fdWa-Q-nk+gFv9H5MRtgQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1C90326506E
 for <alsa-devel@alsa-project.org>; Tue,  2 Jun 2015 13:55:45 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CA+abuVebbr9Cif_SfB+JcNhUOMV70fdWa-Q-nk+gFv9H5MRtgQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sergey Kiselev <skiselev@gmail.com>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, May 28, 2015 at 09:34:09AM -0700, Sergey Kiselev wrote:
> Hi,
> 
> I am working on a machine driver that uses wm8731 codec and I've
> noticed that it will not work after rmmod/modprobe of that machine
> driver. The issue is that wm8731_probe() resets the hardware, but it
> doesn't reinitialize the regmap cache to the default values.
> 
> The patch below fixes this issue.
> 
> I also skimmed through other codecs, and some of them might have
> similar issue (wm8510.c, wm8711.c, wm8750.c, wm8753.c, wm8940.c,
> wm8960.c, wm8971.c, wm8974.c, wm8988.c, wm8990.c)
> 
> Another way to avoid this issue might be resetting the codec in the
> *_spi_probe()/*_i2c_probe(), so that it only gets reset once when
> codec is loading.
> 
> Thanks in advance for any comments/suggestions on the patch.
> 
> Thanks,
> Sergey
> 
> Signed-off-by: Sergey Kiselev <skiselev@gmail.com>
> 

In addition to the comments from Mark and Liam, if you could CC
patches@opensource.wolfsonmicro.com when submitting patches to
the Wolfson stuff, ensures we will see them going through, it is
easy to miss stuff on the generic lists.

Thanks,
Charles
