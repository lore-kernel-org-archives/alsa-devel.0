From: Daniel Mack <zonque@gmail.com>
Subject: Re: A plea for help on mixer support for Fast Track
 Ultra (8R)
Date: Fri, 20 May 2011 18:38:06 +0200
Message-ID: <BANLkTinAJ56dZmEcq0w_sTtU4ezY2UsZrQ@mail.gmail.com>
References: <4DD3E39D.30100@showlabor.de>
	<BANLkTinCn2Q+asKhGAoq+3S+AtqyHrg2wg@mail.gmail.com>
	<4DD413FC.2090808@showlabor.de>
	<BANLkTi=2NeMGL6n7B0n-2p9La=45pM7ZHg@mail.gmail.com>
	<s5hhb8r1c20.wl%tiwai@suse.de> <4DD4BC97.5090702@showlabor.de>
	<s5h39kb17bv.wl%tiwai@suse.de> <4DD4D162.20608@showlabor.de>
	<BANLkTi=6CHJyFxvk9eVA430uhiwJ7f86vA@mail.gmail.com>
	<BANLkTi=OsrZKq3ZmC5cdFfuWb7qSOkPitw@mail.gmail.com>
	<4DD51E38.7090406@showlabor.de>
	<BANLkTiksJbpMr61QOfJ26iVhETDhSBDRFA@mail.gmail.com>
	<4DD63E8F.2030306@showlabor.de> <4DD64D13.9070200@showlabor.de>
	<BANLkTik-_m-Anr2s5=+G7ksyCHdOEGfN2w@mail.gmail.com>
	<BANLkTik9LLnvZRXE=8LW2UOrOOVCjp+kDg@mail.gmail.com>
	<BANLkTimS+VrNTsicpJQ30En7cH68VTFOXQ@mail.gmail.com>
	<BANLkTikJRO-WGqo+F1P17DJ+-tMhwQpkeA@mail.gmail.com>
	<BANLkTimEV8y5Ri6D_tf_wJNCyGNcVFzBiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
	[209.85.160.51])
	by alsa0.perex.cz (Postfix) with ESMTP id BEF55103AB6
	for <alsa-devel@alsa-project.org>;
	Fri, 20 May 2011 18:38:09 +0200 (CEST)
Received: by pwi9 with SMTP id 9so2153473pwi.38
	for <alsa-devel@alsa-project.org>; Fri, 20 May 2011 09:38:06 -0700 (PDT)
In-Reply-To: <BANLkTimEV8y5Ri6D_tf_wJNCyGNcVFzBiw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Grant Diffey <gdiffey@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Felix Homann <linuxaudio@showlabor.de>
List-Id: alsa-devel@alsa-project.org

On Fri, May 20, 2011 at 6:25 PM, Grant Diffey <gdiffey@gmail.com> wrote:
> So the controls are created as expected and do something but not everythi=
ng
> I expect.
>
> So my test setup here.
> is inputs on analog 1, 2 and 5=A0 if I mute all the controls. that works.
>
> but in no setting of the controls can I get channel 5 to output to 1 and =
2.
> setting Ain5 -Out1 and Ain5-out2 does this on the earlier patch.
>
> so even with all the controls at 100% (this should pass every input to ev=
ery
> output simultaneously I can't hear the input on ch5 on the headphones.

Ok, that sound like Felix can fix this as he wrote the original patch.
Maybe something in my transition went wrong, but it's just much easier
to figure out what's wrong with access to the hardware :)

Daniel
