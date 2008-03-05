From: "Lee Revell" <rlrevell@joe-job.com>
Subject: Re: HDMI v. ICH8 on Dell XPS M1330
Date: Tue, 4 Mar 2008 19:54:58 -0500
Message-ID: <75b66ecd0803041654x2733bf35pbce849e7bef2ea85@mail.gmail.com>
References: <1204152070.12914.18.camel@localhost>
	<s5hablls40f.wl%tiwai@suse.de>
	<16A430A423D62246A24C9A892622FE66048B88@CORPEXCH1.na.ads.idt.com>
	<1204248546.12914.86.camel@localhost>
	<75b66ecd0803011903t535c8ecbv8f910077484035ff@mail.gmail.com>
	<16A430A423D62246A24C9A892622FE660550CF@CORPEXCH1.na.ads.idt.com>
	<1204498741.10206.26.camel@razman.gruemaster.com>
	<1204623862.13915.10.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from qb-out-0506.google.com (qb-out-0506.google.com [72.14.204.237])
	by alsa0.perex.cz (Postfix) with ESMTP id BABA41038A5
	for <alsa-devel@alsa-project.org>; Wed,  5 Mar 2008 01:55:00 +0100 (CET)
Received: by qb-out-0506.google.com with SMTP id q12so995873qba.12
	for <alsa-devel@alsa-project.org>; Tue, 04 Mar 2008 16:54:59 -0800 (PST)
In-Reply-To: <1204623862.13915.10.camel@localhost.localdomain>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jiang zhe <zhe.jiang@intel.com>
Cc: tiwai@suse.de, "Tellman, Steven" <Steven.Tellman@idt.com>, Armando Di Cianno <armando@goodship.net>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Mar 4, 2008 at 4:44 AM, Jiang zhe <zhe.jiang@intel.com> wrote:
> On Mon, 2008-03-03 at 06:59 +0800, Tobin Davis wrote:
>  > It is possible that HDMI audio is pulled from an unknown i2c bus on
>  > the
>  > video chip.  3dfx did that a long time ago with their 3500 card for
>  > their tv tuner portion.
>  >
>  > I think at this point, unless Steven knows more, this may be
>  > unsupported
>  > until nVidia adds support in their driver or opens up part of the
>  > spec.
>  >
>  I googled some info about the nvidia G84** or G86** graphics core.
>  They got the audio signal from the external audio device through spdif.
>
>  For Dell M1330, the spdif configuration for the stac92** codec looks
>  well, maybe the graphic driver can control whether the audio signal is
>  allowed to transfer through the HDMI port?

In addition to anecdotal evidence, I can confirm that on my work
machine the ATI video driver does seem to touch the audio.
Interestingly it's the userspace X driver, not the in-kernel FGLRX
module.

rlrevell@chronopolis:~$ strings
/usr/lib/xorg/modules/drivers/fglrx_drv.so | grep -i hdmi | grep -i
audio
ex_aHDMIAudioParameters

Isn't DRM fun? ;-)

Lee
