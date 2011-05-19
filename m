From: Felix Homann <linuxaudio@showlabor.de>
Subject: Re: A plea for help on mixer support for Fast Track
 Ultra (8R)
Date: Thu, 19 May 2011 15:42:16 +0200
Message-ID: <4DD51E38.7090406@showlabor.de>
References: <4DD3E39D.30100@showlabor.de>	<BANLkTinCn2Q+asKhGAoq+3S+AtqyHrg2wg@mail.gmail.com>	<4DD413FC.2090808@showlabor.de>	<BANLkTi=2NeMGL6n7B0n-2p9La=45pM7ZHg@mail.gmail.com>	<s5hhb8r1c20.wl%tiwai@suse.de>
	<4DD4BC97.5090702@showlabor.de>	<s5h39kb17bv.wl%tiwai@suse.de>
	<4DD4D162.20608@showlabor.de>	<BANLkTi=6CHJyFxvk9eVA430uhiwJ7f86vA@mail.gmail.com>
	<BANLkTi=OsrZKq3ZmC5cdFfuWb7qSOkPitw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vwp5738.webpack.hosteurope.de (vwp5738.webpack.hosteurope.de
	[83.169.30.203])
	by alsa0.perex.cz (Postfix) with ESMTP id 1F127103A49
	for <alsa-devel@alsa-project.org>;
	Thu, 19 May 2011 15:42:20 +0200 (CEST)
In-Reply-To: <BANLkTi=OsrZKq3ZmC5cdFfuWb7qSOkPitw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Grant Diffey <gdiffey@gmail.com>
List-Id: alsa-devel@alsa-project.org

One more note:

You call snd_usb_create_mixer(mixer->chip, 0, 0) from 
snd_maudio_ftu_create_mixer() to create standard mixers first. There are 
no standard mixers on this device.

Regards,

Felix
