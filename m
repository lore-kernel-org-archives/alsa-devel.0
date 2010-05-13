From: pl bossart <bossart.nospam@gmail.com>
Subject: Re: [RFC] disabling ALSA period interrupts
Date: Wed, 12 May 2010 22:56:20 -0500
Message-ID: <AANLkTikNrfYqVmiDvnk7Uyg31hPm0qjH9B5LSLNh1Mb0@mail.gmail.com>
References: <h2l6160a5131004291538w6c7891fbn2db3425846aefd60@mail.gmail.com>
	<20100507232516.GB16910@tango.0pointer.de>
	<s2r6160a5131005072012o24609ce9q421ed2def04e4728@mail.gmail.com>
	<AANLkTimUaGy7NirNI78duHwGe3V72s_1eUiby_Rb_dRq@mail.gmail.com>
	<alpine.LNX.2.00.1005121452230.6856@eeebox2.perex-int.cz>
	<AANLkTilFAbNRyYFCX-gjAIkUSL01OyRyqNnbhu0Bb5bC@mail.gmail.com>
	<alpine.LNX.2.00.1005122012270.6856@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f179.google.com (mail-qy0-f179.google.com
	[209.85.221.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 985A110389D
	for <alsa-devel@alsa-project.org>;
	Thu, 13 May 2010 05:56:22 +0200 (CEST)
Received: by qyk9 with SMTP id 9so1044543qyk.2
	for <alsa-devel@alsa-project.org>; Wed, 12 May 2010 20:56:20 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.1005122012270.6856@eeebox2.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: General PulseAudio Discussion <pulseaudio-discuss@mail.0pointer.de>, ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

>> ok. It works just fine now. Can I send a patch against alsa-kmirror or
>> do you prefer against alsa-kernel? I use the former to recompile only
>> the audio modules.
>
> It does not matter. I accept both forms (the diffence between trees is
> minimal). Also, you can use alsa-driver with alsa-kernel trees too now (the
> latest gitcompile script in alsa-driver handles this option as well).

Good to know. I was using alsa-kmirror and alsa-driver with the
insert/remove scripts re-added. But this new option looks much better.
Will give it a try tomorrow.
