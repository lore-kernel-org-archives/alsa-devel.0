From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: WM8804: Initial driver
Date: Mon, 04 Oct 2010 10:40:51 +0100
Message-ID: <1286185251.2216.14.camel@dplaptop>
References: <1285755296-24497-1-git-send-email-dp@opensource.wolfsonmicro.com>
	<4CA98E38.3090601@elproma.com.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 46061243BC
	for <alsa-devel@alsa-project.org>;
	Mon,  4 Oct 2010 11:40:54 +0200 (CEST)
In-Reply-To: <4CA98E38.3090601@elproma.com.pl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Grzegorz Daniluk <g.daniluk@elproma.com.pl>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, 2010-10-04 at 10:20 +0200, Grzegorz Daniluk wrote:
> Dimitris Papastamos wrote:
> > The WM8804 is a high performance consumer mode
> > S/PDIF transceiver with support for 1 received channel and
> > 1 transmitted channel.
> >
> > Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
> > ---
> >   
> Hi,
> how could I test your driver? I have patched the alsa 1.0.23 but had 
> compilation errors. There is e.g. no 'snd_soc_codec_driver' in *.h files 
> and 'snd_soc_codec' structure does not have the 'driver' member. I've 
> also tried to use the newest tarball of alsa-driver 
> (alsa-driver-1.0.23.75.g04a15.554.g80f5d) but had the same result.

The WM8804 I've posted on this list has been developed against this tree
http://git.kernel.org/?p=linux/kernel/git/broonie/sound-2.6.git;a=tree;h=refs/heads/for-2.6.37;hb=for-2.6.37

I've also backported the WM8804 for older kernels.  You can get that
driver from here
http://opensource.wolfsonmicro.com/cgi-bin/gitweb.cgi?p=linux-2.6-asoc.git;a=summary

Thanks,
Dimitrios
