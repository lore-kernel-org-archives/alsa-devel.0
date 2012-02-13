From: =?ISO-8859-1?Q?Aur=E9lien_Leblond?= <blablack@gmail.com>
Subject: [PATCH 0/6] snd-usb endpoint rework, version 6
Date: Mon, 13 Feb 2012 20:41:44 +0000
Message-ID: <CAE-xCyPcVH-+JKg9m1oNy234LuFDXHSCPz3iaoWQ0Q02YV4JFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vx0-f179.google.com (mail-vx0-f179.google.com
	[209.85.220.179])
	by alsa0.perex.cz (Postfix) with ESMTP id D97FD103CD4
	for <alsa-devel@alsa-project.org>; Mon, 13 Feb 2012 21:41:46 +0100 (CET)
Received: by vcbf11 with SMTP id f11so3596507vcb.38
	for <alsa-devel@alsa-project.org>; Mon, 13 Feb 2012 12:41:44 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Daniel Mack <zonque@gmail.com>, Takashi Iwai <tiwai@suse.de>, Felix Homann <linuxaudio@showlabor.de>, Clemens Ladisch <clemens@ladisch.de>, Grant Diffey <gdiffey@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hello everyone,

My laptop has been in reparation for a while and I just got it back
now, so I have been out of sync with any update on the snd-usb module,
the support of the M-Audio Fast Track Ultra, and I now need to
re-setup my laptop.

As far as I can see, the kernel 3.2.5 doesn't have the update of Alsa
1.0.25, so the first thing I did was to compile those two separately
(compile first the kernel without any sound support, then compile and
install 1.0.25), but the midi was then not working on the M-Audio FTU,
the Roland UA-25Ex and my E-Mu USB keyboard. All modules are probed,
no messages in dmesg, but jack doesn't see any alsa midi driver.
In addition, I cannot make out if Daniel's changes are part of this
release of Alsa!

My next step was to get a git version of the kernel, add Takashi's
branch and Daniel's one on top of it (process I used to do 2 months
ago), but I get a conflicting error when pulling/merging Daniel's
patch, so I guess it is not in sync with the latest kernel anymore...

So my questions are:
- Did I do something wrong with the kernel 3.2.5/alsa 1.0.25 that
broke the USB Midi or is it a bug? I ran through the mailing list but
couldn't see anything mentionned about USB Midi. As far as I can tell,
I have all the necessary modules.
- What is the status of Daniel's work on the snd-usb module? Again I
ran through the changelog of alsa 1.0.25 but couldn't make out if it
was integrated or not.


So as usual, thanks in advance for your help and if there is anymore
information I can provide, please let me know.

Aur=E9lien
