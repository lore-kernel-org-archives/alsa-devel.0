From: "Josh Litherland" <josh@temp123.org>
Subject: Re: Userspace drivers
Date: Thu, 27 Sep 2007 10:06:00 -0400
Message-ID: <6cc714350709270706s6773351fpa4ff9f8774c9d228@mail.gmail.com>
References: <6cc714350709261228v519ab4dcx657969fd07f022b0@mail.gmail.com>
	<1190856930.30667.122.camel@razman.gruemaster.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.178])
	by alsa0.perex.cz (Postfix) with ESMTP id 9D3D72449C
	for <alsa-devel@alsa-project.org>;
	Thu, 27 Sep 2007 16:06:05 +0200 (CEST)
Received: by py-out-1112.google.com with SMTP id u77so4829527pyb
	for <alsa-devel@alsa-project.org>; Thu, 27 Sep 2007 07:06:03 -0700 (PDT)
In-Reply-To: <1190856930.30667.122.camel@razman.gruemaster.com>
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
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 9/26/07, Tobin Davis <tdavis@dsl-only.net> wrote:
>
>
> The volume buttons should be supported by either acpi controls or keyboard
> settings.  Try running showkey and seeing if they trigger keycodes.  Once
> you have those, you could map them to a macro that adjusts volume through
> amixer.  I know that there are applets for KDE to support the thinkpad keys,
> there may be others as well.
>


It's true; in particular, in Ubuntu, the thinkpad-keys binary from the
hotkey-setup package watches for these key-events, and connects as a
userspace input device to synthesize normal volumeup, volumedown and mute
key events.

Unfortunately, that's not really how  thinkpads work.   =(   They are fairly
unique in that the hardware volume buttons actually control a separate
hardware mixer independent of the sound chip itself, and there is no way
I've seen in open source to prevent them from controlling that phantom
mixer.  So mapping them to also control the sound card's master mixer will
eventually lead to a skew from expected results.

The phantom mixer can, however, be queried and changed through /dev/nvram
and, in recent kernels, in /proc/acpi/ibm and some knobs in /sys.  What I'm
proposing is to expose the phantom mixer as an alsa mixer device.



> -- Tobin Davis
>
> Today's weirdness is tomorrow's reason why.
> 		-- Hunter S. Thompson
>
>


-- 
Josh Litherland (josh@temp123.org)
