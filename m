From: Daniel Chen <seven.steps@gmail.com>
Subject: Re: No sound on Acer Aspire 6935G
Date: Tue, 28 Apr 2009 16:36:01 -0400
Message-ID: <604760770904281336y2e6384aw99f37716ac727515@mail.gmail.com>
References: <4b8c423b0904250904i226fd458we275c263475a3b8c@mail.gmail.com>
	<4b8c423b0904271901i2f32a3e2r40a8b3f481e46a1d@mail.gmail.com>
	<s5h63gp2usp.wl%tiwai@suse.de>
	<4b8c423b0904272308o5baaf3e0v703016169372a4c9@mail.gmail.com>
	<s5hws951esg.wl%tiwai@suse.de>
	<4b8c423b0904280744r1f0f08adn63d581fe2120c78d@mail.gmail.com>
	<s5hws9425r2.wl%tiwai@suse.de>
	<4b8c423b0904280810ie07e7d3h28f16df90708e5da@mail.gmail.com>
	<s5hocug2491.wl%tiwai@suse.de>
	<4b8c423b0904280846r3c29c402ic54c4d1004ffe8f4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f158.google.com (mail-gx0-f158.google.com
	[209.85.217.158])
	by alsa0.perex.cz (Postfix) with ESMTP id 170FB1038A0
	for <alsa-devel@alsa-project.org>;
	Tue, 28 Apr 2009 22:36:22 +0200 (CEST)
Received: by gxk2 with SMTP id 2so1591116gxk.8
	for <alsa-devel@alsa-project.org>; Tue, 28 Apr 2009 13:36:20 -0700 (PDT)
In-Reply-To: <4b8c423b0904280846r3c29c402ic54c4d1004ffe8f4@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Karthik Ramgopal <applefreakpeeps@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Because you compiled your own drivers from the snapshot, you should pass the
appropriate --with-debug= to ./configure.

On Apr 28, 2009 11:47 AM, "Karthik Ramgopal" <applefreakpeeps@gmail.com>
wrote:

I am using the ubuntu stock kernel.. Should i compile a custom kernel with
this option?

Regards,
Karthik

On Tue, Apr 28, 2009 at 11:21 PM, Takashi Iwai <tiwai@suse.de> wrote: > At
Tue, 28 Apr 2009 23:10:...
