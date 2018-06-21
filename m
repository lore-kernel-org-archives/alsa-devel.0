From: Dennis Mungai <dmngaie@gmail.com>
Subject: The SPDIF light on the Eurocom Q6 (Clevo
	P95xER-series) is always on
Date: Fri, 22 Jun 2018 02:29:33 +0300
Message-ID: <CAKKYfmGwTxx2pArezdg7mdmH31-S+K0vP=67A+7T66Rg584hkQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-it0-f65.google.com (mail-it0-f65.google.com
 [209.85.214.65])
 by alsa0.perex.cz (Postfix) with ESMTP id C7B00267610
 for <alsa-devel@alsa-project.org>; Fri, 22 Jun 2018 01:30:15 +0200 (CEST)
Received: by mail-it0-f65.google.com with SMTP id v83-v6so439397itc.3
 for <alsa-devel@alsa-project.org>; Thu, 21 Jun 2018 16:30:15 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello there,

As stated in the subject, the SPDIF light on the machine is always on, and
this is only when I boot into Linux.

Output from alsa-info:
http://www.alsa-project.org/db/?f=29b57d6465130b92dd70360150aad528cfb85f92

I can get both the internal audio + headphone jack to work by editing
/usr/share/pulseaudio/alsa-mixer/paths/iec958-stereo-output.conf and adding:

[General]
description = Headphones + Digital Output (S/PDIF)

Infront of the

[Element IEC958]
switch = mute

section.

Other specifics:

lsb_release -a :

No LSB modules are available.
Distributor ID:    Ubuntu
Description:    Ubuntu 18.04 LTS
Release:    18.04
Codename:    bionic

pulseaudio --version :

pulseaudio 11.1

aplay --version :
aplay: version 1.1.3 by Jaroslav Kysela <perex@perex.cz>
