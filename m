From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: Fwd: surround51 lfe/center/front channel
 cross-talk with intel8x0 board
Date: Tue, 15 Jan 2008 10:13:47 +0100
Message-ID: <1200388427.20323.1231298919@webmail.messagingengine.com>
References: <975d09800801042220v5efde614g8ccc18a5f59b0e82@mail.gmail.com>
	<975d09800801141311v14debf13g79e83e6aa2d0c95@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id EE1352474F
	for <alsa-devel@alsa-project.org>; Tue, 15 Jan 2008 10:13:48 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <975d09800801141311v14debf13g79e83e6aa2d0c95@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Matt Hirsch <matthew.hirsch@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Matt Hirsch wrote:
> I have an AC'97 based onboard sound card in my system (snd_intel8x0
> driver). I'm using it in 6ch mode to drive two front speakers, two
> rear speakers and a subwoofer and center channel. Using speaker-test
> with the surround51 plug (or any other alsa program with that plug) to
> send audio to channel 5 (center in alsamixer) produces an attenuated
> signal on channel 2 (right front in alsamixer) and likewise, sending
> audio to channel 6 (lfe in alsamixer) produces an attenuated signal on
> channel 1 (left front in alsamixer).

This looks like a flaw in your hardware.

What codec are you using? (see /proc/asound/cards)


Regards,
Clemens
