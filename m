From: Grzegorz Chwesewicz <grzegorz.chwesewicz@chilan.com>
Subject: Re: snd-hda-intel AD1981 - the microphone doesn't work
Date: Tue, 19 Feb 2008 15:12:50 +0100
Message-ID: <200802191512.50604.grzegorz.chwesewicz@chilan.com>
References: <47B1D340.4070907@gmail.com> <47B364D2.3020400@gmail.com>
	<s5hlk5nybtx.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.chilan.com (mail.chilan.com [82.160.213.101])
	by alsa0.perex.cz (Postfix) with ESMTP id CA207103929
	for <alsa-devel@alsa-project.org>; Tue, 19 Feb 2008 15:12:58 +0100 (CET)
In-Reply-To: <s5hlk5nybtx.wl%tiwai@suse.de>
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
Cc: Takashi Iwai <tiwai@suse.de>, chilek@chilan.com
List-Id: alsa-devel@alsa-project.org

Thursday 14 of February 2008 13:14:18 Takashi Iwai napisa=B3(a):
> And, does a similar problem like Grzegorz's case occur on your laptop?
> Some HP laptops (so far, AMD SB450-based) occasionally cause a hang-up
> during recording from the mic when HD is accessed.  This is far more
> nasty problem, and it's interesting to know whether this happens on
> other chipset.

	Hi Takashi. I've experimented a little with power saving in HD Intel Audio=
. =

I've noticed that using power saving with timeout set to 10 sec. solves my =

problem partially. When arecord stops recording I can turn it off, wait 10 =

seconds, and recording works back again. This is obvious, because power =

saving simply powers off and on device. I was wondering that maybe we can =

implement ioctl or something that will dump "state" (informations that will =

help in debuging) of device, when recording is not working, and "state" jus=
t =

after power on to compare what causes breakage ? Can you give me some tips =

about what informations are userful in debuging ?

-- =

Greetings
Grzegorz Chwesewicz, Chilan =

mailto:grzegorz.chwesewicz@chilan.com
