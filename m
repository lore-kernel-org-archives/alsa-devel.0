From: Jussi Laako <jussi@sonarnerd.net>
Subject: Re: [PATCH 0/1] Add big-endian DSD sample formats and
 fix XMOS DSD sample format
Date: Fri, 21 Nov 2014 14:08:23 +0200 (EET)
Message-ID: <alpine.BSO.2.11.1411211405530.18401@rankki.sonarnerd.net>
References: <1416564029-6018-1-git-send-email-jussi@sonarnerd.net>
 <s5hegswx2dr.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.sonarnerd.net (rankki.sonarnerd.net [83.145.240.118])
 by alsa0.perex.cz (Postfix) with ESMTP id 7D712266516
 for <alsa-devel@alsa-project.org>; Fri, 21 Nov 2014 13:08:26 +0100 (CET)
In-Reply-To: <s5hegswx2dr.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, gtmkramer@xs4all.nl
List-Id: alsa-devel@alsa-project.org

On Fri, 21 Nov 2014, Takashi Iwai wrote:

> At Fri, 21 Nov 2014 12:00:26 +0200,
> Jussi Laako wrote:
> > 
> > Resend, previous had non matching subject for cover letter vs patch.
> > 
> > This patch fixes XMOS DSD sample format to DSD_U32_BE and also adds
> > DSD_U16_BE and DSD_U32_BE sample formats.
> > 
> > Jussi Laako (1):
> >   Add big-endian DSD sample formats and fix XMOS DSD sample format
> 
> The changes there look good (supposing you tested with the real
> device).  Since DSD_U32 was added in 3.18-rc1, I think we can put this
> as a fix for 3.18.
> 
> Could you submit the patch for alsa-lib as well?

I sent two patches, one is for kernel and another one is for alsa-lib.

I have tested the patches on top of Ubuntu Trusty using iFi iDSD Nano and 
everything works.


Best regards,

	- Jussi
