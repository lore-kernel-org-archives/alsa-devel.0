From: "J. Scott Merritt" <alsauser@pragmasoft.com>
Subject: Re: SALSA Lib 0.0.11 - pcm_drain
Date: Mon, 17 Sep 2007 09:32:43 -0400
Message-ID: <20070917093243.1cb6268e.alsauser@pragmasoft.com>
References: <20070916190132.53daf48e.alsauser@pragmasoft.com>
	<s5hmyvleahs.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp6.server.rpi.edu (smtp6.server.rpi.edu [128.113.2.226])
	by alsa0.perex.cz (Postfix) with ESMTP id 48ED510386A
	for <alsa-devel@alsa-project.org>;
	Mon, 17 Sep 2007 15:27:26 +0200 (CEST)
In-Reply-To: <s5hmyvleahs.wl%tiwai@suse.de>
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

On Mon, 17 Sep 2007 14:34:39 +0200
Takashi Iwai <tiwai@suse.de> wrote:

> At Sun, 16 Sep 2007 19:01:32 -0400,
> J. Scott Merritt wrote:
> > 
> > In salsa-lib 0.0.11, pcm-macros.h : line 229
> > 
> > snd_pcm_drain calls the ioctl with SNDRV_PCM_IOCTL_DROP.
> > (seemingly confusing -drop- with -drain-)
> > 
> > Is there any reason that this shouldn't be changed to
> > call the ioctl with SNDRV_PCM_IOCTL_DRAIN ?
> 
> Sure, it's a typo :)
> 
> Fixed and released as 0.0.12 now.  Thanks!
> 
> 
> Takashi

Thanks Takashi,

I do not yet see 0.0.12 on the FTP server
(ftp.suse.com/pub/people/tiwai/salsa-lib), but I'm sure
it will be there shortly.

However, if you are preparing another SALSA release, you might
also want to consider including:

pcm->stream = stream;

somewhere around line 133 in pcm.c (as per my message
snd_pcm_avail_update on 14-Sep-2007).

Thanks, Scott.
