From: Daniel Mack <zonque@gmail.com>
Subject: Re: USB Audio questions
Date: Mon, 15 Aug 2011 22:55:55 +0200
Message-ID: <CACTFLAPU_ErpoQgTVoaOsXd2LM-sjeJq0E6wVN9C1RmYMvb02w@mail.gmail.com>
References: <1313432124-22591-1-git-send-email-lars@metafoo.de>
	<1313432124-22591-2-git-send-email-lars@metafoo.de>
	<4e498227.854fdf0a.0dd4.6281SMTPIN_ADDED@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f43.google.com (mail-pz0-f43.google.com
	[209.85.210.43]) by alsa0.perex.cz (Postfix) with ESMTP id A89D224353
	for <alsa-devel@alsa-project.org>;
	Mon, 15 Aug 2011 22:55:56 +0200 (CEST)
Received: by pzk1 with SMTP id 1so3727316pzk.2
	for <alsa-devel@alsa-project.org>; Mon, 15 Aug 2011 13:55:55 -0700 (PDT)
In-Reply-To: <4e498227.854fdf0a.0dd4.6281SMTPIN_ADDED@mx.google.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Sarah Sharp <sarah.a.sharp@linux.intel.com>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

On Mon, Aug 15, 2011 at 10:31 PM, Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:
> I am trying to prototype an application where the key requirement is
> playback with minimal power on USB audio accessories while maintaining tight
> synchronization with video. With the default ALSA USB code, I am getting
> ~130 interrupts/s due to audio, a fairly high CPU load and a very poor sync,
> exactly the opposite of my goals...
> After a careful analysis of the code I found a couple of issues where the
> help of experts would be welcome:
>
> - Is there any good reason why the max number of packets per urb defaults to
> 8? This end-ups being the root cause for the large number of interrupts. My
> headset supports up to 192 bytes/packet, that means 1536 bytes/urb and 125
> interrupts/s. Using more packets/urb results in a linear decrease of the
> interrupt rate.

You cannot use more than 8 subframes per ISO urb, that's what how USB
is designed. What exactly did you do in you test? Did you increase
MAX_URBS?

> - Increasing the number of packets/urbs solves my power issue but not the
> synchronization issue. If I reduce the number of urbs to reduce the
> interrupt rate, then the accuracy of the hw_pointer is decreased big time
> and it becomes difficult to synchronize with video. The .pointer routine
> only keeps track of retired urbs, it seems there's no way to know how many
> samples were played at a given time? It also makes pulseaudio behave
> somewhat strangely since the driver only provides an approximate position.
> In the CAIQ driver code, the .pointer routine seems to rely on a direct
> register read, a more efficient way to do things. Isn't there a direct way
> to query the usb core to know how many bytes have been transmitted and make
> the hw_ptr/delay information independent of the urb buffer size?

Just to be sure - you're talking about the driver in sound/usb/caiaq,
right? After a short comparison, I'd say both the caiaq driver and the
generic driver do more or less the same in regard to the .pointer
value, as for the output stream, they both increase their internal
counter when the packet is prepared, shortly before it is submitted to
the host controller. Increasing the number of URBs. Admittedly, this
approach is questionable, as a larger number of prepared output
buffers will actually cause the client believe that more data has
already been written already. You could try moving the hwptr_done
increase statement into the retire callback (which is the first place
we get to know about packets that have been sent to the device)?

> - Is there any reason why the driver relies on vmalloc and memcpy? It seems
> like using physically-contiguous memory would be more efficient, as done in
> the CAIQ driver? I hacked something to use prealloc_pages/malloc_pages and
> things seem to work fine.

Can you show a patch?


Daniel
