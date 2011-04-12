From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: External microphone doesn't work on Thinkpad
	T410(i)
Date: Tue, 12 Apr 2011 20:50:57 +0800
Message-ID: <BANLkTikbXVptJDkM9Yc=NBcn+8LbnikugA@mail.gmail.com>
References: <4D9F8363.7040902@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 1DDA21037F2
	for <alsa-devel@alsa-project.org>;
	Tue, 12 Apr 2011 14:51:00 +0200 (CEST)
Received: by fxm5 with SMTP id 5so4906791fxm.38
	for <alsa-devel@alsa-project.org>; Tue, 12 Apr 2011 05:50:57 -0700 (PDT)
In-Reply-To: <4D9F8363.7040902@gmx.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2011/4/9 Hugo Estopendo <sido616@gmx.de>

> Hi there,
> my ThinkPad does not have 2 audio jacks, it has just one for speakers
> and microphone both, like a MacBook or Smartphone. It also has an
> internal mic under the screen.
> Normal audio playback works via the internal speakers and the jack both.
> The internal mic works, but when I plug a stereo headset with a mic
> included on this one jack, the internal mic is still used and the
> external mic is just ignored.
>
> I alread opened a bug report:
> https://bugtrack.alsa-project.org/alsa-bug/view.php?id=5325
>
> output of alsa information script:
>
>
> lspci output:
>
> https://bugtrack.alsa-project.org/alsa-bug/file_download.php?file_id=3522&type=bug
>
> Greetings, Hugo
>

Do you mean one combo jack for hp or ext mic ?

Do you mean hp auto mute speaker work ?


There are two [Pin complex] 0x1b and 0x1d which can be retasked as Input or
output

Node 0x1b [Pin Complex] wcaps 0x400581: Stereo
  Pincap 0x00011334: IN OUT EAPD Detect


Node 0x1d [Pin Complex] wcaps 0x400581: Stereo
  Pincap 0x00010034: IN OUT EAPD Detect



Does the user manual mention about  the speaker mute button or mic mute
button and thow the combo jack work  (e.g. auto detect hp or mic) ?
