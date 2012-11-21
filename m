From: Nick Bailey <nicholas.bailey@glasgow.ac.uk>
Subject: MIDI output to Tascam US-122 via usb-usx2y
	(regression?)
Date: Wed, 21 Nov 2012 15:11:29 +0000
Message-ID: <20121121151129.0ba32f18@arial.fairholm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hillend.cent.gla.ac.uk (hillend.cent.gla.ac.uk [130.209.16.102])
 by alsa0.perex.cz (Postfix) with ESMTP id D29CC2650A8
 for <alsa-devel@alsa-project.org>; Wed, 21 Nov 2012 16:06:06 +0100 (CET)
Received: from cas06.campus.gla.ac.uk ([130.209.14.39])
 by hillend.cent.gla.ac.uk with esmtp (Exim 4.72)
 (envelope-from <Nicholas.Bailey@glasgow.ac.uk>) id 1TbBsM-0005nj-G5
 for alsa-devel@alsa-project.org; Wed, 21 Nov 2012 15:06:06 +0000
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

I've been stumped for a while as to why my Tascam US-122 box stopped
working as a writeable midi port. MIDI input, and audio input work
(maybe audio output too)

Using Debian Wheezy, everything was working up to a few weeks ago. MIDI
input still works and there's nothing suspicious in the /var/logs.

But...

nick@arial:~$ aplaymidi -l
 Port    Client name                      Port name
 14:0    Midi Through                     Midi Through Port-0
 20:0    TASCAM US-X2Y                    TASCAM US-X2Y MIDI 1
 24:0    USB MIDI keyboard                USB MIDI keyboard MIDI 1
nick@arial:~$ aplaymidi -p 20:0 Desktop/076903b_.mid
Cannot connect to port 20:0 - Input/output error
nick@arial:~$ uname -a
Linux arial 3.2.0-4-686-pae #1 SMP Debian 3.2.32-1 i686 GNU/Linux

Using older kernels doesn't help. Connecting e.g. rosegarden to the
TASCAM US-122 in qjackctl fails silently (the link is not made in the
connections window and nothing is printed on the console). Can't see
any module loading issues.

Is anybody else seeing this behaviour? I'd submit a bug report but
really can't figure out exactly what isn't working :(

nick@arial:~$ lsmod
Module                  Size  Used by
snd_usb_audio          71309  0 
snd_hrtimer            12540  0 
snd_seq_dummy          12455  0 
snd_usb_usx2y          22748  2 
snd_usbmidi_lib        18844  2 snd_usb_audio,snd_usb_usx2y
snd_seq_midi           12744  0 
snd_seq_midi_event     13124  1 snd_seq_midi
snd_rawmidi            18376  2 snd_seq_midi,snd_usbmidi_lib
...
usbcore               104470  8
ehci_hcd,uhci_hcd,uas,usb_storage,snd_usb_audio,snd_usbmidi_lib,snd_usb_usx2y
usb_common             12338  1 usbcore

Nick/.
