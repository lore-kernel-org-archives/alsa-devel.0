From: pl bossart <bossart.nospam@gmail.com>
Subject: Re: Is there a way to figure out if the clocks of two
	snd_pcm_t's deviate? (snd_pcm_info_get_sync?)
Date: Wed, 9 Sep 2009 11:03:18 -0500
Message-ID: <6160a5130909090903n15d13515w223c14c21d1a5bba@mail.gmail.com>
References: <20090903230351.GA7493@tango.0pointer.de>
	<6160a5130909040552k34548733o3d2fc71e1a7362c8@mail.gmail.com>
	<20090908231853.GC32605@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-px0-f171.google.com (mail-px0-f171.google.com
	[209.85.216.171])
	by alsa0.perex.cz (Postfix) with ESMTP id B88BE103870
	for <alsa-devel@alsa-project.org>;
	Wed,  9 Sep 2009 18:03:20 +0200 (CEST)
Received: by pxi1 with SMTP id 1so76268pxi.23
	for <alsa-devel@alsa-project.org>; Wed, 09 Sep 2009 09:03:18 -0700 (PDT)
In-Reply-To: <20090908231853.GC32605@tango.0pointer.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> but why shouldn't this information be queriable from the drivers?
> Drivers do know a lot about the hardware they drive, so they should
> now about clocks, too.

You are correct, drivers typically configure serial audio links to be
master or slave, and what is the clock source. In SoC this would be
done in the dai link configurations. If you had a means to report this
information to userspace then yes you could find out if two interfaces
are in sync. It might be a bit more complex for USB since the standard
specifies different ways of sending audio out.
Cheers
- Pierre
