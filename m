From: Felix Homann <linuxaudio@showlabor.de>
Subject: Fast Track Ultra (8R): Sync source switch
Date: Fri, 20 Apr 2012 10:49:22 +0200
Message-ID: <CAFz=ag6Lqfu1+Pzm++Auc8gfuWaUVDHZEtQQitjeVu7=62DYUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f179.google.com (mail-lb0-f179.google.com
	[209.85.217.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 1D115103D27
	for <alsa-devel@alsa-project.org>;
	Fri, 20 Apr 2012 10:49:24 +0200 (CEST)
Received: by lban1 with SMTP id n1so3730793lba.38
	for <alsa-devel@alsa-project.org>; Fri, 20 Apr 2012 01:49:22 -0700 (PDT)
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
Cc: =?ISO-8859-1?Q?Aur=E9lien_Leblond?= <blablack@gmail.com>, alsa-devel@alsa-project.org, Grant Diffey <gdiffey@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi,

I've taken a look again at the usbmon logs I posted some years ago.

It seems that by switching the sync source you essentially tell the
FTU to use a different altsetting for iface 2:

Switching  "Sync Source" from "Internal" to "External" (see last line):

         ffff8800662a60c0 3325542111 S Co:1:006:0 s 01 0b 0000 0001 0000 0
         ffff8800662a60c0 3325543386 C Co:1:006:0 0 0
         ffff88009159e740 3325594872 S Co:1:006:0 s 01 0b 0000 0002 0000 0
         ffff88009159e740 3325596263 C Co:1:006:0 0 0
         ffff8800a00d0900 3325633405 S Co:1:006:0 s 01 0b 0001 0001 0000 0
         ffff8800a00d0900 3325633637 C Co:1:006:0 0 0
         ffff88009159e440 3325644251 S Co:1:006:0 s 01 0b 0002 0002 0000 0

Switching "Sync Source" from "External" to "Internal" (see last line):

     ffff8800a00d0480 3349133460 S Co:1:006:0 s 01 0b 0000 0001 0000 0
     ffff8800a00d0480 3349134696 C Co:1:006:0 0 0
     ffff88009159e740 3349186489 S Co:1:006:0 s 01 0b 0000 0002 0000 0
     ffff88009159e740 3349187696 C Co:1:006:0 0 0
     ffff88009159e440 3349239544 S Co:1:006:0 s 01 0b 0001 0001 0000 0
     ffff88009159e440 3349239823 C Co:1:006:0 0 0
     ffff8800a00d0900 3349255385 S Co:1:006:0 s 01 0b 0001 0002 0000 0


If I haven't missed something we can achieve this by adding a quirk
hook to either find_format() or set_format() in pcm.c.

Daniel, can you think of a generic way to do this?

(Note to all: can't test anything on this topic because I don't have a
S/PDIF device here.)

BTW, has anybody tested the mixer patch I posted a couple of days ago?

Regards,

Felix
