From: Giovanni Maruzzelli <gmaruzz.lists@gmail.com>
Subject: Re: snd_dummy on Centos - Redhat
Date: Thu, 3 Sep 2009 15:12:17 +0200
Message-ID: <7c5010d60909030612o70fa8ffey21b358713ae284d2@mail.gmail.com>
References: <7c5010d60909020912k1b9b64bdsab2363c4762e8c5c@mail.gmail.com>
	<4A9E9CB7.8040809@ladisch.de>
	<7c5010d60909020933n47381069uacadd656aa98e8e8@mail.gmail.com>
	<4A9FAD82.3050207@ladisch.de>
	<7c5010d60909030529w7f226cc1s18c80f1eb0deab3a@mail.gmail.com>
	<4A9FBF37.6030106@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f225.google.com (mail-bw0-f225.google.com
	[209.85.218.225])
	by alsa0.perex.cz (Postfix) with ESMTP id CAB0E10382F
	for <alsa-devel@alsa-project.org>;
	Thu,  3 Sep 2009 15:12:23 +0200 (CEST)
Received: by bwz25 with SMTP id 25so1523126bwz.32
	for <alsa-devel@alsa-project.org>; Thu, 03 Sep 2009 06:12:22 -0700 (PDT)
In-Reply-To: <4A9FBF37.6030106@ladisch.de>
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

On Thu, Sep 3, 2009 at 3:05 PM, Clemens Ladisch<clemens@ladisch.de> wrote:
>
> The interrupts of other drivers are based on the PCM stream clock, but
> the snd-dummy driver has to emulate interrupts using the system timer,
> so it is the only one affected by timer-related changes.

ok, got it

>
> The driver relies on the kernel's system timer. =A0It might be possible
> to rewrite it to use high-resolution timers, if the CentOS kernels
> supports it.

I'll have a look into it

>
> It would be easier to try to change the constraints of the sound card
> that snd-dummy tries to emulate; set USE_PERIODS_MIN to four or so,
> and increase period_bytes_min to some value that is at least as large
> as the numer of bytes per timer tick (with 2 channels and 16 bits at
> 48 kHz, there are 192000 bytes per second).
>

I'll have a look into this and then I'll report here.

Clemens, thanks for your help!

-giovanni
