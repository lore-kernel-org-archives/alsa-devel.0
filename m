From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Constant headphone noise on Dell XPS 13 9365
Date: Wed, 31 May 2017 13:56:53 -0500
Message-ID: <CAMP44s1tQ0Ss21v1OuyFWS3CtpQzO8Qid+Q8GcE0x9VFc=DPJA@mail.gmail.com>
References: <CAMP44s000FA3BAQEwqxPQxUGeR4U=PhByJfAAA9q74M8=6iTyQ@mail.gmail.com>
 <s5h1sr4dh3w.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vk0-f44.google.com (mail-vk0-f44.google.com
 [209.85.213.44])
 by alsa0.perex.cz (Postfix) with ESMTP id B9AEA266FA5
 for <alsa-devel@alsa-project.org>; Wed, 31 May 2017 20:56:55 +0200 (CEST)
Received: by mail-vk0-f44.google.com with SMTP id w1so13462222vkd.2
 for <alsa-devel@alsa-project.org>; Wed, 31 May 2017 11:56:55 -0700 (PDT)
In-Reply-To: <s5h1sr4dh3w.wl-tiwai@suse.de>
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

On Wed, May 31, 2017 at 1:19 PM, Takashi Iwai <tiwai@suse.de> wrote:

> Is there "Loopback Mixer" switch?  If yes and it's on, try to turn it
> off.  The analog loopback is often the source of the unknown noise.

Yes, "Loopback Mixing". it was off.

> Other than that, try to apply the existing quirks.  Some of them are
> applicable via model option of snd-hda-intel module.

Which quirks should I try?

-- 
Felipe Contreras
