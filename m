From: Vincent <zakora@gmail.com>
Subject: Re: Cannot record from front pluggable mic on 82801H
	(ICH8 Family) sound card
Date: Sat, 17 Jan 2009 17:49:19 +0100
Message-ID: <ef2423ab0901170849v7c768afy8c88b1e82fb80f11@mail.gmail.com>
References: <ef2423ab0901090857l1b592e34yd340f69c5c65fb92@mail.gmail.com>
	<s5htz84da4g.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.170])
	by alsa0.perex.cz (Postfix) with ESMTP id 5E9C524377
	for <alsa-devel@alsa-project.org>; Sat, 17 Jan 2009 17:49:21 +0100 (CET)
Received: by wf-out-1314.google.com with SMTP id 24so2177923wfg.23
	for <alsa-devel@alsa-project.org>; Sat, 17 Jan 2009 08:49:20 -0800 (PST)
In-Reply-To: <s5htz84da4g.wl%tiwai@suse.de>
Content-Disposition: inline
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

Hi,

I tried to install alsa-driver snapshot but I think I'm not enough skilled :
I first uninstall alsa-lib, then I install the alsa-driver snapshot. When I
try to (re)start alsa, I get this error:
"/usr/sbin/alsactl: error while loading shared libraries: libasound.so.2:
cannot open shared object file: No such file or directory"
and a "sudo find / -name 'libasound*'" didn't return any result.

Did I do the right installation processus? What else can I try to help?

Thanks

On Mon, Jan 12, 2009 at 12:41 PM, Takashi Iwai <tiwai@suse.de> wrote:

> At Fri, 9 Jan 2009 17:57:45 +0100,
> Vincent wrote:
> >
> > Hi,
> >
> > I'm working on a Dell 1525 and I want to plug a mic into the front mic
> port
> > in order to have a "clean" record. But when it doesn't record anything,
> all
> > I can have is the noise from the external mic.
> > Is there any specific actions I forgot to do?
> >
> > Here is my alsa-info output :
> >
> http://www.alsa-project.org/db/?f=a9066fcfe52fa0dd7d9bcd65214855c84592bd25
>
> Could you first try the latest alsa-driver snapshot (or sound git tree)?
>
> ftp://ftp.kernel.org/pub/linux/kernel/people/tiwai/snapshot/alsa-driver-snapshot.tar.gz
>
>
> Takashi
>
