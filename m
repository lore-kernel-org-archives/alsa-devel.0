From: Giovanni Maruzzelli <gmaruzz.lists@gmail.com>
Subject: Re: snd_dummy on Centos - Redhat
Date: Thu, 3 Sep 2009 16:22:36 +0200
Message-ID: <7c5010d60909030722n1b5e3e63k5e44aa8f44b49b69@mail.gmail.com>
References: <7c5010d60909020912k1b9b64bdsab2363c4762e8c5c@mail.gmail.com>
	<4A9E9CB7.8040809@ladisch.de>
	<7c5010d60909020933n47381069uacadd656aa98e8e8@mail.gmail.com>
	<4A9FAD82.3050207@ladisch.de>
	<7c5010d60909030529w7f226cc1s18c80f1eb0deab3a@mail.gmail.com>
	<4A9FBF37.6030106@ladisch.de>
	<7c5010d60909030612o70fa8ffey21b358713ae284d2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f225.google.com (mail-bw0-f225.google.com
	[209.85.218.225])
	by alsa0.perex.cz (Postfix) with ESMTP id 5D9402456D
	for <alsa-devel@alsa-project.org>;
	Thu,  3 Sep 2009 16:22:37 +0200 (CEST)
Received: by bwz25 with SMTP id 25so1583103bwz.32
	for <alsa-devel@alsa-project.org>; Thu, 03 Sep 2009 07:22:36 -0700 (PDT)
In-Reply-To: <7c5010d60909030612o70fa8ffey21b358713ae284d2@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 3, 2009 at 3:12 PM, Giovanni
Maruzzelli<gmaruzz.lists@gmail.com> wrote:
> On Thu, Sep 3, 2009 at 3:05 PM, Clemens Ladisch<clemens@ladisch.de> wrote:
>> It would be easier to try to change the constraints of the sound card
>> that snd-dummy tries to emulate; set USE_PERIODS_MIN to four or so,
>> and increase period_bytes_min to some value that is at least as large
>> as the numer of bytes per timer tick (with 2 channels and 16 bits at
>> 48 kHz, there are 192000 bytes per second).
>>

I put a printk that prints the contents of runtime struct at the last
line of the snd_card_dummy_pcm_prepare() function, so to know how
Skype client uses the soundcard.

The result are:
Sep  3 16:11:04 localhost kernel: 253, cicopet1 rate=16000 channels=2,
period_size=2048, periods=2, buffer_size=4096,
timer_resolution=128000000
Sep  3 16:17:42 localhost kernel: 253, cicopet1 rate=16000 channels=2,
period_size=2048, periods=2, buffer_size=4096,
timer_resolution=128000000
Sep  3 16:17:42 localhost kernel: 253, cicopet1 rate=16000 channels=2,
period_size=2048, periods=2, buffer_size=4096,
timer_resolution=128000000
Sep  3 16:17:42 localhost kernel: 253, cicopet1 rate=16000 channels=1,
period_size=2048, periods=2, buffer_size=4096,
timer_resolution=128000000
Sep  3 16:17:42 localhost kernel: 253, cicopet1 rate=16000 channels=1,
period_size=2048, periods=2, buffer_size=4096,
timer_resolution=128000000

So, it seems that it opens 2 channels for playback and one channel for
capture, at 16k

What's the best values for constraints you counseil?

-giovanni
