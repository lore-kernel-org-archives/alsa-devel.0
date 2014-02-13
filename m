From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: No sound from Headphone Jack over Lenovo Docking
 Station with T440p Laptop
Date: Thu, 13 Feb 2014 10:15:30 +0800
Message-ID: <CAN8cciaSZqBONqtjOE9BPst_7x_HcUm06V9yZEnY2O=woRjZaA@mail.gmail.com>
References: <trinity-ed805987-a2af-445d-8c84-171681bd6482-1387447530146@3capp-webde-bs34>
 <CAN8cciaKv=4s2Njaag7XjqBj203EPL1BTi3XAG+ZmEpSP+20hg@mail.gmail.com>
 <loom.20140212T215407-567@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qa0-f49.google.com (mail-qa0-f49.google.com
 [209.85.216.49])
 by alsa0.perex.cz (Postfix) with ESMTP id 6DEB4265175
 for <alsa-devel@alsa-project.org>; Thu, 13 Feb 2014 03:15:31 +0100 (CET)
Received: by mail-qa0-f49.google.com with SMTP id w8so14946160qac.8
 for <alsa-devel@alsa-project.org>; Wed, 12 Feb 2014 18:15:30 -0800 (PST)
In-Reply-To: <loom.20140212T215407-567@post.gmane.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bernhard <schlimmchen@yahoo.de>, nkalkhof@web.de
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2014-02-13 5:01 GMT+08:00 Bernhard <schlimmchen@yahoo.de>:

> Raymond Yau <superquad.vortex2 <at> gmail.com> writes:
> >
> > Post the output of alsa-info.sh when thinkpad is docked and not docked
> with
> > headphone pluggedd and unplugged
> >
>
> I created the output you requested (Lenovo ThinkPad T440p in UltraDock, no
> sound when docked via dock jack but notebook speakers are also mute).
>
> not docked: http://pastebin.com/MFQT3R9S
> docked, no headphones: http://pastebin.com/8UN1sHSM
> docked, headphones plugged in dock: http://pastebin.com/7XauZLZz
> docked, headphones plugged in notebook: http://pastebin.com/xfL5qkge
>
> Based on that, can you help us getting sound to work on the dock?
>
>
the headphone is at node 0x15

        control.16 {
                iface CARD
                name 'Headphone Jack'
                value true
                comment {
                        access read
                        type BOOLEAN
                        count 1
                }
        }

you need to use hda_jack_sense_test.py which require python and hda codec
parser of hda-analyzer to find out

https://bugzilla.kernel.org/show_bug.cgi?id=66621#c39

pd=1 when plugged and pd=0 when unplugged

or hda-verb GET_PIN_SENSE

https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/plain/Documentation/sound/alsa/HD-Audio.txt

1) the node of the headphone of the dock headset

node 0x16 , 0x18 and 0x19 which pincap support output

try hdajackretask or early patching to fix the pin default to dock headphone

2) for the dock headset mic , you need to find by trial and error from the
remaining unconnected nodes which pincap support input

node 0x13, 0x19, 0x1b, 0x1d


https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/log/sound/pci/hda/patch_realtek.c?qt=grep&q=dock

 0x21a11000  /* dock-mic */

need to set bit 8 if dock headset mic use jack detection of headphone
instead of jack detection of its own pin compex

 0x2121103f  /* dock-HP */
 0x21440100  /* dock SPDIF out */

you need to clear bit 8 if pincap of node 0x1e support DETECT
