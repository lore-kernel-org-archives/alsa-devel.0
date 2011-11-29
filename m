From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Kernel: snd-usb-audio: probe of 2-2:1.0 failed
 with error -5
Date: Tue, 29 Nov 2011 11:12:04 -0800
Message-ID: <CA+55aFwA5JxUn0_kWPt7R1zTbYHzi27gW9982RQtQEkiKRD86A@mail.gmail.com>
References: <4ED4D58D.60109@nixbits.org>
	<CA+55aFxjrCZTEzznjEK_FjadortNS9GPtcDH=D8-HebKKhQ8Bg@mail.gmail.com>
	<4ED51463.6050005@gmail.com> <4ED52DE4.4040507@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 08CDF2440F
	for <alsa-devel@alsa-project.org>; Tue, 29 Nov 2011 20:12:27 +0100 (CET)
Received: by eaai13 with SMTP id i13so3477261eaa.38
	for <alsa-devel@alsa-project.org>; Tue, 29 Nov 2011 11:12:26 -0800 (PST)
In-Reply-To: <4ED52DE4.4040507@ladisch.de>
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
Cc: Takashi Iwai <tiwai@suse.de>, admin@nixbits.org, alsa-devel@alsa-project.org, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 29, 2011 at 11:09 AM, Clemens Ladisch <clemens@ladisch.de> wrote:
>
> N.A., please try the patch below.

I don't think that will compile. At a minimum, there's a missing comma
there, afaik.

                    Linus
