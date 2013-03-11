From: Dave Helstroom <helstroom@google.com>
Subject: Re: [PATCH][RESEND] Add a USB audio quirk for the NuForce UDH-100 device.
Date: Mon, 11 Mar 2013 16:58:51 -0700
Message-ID: <CAOcFWmaMxMwFDuWA4tHPUEeOvGT+QtFvHYHe7wk5jzUEWm0VPQ@mail.gmail.com>
References: <1362973920-4942-1-git-send-email-helstroom@google.com>
	<513D968C.1060905@ladisch.de>
	<CAOcFWma6fMqwqzMxFfCM7hOqk04FBk9JkKZjwekki_GFUR2jSQ@mail.gmail.com>
	<513E2D56.8070902@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <513E2D56.8070902@ladisch.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: perex@perex.cz, tiwai@suse.de, eldad@fogrefinery.com, damien@zamaudio.com, Pete Leigh <pete.leigh@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 11 March 2013 12:15, Clemens Ladisch <clemens@ladisch.de> wrote:
>
> >> David Helstroom wrote:
> >>> Interface 1 does not exist
>
> Please try the patch below.

This works great for me -- thanks a lot!

My only suggestion (from a kernel newbie so feel free to ignore),
would be that it might be worthwhile even walking the entire set of
ifaces in case some other firmware decides to put the IAD even further
down the interface list. However you're obviously much better placed
as to the likelihood/worth of that occurring. Thanks again!
