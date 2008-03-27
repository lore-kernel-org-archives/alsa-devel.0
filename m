From: "Avuton Olrich" <avuton@gmail.com>
Subject: Re: USB sound card fails to resume from hibernation
	due to duplicate filename card1/WARNING: sysfs_add_ons,
	emits symbols
Date: Thu, 27 Mar 2008 15:35:23 -0700
Message-ID: <3aa654a40803271535r35faf44cg6f34dd25e6c369f4@mail.gmail.com>
References: <3aa654a40803192339i4a663729k205a462740464f76@mail.gmail.com>
	<s5htzj1tyib.wl%tiwai@suse.de>
	<3aa654a40803200747j50570aa1y1f9690b7348cc3a0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.248])
	by alsa0.perex.cz (Postfix) with ESMTP id EA72524648
	for <alsa-devel@alsa-project.org>; Thu, 27 Mar 2008 23:35:36 +0100 (CET)
Received: by an-out-0708.google.com with SMTP id c36so175865ana.80
	for <alsa-devel@alsa-project.org>; Thu, 27 Mar 2008 15:35:23 -0700 (PDT)
In-Reply-To: <3aa654a40803200747j50570aa1y1f9690b7348cc3a0@mail.gmail.com>
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
Cc: Alsa-Devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Mar 20, 2008 at 7:47 AM, Avuton Olrich <avuton@gmail.com> wrote:
> On Thu, Mar 20, 2008 at 4:39 AM, Takashi Iwai <tiwai@suse.de> wrote:
>  > At Wed, 19 Mar 2008 23:39:28 -0700,
>  >
>  > Avuton Olrich wrote:
>  >  >
>  >  > After suspending, the usbdisk sound card alsa driver breaks and does
>  >  > not play any further. I believe this is might be due to the trace
>  >  > below from the dmesg.
>  >  >
>  >  > This definitely begins to occur between v2.6.23 and v2.6.23-rc2. I
>
>  BTW- honest mistake, it was v2.6.24-rc2.
>
>
>  >  > couldn't bisect it down to a single commit.
>  >  >
>  >  > This fails with with all kernels up to at least today's git.
>  >
>  >  Could you try my git tree and check whether the same problem happens?
>  >         git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-unstable-2.6.git
>
>  Yes, it now works, but now something is causing Pulseaudio to crash. I
>  believe it's due to the fact that the alsa output name is changing now
>  after hibernate.
>
>  When the computer initally starts the ALSA device name for this usbdisk is:
>  usb_device_d8c_c_noserial_if0_sound_card_0_alsa_playback_0
>
>  Then it turns into this after hibernation:
>  usb_device_ffffffff_ffffffff_noserial_0_sound_card_0_alsa_playback_0

Any information about this problem? It's been a week and this makes
audio device management really difficult if I intend to use suspend.
-- 
avuton
--
 Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
