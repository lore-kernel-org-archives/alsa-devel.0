From: "Andrew Paprocki" <andrew@ishiboo.com>
Subject: Re: [PATCH] ALSA: update the Kconfig files to be
	easier to use
Date: Sat, 23 Feb 2008 12:04:01 -0500
Message-ID: <76366b180802230904j9316ed2v889ec2de253664c5@mail.gmail.com>
References: <a60a39d8e6feb80702ce.1203746806@am2>
	<s5hlk5c9ccf.wl%tiwai@suse.de>
	<76366b180802230752u3ec33e9av9961d45fce1ca54d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.191])
	by alsa0.perex.cz (Postfix) with ESMTP id DF704243EF
	for <alsa-devel@alsa-project.org>; Sat, 23 Feb 2008 18:04:03 +0100 (CET)
Received: by rv-out-0910.google.com with SMTP id k20so588367rvb.32
	for <alsa-devel@alsa-project.org>; Sat, 23 Feb 2008 09:04:01 -0800 (PST)
In-Reply-To: <76366b180802230752u3ec33e9av9961d45fce1ca54d@mail.gmail.com>
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

To respond better, I'd actually prefer not putting 'default y', but I
figured it was more important to stay compatible with existing
configs. If you feel that isn't a big deal, then it can be removed.
The default in these cases should do no harm because it doesn't
actually enable any code.

On Sat, Feb 23, 2008 at 10:52 AM, Andrew Paprocki <andrew@ishiboo.com> wrote:
> Yes, I realized that and I made the new toplevel options default y so
>  that it would mimic the existing config. The main reason for doing
>  this is so that I can quickly 'n' to shut off things like "ISA
>  devices" with one key. I believe I got them all, but please verify.
>
>  Thanks,
>  -Andrew
>
>
>
>  On Sat, Feb 23, 2008 at 5:49 AM, Takashi Iwai <tiwai@suse.de> wrote:
>  > At Sat, 23 Feb 2008 01:06:46 -0400,
>  >
>  > Andrew Paprocki wrote:
>  >  >
>  >  > This update to the Kconfig files allows the ability to select/deselect
>  >  > entire submenus, starting with the root "Sound device support" on the main
>  >  > kernel configuration page. Inside sound support, ALSA/OSS can be easily
>  >  > enabled/disabled. Inside ALSA, entire classes of devices can be easily
>  >  > enabled/disabled at the ALSA menu (e.g. ISA, PCI, USB devices) without
>  >  > having to manually disable individual cards within the submenus.
>  >  > Modified menus: main, isa, pci, pcmcia, soc, spi, usb
>  >
>  >  A problem I found at the last time from a similar patch is that the
>  >  replacement with menuconfig throws away the old configuration unless
>  >  you have "default y".  And people are picky about "default y"...
>  >
>  >  I need to check this again, anyway.
>  >
>  >
>  >  thanks,
>  >
>  >  Takashi
>  >
>  >
>
