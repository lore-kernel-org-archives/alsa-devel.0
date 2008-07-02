From: Wolfgang Rosenauer <wolfgang@rosenauer.org>
Subject: Re: Alsa 32-64 bit issue
Date: Wed, 02 Jul 2008 20:42:01 +0200
Message-ID: <486BCBF9.2090906@rosenauer.org>
References: <486B6B02.4020202@rosenauer.org> <s5h1w2ccwj4.wl%tiwai@suse.de>
	<486B7726.1040608@rosenauer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ds9.rosenauer.org (ds9.rosenauer.org [78.47.28.164])
	by alsa0.perex.cz (Postfix) with ESMTP id 218DA246D9
	for <alsa-devel@alsa-project.org>;
	Wed,  2 Jul 2008 20:42:04 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by ds9.rosenauer.org (Postfix) with ESMTP id 80B8A4C2EF
	for <alsa-devel@alsa-project.org>;
	Wed,  2 Jul 2008 20:42:02 +0200 (CEST)
Received: from ds9.rosenauer.org ([127.0.0.1])
	by localhost (78.47.28.164 [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DXz0J3SV3Zw9 for <alsa-devel@alsa-project.org>;
	Wed,  2 Jul 2008 20:42:02 +0200 (CEST)
Received: from [192.168.250.1] (p4FD03B64.dip0.t-ipconnect.de [79.208.59.100])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by ds9.rosenauer.org (Postfix) with ESMTP id 139344C2E9
	for <alsa-devel@alsa-project.org>;
	Wed,  2 Jul 2008 20:42:02 +0200 (CEST)
In-Reply-To: <486B7726.1040608@rosenauer.org>
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
List-Id: alsa-devel@alsa-project.org

Wolfgang Rosenauer wrote:
> Takashi Iwai wrote:
>>> I have an application which does simple PCM output to Alsa. It works so =

>>> far (if pulseaudio is not used but that's another issue).
>>> But if I try to run the app (which is compiled for 32bit) on a 64bit =

>>> Linux system it fails at snd_pcm_start() with the following error:
>>>
>>> "Daten=C3=BCbergabe unterbrochen (broken pipe)"
>> It means that no data is present on the buffer.

ok, I fixed that by not using snd_pcm_start() at all. Thanks for the hint.
I still have issues which I find pretty strange though:

The very same application binary always buffer underruns on my x86-64 =

system while it works (almost) perfectly (at least w/o buffer underruns) =

on my smaller i586 system.

Anyone can imagine what could cause that?

Thanks,
  Wolfgang
