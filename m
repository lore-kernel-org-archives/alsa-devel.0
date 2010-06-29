From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: alsamixer-qt4 release
Date: Wed, 30 Jun 2010 07:17:56 +0800
Message-ID: <AANLkTinFWqtgK4HiByHbgTFP6WKn8cnf13fL4xIDTRa2@mail.gmail.com>
References: <4C2119D7.8040100@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 0C8E31037F9
	for <alsa-devel@alsa-project.org>;
	Wed, 30 Jun 2010 01:17:58 +0200 (CEST)
Received: by vws11 with SMTP id 11so202406vws.38
	for <alsa-devel@alsa-project.org>; Tue, 29 Jun 2010 16:17:57 -0700 (PDT)
In-Reply-To: <4C2119D7.8040100@gmx.de>
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

2010/6/23 Sebastian H. <vand2@gmx.de>

> Hello list
>
> Here is (yet another) mixer application for ALSA: alsamixer-qt4
> It took a bit longer that expected but today I've erased the last items
> from the TODO list for the first release version 0.1.0.
>
> All files are hosted at sourceforge
> http://sourceforge.net/projects/alsamixer-qt4/files/
>
> And here's a small web page
> http://xwmw.org/alsamixer-qt4
>
> At the moment it is a volume only mixer and the dB value is
> only displayed but the scaling sliders are worth a look
> (The style is homebrewn ;).
>
> So far.
>
> Regards,
> Sebastian H.
>

Some of the controls may be better represented by a progress bar instead of
slider since they don't have write access (i.e. the mixer application cannot
update the value ) , for example, those status ,

vumeter peak and equalizer peak  which has volatile access and this mean
that you need to a timer to read the values periodically
