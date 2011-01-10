From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: Re: snd_soc_codec_set_cache_io()
Date: Mon, 10 Jan 2011 10:15:53 +0000
Message-ID: <1294654553.11031.2.camel@dplaptop.localdomain>
References: <AANLkTikew7_zd1-H+oiirBghFcd176U6t0r-MFAv_DM5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 64992243DE
	for <alsa-devel@alsa-project.org>; Mon, 10 Jan 2011 11:16:07 +0100 (CET)
In-Reply-To: <AANLkTikew7_zd1-H+oiirBghFcd176U6t0r-MFAv_DM5@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: alsa-devel mailing list <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Sun, 2011-01-09 at 16:15 -0600, Timur Tabi wrote:
> Mark,
> 
> The comments for snd_soc_codec_set_cache_io() say this:
> 
>  * Note that at present this code cannot be used by CODECs with
>  * volatile registers.
> 
> Is this still true?  I ask because I think I've been able to use this
> function in the CS4270 with volatile registers, and it appears to
> work.

This seems to be outdated.  The soc-cache code can handle volatile
registers correctly if the driver has provided a volatile_register
callback which returns 1 for all registers that are volatile and 0
for all others.

Thanks,
Dimitris
