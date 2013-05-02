From: JongHo Kim <furmuwon@gmail.com>
Subject: Re: [PATCH] ASoC: Added the condition for the
	channels_min of cpu_dai
Date: Thu, 2 May 2013 16:04:55 +0900
Message-ID: <CANXQt8Z+4GqnGcxfs8rqPXAZu4WYiVqjV=J9REMhwic_K6CaSA@mail.gmail.com>
References: <CANXQt8bj5ZB9aSd5jNC34TYeg4SnGz9h00JJQBS0vHQdEW5LRA@mail.gmail.com>
 <20130430184226.GG26160@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f41.google.com (mail-la0-f41.google.com
 [209.85.215.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 5BAB32608EE
 for <alsa-devel@alsa-project.org>; Thu,  2 May 2013 09:04:56 +0200 (CEST)
Received: by mail-la0-f41.google.com with SMTP id fn20so227289lab.0
 for <alsa-devel@alsa-project.org>; Thu, 02 May 2013 00:04:55 -0700 (PDT)
In-Reply-To: <20130430184226.GG26160@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org

2013/5/1 Mark Brown <broonie@kernel.org>

> On Tue, Apr 30, 2013 at 03:31:16PM +0900, JongHo Kim wrote:
> > Only playback device, the pcm substream for capture does not need to be
> > generated. If codec dai driver has both playback.channels_min and
> > capture.channels_min, and cpu dai driver has only playback.channels_min,
> > soc_new_pcm() will make the pcm substream for capture although
> > DataIN is not connected.
> > So added the condition for the channels_min of cpu_dai in soc_new_pcm().
>
> This doesn't appear to apply against current -next, can you please check
> and resend?
>

Please excuse my poor English.
I don't understand what you're talking about.
I need a more detailed explanation of the 'current -next'.
