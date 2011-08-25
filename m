From: Daniel Mack <zonque@gmail.com>
Subject: Re: How to add a new MIDI device to the usbaudio driver
Date: Thu, 25 Aug 2011 14:38:27 +0200
Message-ID: <CACTFLAOgoOdd9Y8fQGvLXjUntzwsMDN7KYtftExGCHeU8jMeHw@mail.gmail.com>
References: <4E5234F0.8000502@amlie.name>
	<CACTFLAMA08qqaNALA1dksxVN_yAwXnONxXadeuUb1Owkz6VwsA@mail.gmail.com>
	<4E52401C.8030605@amlie.name> <4E537524.9010303@ladisch.de>
	<4E537BE9.4050004@amlie.name>
	<CACTFLAPzug5yxmhxDKocdLt-eoHXr6nOwmyOqWkEJ_vjqNff6w@mail.gmail.com>
	<4E53959A.7090702@amlie.name>
	<CACTFLAMh2Brji5NBOZjtDmyP-DPR3S4HCP93SO0sE9J7xEn3NQ@mail.gmail.com>
	<4E53A748.4070404@amlie.name>
	<CACTFLANSwy66KAyLbxyy=pB9Z+K+r7ur564Frx7ep1W_JY=XCQ@mail.gmail.com>
	<4E53AAE4.2070303@amlie.name>
	<CACTFLANav3woJuXjdpsYEqvvbbTb53S0d2MtVoq9EByv-j-cxw@mail.gmail.com>
	<4E555646.2030209@ladisch.de> <4E5631E1.7050400@amlie.name>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f43.google.com (mail-pz0-f43.google.com
	[209.85.210.43]) by alsa0.perex.cz (Postfix) with ESMTP id 03CE924560
	for <alsa-devel@alsa-project.org>;
	Thu, 25 Aug 2011 14:38:28 +0200 (CEST)
Received: by pzk1 with SMTP id 1so2572355pzk.2
	for <alsa-devel@alsa-project.org>; Thu, 25 Aug 2011 05:38:27 -0700 (PDT)
In-Reply-To: <4E5631E1.7050400@amlie.name>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kristian Amlie <kristian@amlie.name>
Cc: alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

On Thu, Aug 25, 2011 at 1:28 PM, Kristian Amlie <kristian@amlie.name> wrote:
> One caveat I have discovered with the patch: If you keep the instrument
> plugged in, but reload the driver, then the driver gets out of sync with
> the MIDI messages and won't report any. This seems to be because, in the
> stream, the message type is cached and subsequent messages do not report
> what type of message they are unless they are switching to a new type
> (going from control message to note message, for example). You can reset
> the stream by manually generating MIDI messages of different types (turn
> the volume knob while pressing a few notes), or eventually the
> instrument will reset itself and send the type anyway. So it's not
> critical, but would be nice to fix. I'm not sure how to solve it though...

What you're seeing here is a general problem of the MIDI protocol that
cannot be fixed. If a receiver misses the running state update, it
can't do anything but wait for the next one.


Daniel
