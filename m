From: Connor McAdams <conmanx360@gmail.com>
Subject: Fixing the CA0132 driver for Sound Blaster Z
Date: Fri, 9 Feb 2018 19:15:40 -0500
Message-ID: <CAM8Agx3qymn0b_yFtLWhJ71uWV4b4TgJCnkykczMVpOne+eyCQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f49.google.com (mail-wm0-f49.google.com [74.125.82.49])
 by alsa0.perex.cz (Postfix) with ESMTP id D5999266EBE
 for <alsa-devel@alsa-project.org>; Sat, 10 Feb 2018 01:15:41 +0100 (CET)
Received: by mail-wm0-f49.google.com with SMTP id f3so397350wmc.1
 for <alsa-devel@alsa-project.org>; Fri, 09 Feb 2018 16:15:41 -0800 (PST)
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

        Hi, first time here and first time working on any sort of Kernel
driver,
so I hope I'm doing things right by asking my question through this list.

        I have managed to get audio working for the Creative Sound Blaster
Z by
reverse engineering the driver and firmware from Windows. I created a
program
to capture the HDA verbs as they happen in Windows through QEMU using vfio
pci
passthrough.

        Now, here's where I'm kind of stumped. I created a program to send
the
commands that route the audio to it's output on the card. If I run these
commands after the driver has already loaded in Linux, it works fine and I
get
audio. However, if I run these commands inside of the driver, there is no
audio.

        There is an 8051 cpu onboard, and I can dump the contents of its
memory
through HDA-verbs. I compared dumps of the 8051 while audio is working with
the
script to dumps when the audio is broken from putting the commands inside
of the
driver. Just about everything is the same, except for a region I have
figured
out has to do with the streams. Each audio stream seems to have an ID, and
for
some reason, if the commands are run inside of the driver, it seems like the
stream ID's get messed with.

        My current theory is that the streams are assigned in order of
streams
started. So, after my command to start audio, it expects the next stream to
be
the output audio stream. It also seems like compared to Windows, a lot more
stream commands are used. Maybe extra streams are being initiated that are
unused, and are interfering with the card.

        So, my question is, how would I go about starting a stream, maybe
like
a dummy stream, so it is assigned properly? Are there any examples of this?
If someone could point me to where streams are even initiated it would be
helpful.

        My next question is the legality of distributing the firmware. I was
able to pull the Sound Blaster Z's firmware from the Windows driver file.
Since that is a publicly available file, is it legal to redistribute? I have
no experience with this kind of thing. Maybe someone here has someone within
Creative I could ask or something.

        Anyways, like I said, this is my first time doing anything like
this.
Please correct me if I've done anything wrong, and let me know if anyone
needs
to see my current driver.

Thanks,
        Connor M.
