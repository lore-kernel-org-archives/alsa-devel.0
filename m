From: "Pierre-Louis Bossart" <pierre-louis.bossart@linux.intel.com>
Subject: USB Audio questions
Date: Mon, 15 Aug 2011 15:31:19 -0500
Message-ID: <26649.1859023974$1313440296@news.gmane.org>
References: <1313432124-22591-1-git-send-email-lars@metafoo.de>
	<1313432124-22591-2-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by alsa0.perex.cz (Postfix) with ESMTP id 500F42415A
	for <alsa-devel@alsa-project.org>;
	Mon, 15 Aug 2011 22:31:24 +0200 (CEST)
In-Reply-To: <1313432124-22591-2-git-send-email-lars@metafoo.de>
Content-Language: en-us
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: 'ALSA Development Mailing List' <alsa-devel@alsa-project.org>
Cc: 'Sarah Sharp' <sarah.a.sharp@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Hi USB Audio experts,
I am trying to prototype an application where the key requirement is
playback with minimal power on USB audio accessories while maintaining tight
synchronization with video. With the default ALSA USB code, I am getting
~130 interrupts/s due to audio, a fairly high CPU load and a very poor sync,
exactly the opposite of my goals...
After a careful analysis of the code I found a couple of issues where the
help of experts would be welcome:

- Is there any good reason why the max number of packets per urb defaults to
8? This end-ups being the root cause for the large number of interrupts. My
headset supports up to 192 bytes/packet, that means 1536 bytes/urb and 125
interrupts/s. Using more packets/urb results in a linear decrease of the
interrupt rate.

- Increasing the number of packets/urbs solves my power issue but not the
synchronization issue. If I reduce the number of urbs to reduce the
interrupt rate, then the accuracy of the hw_pointer is decreased big time
and it becomes difficult to synchronize with video. The .pointer routine
only keeps track of retired urbs, it seems there's no way to know how many
samples were played at a given time? It also makes pulseaudio behave
somewhat strangely since the driver only provides an approximate position.
In the CAIQ driver code, the .pointer routine seems to rely on a direct
register read, a more efficient way to do things. Isn't there a direct way
to query the usb core to know how many bytes have been transmitted and make
the hw_ptr/delay information independent of the urb buffer size?

- Is there any reason why the driver relies on vmalloc and memcpy? It seems
like using physically-contiguous memory would be more efficient, as done in
the CAIQ driver? I hacked something to use prealloc_pages/malloc_pages and
things seem to work fine.

- The period information is not updated when the urbs are allocated. In my
case the period specified was 25ms, but with all the approximations the
actual period (number of urbs*buffer_size_per_urb) was 24ms. In short
there's a discrepancy between what is known to the application, what is used
by the driver and the actual rate of period_elapsed events.

Thanks,
-Pierre
