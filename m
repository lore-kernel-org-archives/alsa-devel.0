From: "Matt Mullins" <mokomull@gmail.com>
Subject: Re: Fwd: Problems with hda_intel, Santa Rosa,
	and suspend
Date: Wed, 4 Jul 2007 15:37:22 -0500
Message-ID: <dfd4051f0707041337m276d5536r6c65fd6d29463f39@mail.gmail.com>
References: <dfd4051f0706161836xa191176ke10deff2868ad8d6@mail.gmail.com>
	<s5h1wg8i56k.wl%tiwai@suse.de>
	<dfd4051f0706191354i679c5b82pd8d788dfb012df3d@mail.gmail.com>
	<s5hvedjaq66.wl%tiwai@suse.de>
	<dfd4051f0706201418o4d19a1f2g78081b052e8766e4@mail.gmail.com>
	<s5hd4zpa9d9.wl%tiwai@suse.de>
	<dfd4051f0706221331r681503d7h9d755bd91750a8ec@mail.gmail.com>
	<s5hejk0ibhj.wl%tiwai@suse.de>
	<dfd4051f0706251316uf265b3dw9c069dc5f75ceedf@mail.gmail.com>
	<s5hsl8deffy.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.169])
	by alsa0.perex.cz (Postfix) with ESMTP id 626CE244D7
	for <alsa-devel@alsa-project.org>;
	Wed,  4 Jul 2007 22:37:23 +0200 (CEST)
Received: by ug-out-1314.google.com with SMTP id h2so360251ugf
	for <alsa-devel@alsa-project.org>; Wed, 04 Jul 2007 13:37:22 -0700 (PDT)
In-Reply-To: <s5hsl8deffy.wl%tiwai@suse.de>
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

On a whim, I decided to extract the sound/pci/hda from vanilla 2.6.20
kernel sources and compile it under 2.6.22-rc5 (yes, I know, I
probably shouldn't have done that).  I had to add a typedef to
patch_sigmatel.c to get it to compile.  When I loaded the modules, I
did *not* get the "switching to single_cmd" error, but I haven't
gotten sound yet, either, probably because I'm using pieces of two
different versions of ALSA.  However, this suggests to me that perhaps
there is a problem with the hda_intel driver, and not necessarily an
ACPI problem.

I'm going to keep working on this, as much as I can understand right now.
