From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: Problem trying to add ASoC ADAV801 support to my
 kernel
Date: Wed, 27 Jul 2011 10:09:35 +0200
Message-ID: <4E2FC7BF.7090500@metafoo.de>
References: <CAN=k24m3f0=rXKDrbK+9qNm6Qhwcm7aJf1_Fm4309+zWkF0p7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailhost.informatik.uni-hamburg.de
	(mailhost.informatik.uni-hamburg.de [134.100.9.70])
	by alsa0.perex.cz (Postfix) with ESMTP id 8DE7E2450B
	for <alsa-devel@alsa-project.org>;
	Wed, 27 Jul 2011 10:11:31 +0200 (CEST)
In-Reply-To: <CAN=k24m3f0=rXKDrbK+9qNm6Qhwcm7aJf1_Fm4309+zWkF0p7w@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Wayne Tams <wayne.tams@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 07/26/2011 03:31 PM, Wayne Tams wrote:
> Hi,
> 
> I am trying to add support for the ADAV801 codec to my 2.6.35.3 kernel. I
> came across this patch
> http://article.gmane.org/gmane.linux.alsa.devel/86474 obviously
> I had to make some modifications so it would correctly patch my source.
> However when I come to build the kernel I'm getting a whole host of errors
> and I am little unsure on how to proceed, could anyone maybe provide some
> guidance on the possible causes of my errors or maybe there is a more update
> driver available.
> 
> Many thanks
> 
> W

Your kernel version is rather old and was before the big Multi-Component patch,
which change the ASoC API quite a bit.
There is an old patch[1] adding ADAV801 support which still uses the pre
Multi-Component API you could use. Other options are to update your kernel to a
more recent version or backport the Multi-Component patch.

- Lars

[1] http://www.spinics.net/lists/alsa-devel/msg36465.html
