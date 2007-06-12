From: "Dmitry Baikov" <dsbaikov@gmail.com>
Subject: Re: Source of timing for MIDI and/or audio
	synchronization
Date: Tue, 12 Jun 2007 16:23:40 +0400
Message-ID: <70a871c80706120523v7dddad08k1045114d35f4cc3c@mail.gmail.com>
References: <466E3A95.8070900@lumin.us>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.224])
	by alsa0.perex.cz (Postfix) with ESMTP id 81AA02458B
	for <alsa-devel@alsa-project.org>;
	Tue, 12 Jun 2007 14:23:42 +0200 (CEST)
Received: by wr-out-0506.google.com with SMTP id 58so1187161wri
	for <alsa-devel@alsa-project.org>; Tue, 12 Jun 2007 05:23:41 -0700 (PDT)
In-Reply-To: <466E3A95.8070900@lumin.us>
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
To: Mark Rivera <marr@lumin.us>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On 6/12/07, Mark Rivera <marr@lumin.us> wrote:
> I designed and built a MIDI sequencer based around a Microchip PIC18
> MCU, and used the built-in hardware timers and interrupt levels to drive
> the 'scheduler' for initiating MIDI output (EUSART) routines. In this
> same vein, I would like to write a software sequencer with as 'tight'
> timing as possible.
Man, join linux-audio-dev list, you'll be our god :)

> So, in a similar concept for Linux - from where does
> the timing of audio and MIDI events come from?
> It occurred to me that it would be nice to have a loadable kernel module
> (LKM) to which userland programs could subscribe for receiving 'soft
> interrupts' based on some timer (cpu ticks?) so that various software
It think you should look into hpet/rtc devices.

You also may be interested in jack and especially midi-over-jack
(which I, in fact, maintain).
It is an audio-sample-syncronous midi transport.
You may look into my jackmidi-driver for details about event timing.
I even hope you can help to make better :)

And I'm also very interested in writing a good sequencer.

Regards,
Dmitry.
