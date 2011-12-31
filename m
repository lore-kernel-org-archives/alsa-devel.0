From: Felix Homann <linuxaudio@showlabor.de>
Subject: Re: [PATCH 0/6] snd-usb endpoint rework, version 6
Date: Sat, 31 Dec 2011 16:39:49 +0100
Message-ID: <CAFz=ag7kfJrs8aDA6HEM_oYfYbRN9C6miW3kOnpUTO--GPsyNQ@mail.gmail.com>
References: <1324656947-23169-1-git-send-email-zonque@gmail.com>
	<4EFDC32B.10808@gmail.com>
	<CAFz=ag41GGEB6X6AzZi9xshpQLUUuzqkd3qtjiFNEYAs=6N+qQ@mail.gmail.com>
	<CAE-xCyOC2dJUAZeR+Efm+1Yd7NehN0vUkix4rnhR-D59UEMAuA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f179.google.com (mail-wi0-f179.google.com
	[209.85.212.179])
	by alsa0.perex.cz (Postfix) with ESMTP id B4043243C2
	for <alsa-devel@alsa-project.org>; Sat, 31 Dec 2011 16:39:51 +0100 (CET)
Received: by wibhm4 with SMTP id hm4so7979940wib.38
	for <alsa-devel@alsa-project.org>; Sat, 31 Dec 2011 07:39:50 -0800 (PST)
In-Reply-To: <CAE-xCyOC2dJUAZeR+Efm+1Yd7NehN0vUkix4rnhR-D59UEMAuA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: =?ISO-8859-1?Q?Aur=E9lien_Leblond?= <blablack@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>, Grant Diffey <gdiffey@gmail.com>, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi Aur=E9lien,
2011/12/31 Aur=E9lien Leblond <blablack@gmail.com>:> Is this when using
the FTU or another USB device?
It's the FTU. I don't have any other USB audio devices here which I could t=
est.

> Would your USB device by any chance be of type USB 1, and the type of> th=
e USB port on your machine EHCI?
So, no, it's not a USB 1 device. But it's on a EHCI port.
Unfortunately, I can't test the patch on a different machine at
thistime. But I will try the same kernel without Daniel's patch set
assoon as possible.
Regards,
Felix
