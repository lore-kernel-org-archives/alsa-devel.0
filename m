From: Jurgen Kramer <gtmkramer@xs4all.nl>
Subject: Re: [PATCH] Fix DSD formats userland usability
Date: Sun, 10 Aug 2014 15:38:42 +0200
Message-ID: <1407677922.4862.3.camel@xs4all.nl>
References: <1407578961-13291-1-git-send-email-gtmkramer@xs4all.nl>
 <s5h7g2gh8m1.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-vbr4.xs4all.nl (smtp-vbr4.xs4all.nl [194.109.24.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 19A4C261B0A
 for <alsa-devel@alsa-project.org>; Sun, 10 Aug 2014 15:38:44 +0200 (CEST)
In-Reply-To: <s5h7g2gh8m1.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sun, 2014-08-10 at 13:44 +0200, Takashi Iwai wrote:
> At Sat,  9 Aug 2014 12:09:21 +0200,
> Jurgen Kramer wrote:
> > 
> > Support for DSD sample formats has been added a while ago. This patch makes
> > those sample formats beter usable from userland (e.g. aplay).
> > 
> > ---
> >  include/sound/asound.h | 4 +++-
> >  src/pcm/pcm_misc.c     | 4 ++++
> 
> The new definitions are still missing in include/pcm.h?
> include/sound/asound.h is a copy from the kernel, and the user-land
> API is defined rather in include/pcm.h.
> 
OK, the updates to alsa-lib pcm_misc.c are still valid but do not
compile without my proposed update to include/sound/asound.h:

Compiling alsa-lib from git with update pcm_misc.c gives:
pcm_misc.c: In function 'snd_pcm_format_width':
pcm_misc.c:198:7: error: 'SNDRV_PCM_FORMAT_DSD_U8' undeclared (first use
in this function)
  case SNDRV_PCM_FORMAT_DSD_U8:
       ^
pcm_misc.c:198:7: note: each undeclared identifier is reported only once
for each function it appears in
pcm_misc.c:209:7: error: 'SNDRV_PCM_FORMAT_DSD_U16_LE' undeclared (first
use in this function)
  case SNDRV_PCM_FORMAT_DSD_U16_LE:
       ^
pcm_misc.c: In function 'snd_pcm_format_physical_width':
pcm_misc.c:258:7: error: 'SNDRV_PCM_FORMAT_DSD_U8' undeclared (first use
in this function)
  case SNDRV_PCM_FORMAT_DSD_U8:
       ^
pcm_misc.c:264:7: error: 'SNDRV_PCM_FORMAT_DSD_U16' undeclared (first
use in this function)
  case SNDRV_PCM_FORMAT_DSD_U16:

The SNDRV_PCM_FORMAT_DSD??? are there in /usr/include/sound/asound.h
It seems alsa-lib uses it own asound.h which does not have the DSD
defines. See 'include/sound/asound.h' is this intentional?

Jurgen
