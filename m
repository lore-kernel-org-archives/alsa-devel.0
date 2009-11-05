From: Alex Austin <circuitsoft.alex@gmail.com>
Subject: Re: Trying to get unsupported CODEC to work
Date: Thu, 5 Nov 2009 05:44:51 -0600
Message-ID: <53baa24a0911050344y6134c47ev200d855bbef2973f@mail.gmail.com>
References: <53baa24a0812111428j143c23berb8ba0819b6b55eac@mail.gmail.com>
	<s5hd4fxdgf7.wl%tiwai@suse.de>
	<53baa24a0812120054u6c605987seba0d3066b2d5fa7@mail.gmail.com>
	<s5h1vwdd9xl.wl%tiwai@suse.de>
	<53baa24a0812120129q609e567bjf2286060d7f25da7@mail.gmail.com>
	<s5hy6ylbux6.wl%tiwai@suse.de>
	<53baa24a0911050115h4ef8cecfjff733dd06c801a7f@mail.gmail.com>
	<s5hocnhgtlj.wl%tiwai@suse.de>
	<53baa24a0911050227t15fc1c4cn4203b10b9ae78c7c@mail.gmail.com>
	<s5hiqdpgsdc.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-px0-f177.google.com (mail-px0-f177.google.com
	[209.85.216.177])
	by alsa0.perex.cz (Postfix) with ESMTP id BDF6B103942
	for <alsa-devel@alsa-project.org>; Thu,  5 Nov 2009 12:44:52 +0100 (CET)
Received: by pxi7 with SMTP id 7so1212927pxi.17
	for <alsa-devel@alsa-project.org>; Thu, 05 Nov 2009 03:44:51 -0800 (PST)
In-Reply-To: <s5hiqdpgsdc.wl%tiwai@suse.de>
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

On Thu, Nov 5, 2009 at 4:47 AM, Takashi Iwai <tiwai@suse.de> wrote:

> ...snip...

> So, the only reason it won't work now is because of duplicate control
> names?
>
> Basically yes.  PCM devices are assigned more or less dynamically.
>

So, assuming no control names conflict, what will alsamixer display
for "Chip:"? Just curious. Doesn't really matter.
