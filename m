From: "Adrian McMenamin" <adrianmcmenamin@gmail.com>
Subject: Re: Getting a driver to work
Date: Mon, 20 Aug 2007 20:28:14 +0100
Message-ID: <92a12cdb0708201228v42dc2eb6n95fcb40fbb5fb11@mail.gmail.com>
References: <92a12cdb0708191646v66228fb3ucc90cdc7cb538f8c@mail.gmail.com>
	<s5hodh2ms2m.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.181])
	by alsa0.perex.cz (Postfix) with ESMTP id 54C5D244BE
	for <alsa-devel@alsa-project.org>;
	Mon, 20 Aug 2007 21:28:16 +0200 (CEST)
Received: by wa-out-1112.google.com with SMTP id m33so863574wag
	for <alsa-devel@alsa-project.org>; Mon, 20 Aug 2007 12:28:14 -0700 (PDT)
In-Reply-To: <s5hodh2ms2m.wl%tiwai@suse.de>
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

On 20/08/07, Takashi Iwai <tiwai@suse.de> wrote:
> At Mon, 20 Aug 2007 00:46:18 +0100,
> Adrian McMenamin wrote:
> >
> > Apologies for asking this old chestnut ... but I have upgraded my
> > busybox/buildroot setup on my Dreamcast and now the AICA driver fails
> > - looks pretty much like a failure to load the firmware. Information
> > on the internet seems rather mixed up and out of date - some of it
> > referring to 2.2 kernels etc...
> >
> > What is needed to load firmware - is it udev or hotplug (or is hotplug
> > obsolete), and what role do the alsa libs have in all this?
>
> ALSA lib plays nothing as long as you use the standard
> request_firmware().
>
I gave up and reverted to the old setup. Out of date version of
buildroot, but everything works :)
