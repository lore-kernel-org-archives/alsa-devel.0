From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: No sound from Mac Pro headphone port
Date: Sat, 20 Jun 2015 07:02:29 +0800
Message-ID: <CAN8ccibO9m5fDh02fnTX8CrhN68vKy8wSr5yz9GrrCEWmg=p2g@mail.gmail.com>
References: <554CC0EC.5000506@todddailey.ca>
 <CAN8cciYJdMeKyYL1mqUkN3bKmEhwqHN1-pZzCvBDazBPKdH7vw@mail.gmail.com>
 <554CCCAF.6000608@todddailey.ca>
 <CAN8cciaSiJBr4RKP6Rj3JurnrPEGufBsnLEACdvrhRLcRfPkcg@mail.gmail.com>
 <5555460D.3060907@todddailey.ca>
 <CAN8cciaEdt3zM_V7M4_8YVBHrs+GQsfs1jV32owfsR_2oO52AA@mail.gmail.com>
 <CAN8cciaepxbsuprm+EFr4jE24so1-WMnNDOfdQQPaM9AsK2hNQ@mail.gmail.com>
 <55819224.5090105@todddailey.ca>
 <CAN8cciZesh=oO765REcCo=ce8vO63ASthWGFROM5p06Ms+nx1g@mail.gmail.com>
 <55840D29.6010702@todddailey.ca>
 <CAN8ccia-MdiK0nGaiCgrJb9f+Ud2uuPUPx=+WBJ7AgLBOjhKMw@mail.gmail.com>
 <55844837.1080004@todddailey.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f175.google.com (mail-ob0-f175.google.com
 [209.85.214.175])
 by alsa0.perex.cz (Postfix) with ESMTP id 81BEB26063F
 for <alsa-devel@alsa-project.org>; Sat, 20 Jun 2015 01:02:30 +0200 (CEST)
Received: by obbgp2 with SMTP id gp2so83263089obb.2
 for <alsa-devel@alsa-project.org>; Fri, 19 Jun 2015 16:02:29 -0700 (PDT)
In-Reply-To: <55844837.1080004@todddailey.ca>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Todd Dailey <todd@todddailey.ca>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

>
> I will need more instruction on how to accomplish step 3
>
>
> "3) clear misc bit 8 of pin default of line out"
>
> Thus far, moving both HP and Mic to "Front" gives no improvement.

Post output of alsa info after you fix hp and mic to ext front

http://git.alsa-project.org/?p=alsa-tools.git;a=blob;f=hdajackretask/README;hb=HEAD

You previous alsa info show you have changed those unconnected pin complex
to connected

You don't need to check show unconnected pin if your three pin complex

line out, line in and hp can be detected by hdajacksensetest -a

You need to use advanced override  mode to change ext front and jack
detection

http://git.alsa-project.org/?p=alsa-tools.git;a=blob;f=hdajackretask/main-gtk.c;hb=HEAD

          gtk_grid_attach(grid, gtk_label_new("Color"), 0, 2, 1, 1);
         gtk_grid_attach(grid, data->free_override_cb[4], 0, 3, 1, 1);
         gtk_grid_attach(grid, gtk_label_new("Jack detection"), 1, 2, 1, 1);
         gtk_grid_attach(grid, data->free_override_cb[5], 1, 3, 1, 1);
         gtk_grid_attach(grid, gtk_label_new("Channel group"), 2, 2, 1, 1);

Since you have internal speaker, line out and headphone need to support
jack detection for auto mute

Seem you have changed the other unconnected pin complexes to line out

The name of playback switch should changed from front to line out

MISC= NO_PRESENCE already removed

Line out phantom jack already changed to line out jack
But unsolicited event is not enabled
  Unsolicited: tag=00, enabled=0

Since you have performed dynamic reconfiguration several times in your
dmesg log and the other unconnected pin have changed to line out

You better use set as boot default and reboot instead of dynamic
reconfiguration

Node 0x14 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
  Control: name="Front Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Control: name="Line Out Phantom Jack", index=0, device=0
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-In vals:  [0x00 0x00]
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x0000373c: IN OUT HP Detect
    Vref caps: HIZ 50 GRD 80 100
  Pin Default 0x01014010: [Jack] Line Out at Ext Rear
    Conn = 1/8, Color = Green
    DefAssociation = 0x1, Sequence = 0x0
  Pin-ctls: 0x40: OUT VREF_HIZ
  Unsolicited: tag=00, enabled=0
  Connection: 5
     0x0c* 0x0d 0x0e 0x0f 0x
