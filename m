From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: using plug for sample format conversion
Date: Wed, 28 Jul 2010 09:39:17 +0800
Message-ID: <AANLkTin_5EKauGfFxj8uF_9abtS9a4PzoxcVNuC4ZhFr@mail.gmail.com>
References: <AANLkTimd1EShJJ75Y_FZX7fkv1vDg8JDFTMBcLnWHAR8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 5094710380D
	for <alsa-devel@alsa-project.org>;
	Wed, 28 Jul 2010 03:39:20 +0200 (CEST)
Received: by vws20 with SMTP id 20so4558532vws.38
	for <alsa-devel@alsa-project.org>; Tue, 27 Jul 2010 18:39:19 -0700 (PDT)
In-Reply-To: <AANLkTimd1EShJJ75Y_FZX7fkv1vDg8JDFTMBcLnWHAR8@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2010/7/28 Adam Rosenberg <adam@alcorn.com>

> I am trying to use plug to play audio files that are S16_LE but my
> hardware only supports S32_LE.  It is not working.  Here is an example
> of the problem using speaker-test.  First I use S32_LE and it works as
> expected.  I then try S16_LE but it fails.  Does this mean the plug
> plugin cannot convert between these sample formats?
>
> Thanks,
> Adam
>

Please use latest version of speaker-test and alsa-lib

and post struct  snd_pcm_hardware of you driver
