From: Jurgen Kramer <gtmkramer@xs4all.nl>
Subject: Re: [PATCH 0/1] Add big-endian DSD sample formats and
 fix XMOS DSD sample format
Date: Fri, 21 Nov 2014 12:50:51 +0100
Message-ID: <1416570651.7009.1.camel@xs4all.nl>
References: <1416564029-6018-1-git-send-email-jussi@sonarnerd.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lb2-smtp-cloud2.xs4all.net (lb2-smtp-cloud2.xs4all.net
 [194.109.24.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 915C92667B2
 for <alsa-devel@alsa-project.org>; Fri, 21 Nov 2014 12:50:54 +0100 (CET)
In-Reply-To: <1416564029-6018-1-git-send-email-jussi@sonarnerd.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jussi Laako <jussi@sonarnerd.net>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, 2014-11-21 at 12:00 +0200, Jussi Laako wrote:
> Resend, previous had non matching subject for cover letter vs patch.
> 
> This patch fixes XMOS DSD sample format to DSD_U32_BE and also adds
> DSD_U16_BE and DSD_U32_BE sample formats.
> 
> Jussi Laako (1):
>   Add big-endian DSD sample formats and fix XMOS DSD sample format
> 
>  include/sound/pcm.h         | 2 ++
>  include/uapi/sound/asound.h | 4 +++-
>  sound/core/pcm.c            | 2 ++
>  sound/core/pcm_misc.c       | 8 ++++++++
>  sound/usb/quirks.c          | 4 ++--
>  5 files changed, 17 insertions(+), 3 deletions(-)
> 
Acked-by: Jurgen Kramer <gtmkramer@xs4all.nl>

I have tested the complete chain (added DSD_BE to kernel, alsa-lib,
alsa-utils) with the change to BE. Everything still works.

Jurgen
