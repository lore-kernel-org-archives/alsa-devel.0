From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: getting the sound to work on my asus m6s00v
Date: Thu, 19 Mar 2015 14:04:48 +0800
Message-ID: <CAN8cciYW6gcFuq-=oGyB85TgW=m9017yy83_M6vZMmy+f=yz=g@mail.gmail.com>
References: <5a713868662bb9ea47f5a30bd1849ce8@swn.nu>
 <5508DD4D.3040901@canonical.com>
 <CAN8cciaU_U+UwpJkayz2RhpSjfur9TC+X_HVC1=AGY2ypbcEmA@mail.gmail.com>
 <e137111e5526d3424e7ce1f219bcfa88@swn.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f179.google.com (mail-ob0-f179.google.com
 [209.85.214.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 91ADA26053E
 for <alsa-devel@alsa-project.org>; Thu, 19 Mar 2015 07:04:49 +0100 (CET)
Received: by obdfc2 with SMTP id fc2so47519863obd.3
 for <alsa-devel@alsa-project.org>; Wed, 18 Mar 2015 23:04:48 -0700 (PDT)
In-Reply-To: <e137111e5526d3424e7ce1f219bcfa88@swn.nu>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Christian Gleerup <cromozon@swn.nu>, nb@dagami.org
Cc: Hui Wang <hui.wang@canonical.com>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

>
> The internal mic also works.
>
> but; I am a bit puzled, because I tried to comment out 'options
snd-hda-intel model=3stack-digout' and did a powercycle (power off)...
> and now the sound still works, so it seems the soundcard was woken from
some deepsleep.
> The machine have been turned of for many (4/5) years...
>
> Anyway since the soundcard now is working with my current kernel without
the extra options, I am unsure if trying the newest vanilla kernel would
make any sense?
>
> Any recommendations?

If it is a netbook with one jack which can be used as headphone or mic

The best way is to measure the impedance of the jack to determince  HP or
mic and swtich pin ctls to OUT or IN as pincap support ImpSense

Node 0x14 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x0000003f: IN OUT HP Detect Trigger ImpSense
  Pin Default 0x0121411f: [Jack] HP Out at Ext Rear
    Conn = 1/8, Color = Green
    DefAssociation = 0x1, Sequence = 0xf
    Misc = NO_PRESENCE
  Pin-ctls: 0xc0: OUT HP
  Unsolicited: tag=00, enabled=0
  Connection: 1
     0x0c

Try

hda-verb  /dev/snd/hwC0D0 0x14 SET_PIN_SENSE 0

hda-verb /dev/snd/hwC0D0 0x14 GET_PIN_SENSE 0

and check the returned values when you plug hp and mic are different
