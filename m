From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Removal of indirect access in control API
Date: Thu, 15 Nov 2007 18:29:06 +0100 (CET)
Message-ID: <Pine.LNX.4.61.0711151821160.19062@tm8103.perex-int.cz>
References: <s5h8x4zd785.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 7CC55244EF
	for <alsa-devel@alsa-project.org>; Thu, 15 Nov 2007 18:29:07 +0100 (CET)
In-Reply-To: <s5h8x4zd785.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 15 Nov 2007, Takashi Iwai wrote:

> Hi,
> 
> ALSA control elements have "indirect" flag, which is supposed to allow
> the indirect access via pointer.  But, as far as I know, this feature
> has never been used nor implemented, and unsupported via 32/64bit
> compat layer.
> 
> So, I'd like to get rid of this now.  The clean-up patch is below.
> 
> If you have objections, please let me know.

I have objection. This layer was designed to support large mixer matrixes 
like in the HDSPM driver (and if I remember correctly - implementation was 
started after discussion with authors of RME drviers). HDSPM driver uses 
hwdep interface now (probably because it was ported from the OSS code).
I think that it would be worth to use standard ALSA control interface to 
track changes thus to finish indirect interface.

Which problems are with the 32/64 bit conversion layer? I suppose that it 
is possible to write an ioctl converters.

					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project
