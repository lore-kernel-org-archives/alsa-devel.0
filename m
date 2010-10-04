From: Grzegorz Daniluk <g.daniluk@elproma.com.pl>
Subject: Re: [PATCH] ASoC: WM8804: Initial driver
Date: Mon, 04 Oct 2010 10:20:08 +0200
Message-ID: <4CA98E38.3090601@elproma.com.pl>
References: <1285755296-24497-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailmxout.mailmx.agnat.pl (mailmxout.mailmx.agnat.pl
	[193.239.44.238])
	by alsa0.perex.cz (Postfix) with ESMTP id C469D24337
	for <alsa-devel@alsa-project.org>;
	Mon,  4 Oct 2010 10:20:16 +0200 (CEST)
In-Reply-To: <1285755296-24497-1-git-send-email-dp@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Dimitris Papastamos wrote:
> The WM8804 is a high performance consumer mode
> S/PDIF transceiver with support for 1 received channel and
> 1 transmitted channel.
>
> Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
> ---
>   
Hi,
how could I test your driver? I have patched the alsa 1.0.23 but had 
compilation errors. There is e.g. no 'snd_soc_codec_driver' in *.h files 
and 'snd_soc_codec' structure does not have the 'driver' member. I've 
also tried to use the newest tarball of alsa-driver 
(alsa-driver-1.0.23.75.g04a15.554.g80f5d) but had the same result.

best regards,
Grzegorz
