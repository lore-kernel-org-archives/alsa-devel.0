From: "Christopher K." <c.krooss@gmail.com>
Subject: Conexant CX20588 in Acer 3830TG fix for internal mic
	amps
Date: Sat, 28 Dec 2013 23:56:52 +0100
Message-ID: <CAHQjNr_=Vc29MqGD4Nygw7LZEobtTq==fs8_6=gL50Y7Y9j+Sw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qe0-f43.google.com (mail-qe0-f43.google.com
 [209.85.128.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 7371E2610B4
 for <alsa-devel@alsa-project.org>; Sat, 28 Dec 2013 23:56:53 +0100 (CET)
Received: by mail-qe0-f43.google.com with SMTP id jy17so10152696qeb.16
 for <alsa-devel@alsa-project.org>; Sat, 28 Dec 2013 14:56:52 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Hi,

the internal mic in my notebook does not work (has never worked with
pulse) with the default driver settings. Setting Node 0x23 (internal
mic boost volume) from

Amp-In vals: [0x03 0x03]
to
Amp-In vals: [0x02 0x00]

makes it work in Skype and shows peaks in pulseaudio.
I have no idea what these numbers represent, but apparently it doesn't
work if they're the same.
Is there any way to figure out what this does and which settings are correct?

Info: http://www.alsa-project.org/db/?f=be2d83a353d47586ac2197fdb56d2085eec61b3f

Any help would be greatly appreciated.

Regards,
Chris
