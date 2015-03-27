From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: getting the sound to work on my asus m6s00v
Date: Fri, 27 Mar 2015 17:08:47 +0800
Message-ID: <CAN8cciZNz1TGSQah+KzRGGhRwGWR4U3LbMVUxV+=0mtX1gdM=w@mail.gmail.com>
References: <5a713868662bb9ea47f5a30bd1849ce8@swn.nu>
 <5508DD4D.3040901@canonical.com>
 <CAN8cciaU_U+UwpJkayz2RhpSjfur9TC+X_HVC1=AGY2ypbcEmA@mail.gmail.com>
 <e137111e5526d3424e7ce1f219bcfa88@swn.nu>
 <CAN8cciY7zPaM1kGbky3st_V5G=vg_aeLrm2QrNbpVinYOU=qyA@mail.gmail.com>
 <64443a816660f3098fc300c7d7b5a01f@swn.nu>
 <CAN8cciY-K-FkQp1H6Bj0v51CRHrOyFrJ2=ZaY5YLvkRmNU8TRg@mail.gmail.com>
 <ec6b05bc169224058a4835e2139cbcb4@swn.nu>
 <CAN8cciYo-SSeoBg69qaj+aYBx+ZRbVuhbgkURutuBWGwCxauWA@mail.gmail.com>
 <CAN8cciam2=TE3zhWNB_GQEr1Q1z_X7S+k34fAgajE_XNYJzo0Q@mail.gmail.com>
 <CAN8cciZhtL_C-DAErzhM4E3t3nn7KdAbjQXQEPk3iVcBvm4aUw@mail.gmail.com>
 <CAN8cciZqdwONrrpWc0EKNfGz9Xwibh9Xj+=JnZ=ieK+m1rbF8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f173.google.com (mail-ob0-f173.google.com
 [209.85.214.173])
 by alsa0.perex.cz (Postfix) with ESMTP id 23B73260434
 for <alsa-devel@alsa-project.org>; Fri, 27 Mar 2015 10:08:49 +0100 (CET)
Received: by obbld8 with SMTP id ld8so14483016obb.3
 for <alsa-devel@alsa-project.org>; Fri, 27 Mar 2015 02:08:48 -0700 (PDT)
In-Reply-To: <CAN8cciZqdwONrrpWc0EKNfGz9Xwibh9Xj+=JnZ=ieK+m1rbF8w@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Christian Gleerup <cromozon@swn.nu>
Cc: Hui Wang <hui.wang@canonical.com>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, nb <nb@dagami.org>
List-Id: alsa-devel@alsa-project.org

>
> I have done a couple of things
> First I left the laptop off with no power connected;
> This made the laptop awake in the non functional state regarding the
soundcard.
> I then used this opportunity to update to the latest kernel.
>
> With the latest kernel, the sound is still not working.
> Unmuting the S/PDIF in alsamixer turn on red light in the headphone jack.
>
> also, using 3stack-digout option doesn't bring back sound.
>
> This is the output from the alsa information tool
> http://www.alsa-project.org/db/?f=df46a9ee01e04dde11b194e0278c9f22594540d0
>
> after updating this is the output from various commands
>
> [
> Nothing plugged in:
> ./hdajacksensetest -a
> Pin 0x14 (Green Headphone, Rear side): present = No
> Pin 0x15 (Not connected): present = No
> Pin 0x16 (Not connected): present = No
> Pin 0x17 (Not connected): present = No
> Pin 0x18 (Internal Mic): present = Yes
> Pin 0x19 (Not connected): present = No
> Pin 0x1a (Not connected): present = Yes
> Pin 0x1b (Not connected): present = No
> Pin 0x1c (Not connected): present = No
> Pin 0x1d (Not connected): present = No
> Pin 0x1e (Internal SPDIF Out, Mobile-In): present = No
> Pin 0x1f (Not connected): present = No
>
> ./hda-verb /dev/snd/hwC0D0 0x1{4,5,8} SET_PIN_SENSE 0 nid
> nid = 0x14, verb = 0x709, param = 0x0
> value = 0x0
>
> nid = 0x15, verb = 0x709, param = 0x0
> value = 0x0
>
> nid = 0x18, verb = 0x709, param = 0x0
> value = 0x0
>
> ./hda-verb /dev/snd/hwC0D0 0x1{4,5,8} GET_PIN_SENSE 0 nid
> nid = 0x14, verb = 0xf09, param = 0x0
> value = 0x80001f41
>
> nid = 0x15, verb = 0xf09, param = 0x0
> value = 0x80001f41
>
> nid = 0x18, verb = 0xf09, param = 0x0
> value = 0x7fffffff
> ]
>
> [
> With headphone plugged in
> ./hdajacksensetest/hdajacksensetest -a
> Pin 0x14 (Green Headphone, Rear side): present = No
> Pin 0x15 (Not connected): present = Yes
> Pin 0x16 (Not connected): present = No
> Pin 0x17 (Not connected): present = No
> Pin 0x18 (Internal Mic): present = Yes
> Pin 0x19 (Not connected): present = No
> Pin 0x1a (Not connected): present = Yes
> Pin 0x1b (Not connected): present = No
> Pin 0x1c (Not connected): present = No
> Pin 0x1d (Not connected): present = No
> Pin 0x1e (Internal SPDIF Out, Mobile-In): present = No
> Pin 0x1f (Not connected): present = No
>
> // and also ecact same output for hda-verb as with nothing plugged in
> ]
>
> [
> with Mic plugged in, the following items changed
>
> ./hdajacksensetest/hdajacksensetest -a
> Pin 0x14 (Green Headphone, Rear side): present = Yes
> Pin 0x15 (Not connected): present = Yes
> Pin 0x16 (Not connected): present = No
> Pin 0x17 (Not connected): present = No
> Pin 0x18 (Internal Mic): present = Yes
> Pin 0x19 (Not connected): present = No
> Pin 0x1a (Not connected): present = Yes
> Pin 0x1b (Not connected): present = No
> Pin 0x1c (Not connected): present = No
> Pin 0x1d (Not connected): present = No
> Pin 0x1e (Internal SPDIF Out, Mobile-In): present = No
> Pin 0x1f (Not connected): present = No
>
> ./hda-verb /dev/snd/hwC0D0 0x15 GET_PIN_SENSE 0 nid
> nid = 0x15, verb = 0xf09, param = 0x0
> value = 0x7fffffff
>
> ./hda-verb /dev/snd/hwC0D0 0x18 GET_PIN_SENSE 0 nid
> nid = 0x18, verb = 0xf09, param = 0x0
> value = 0x80001f41

Seem impedance measurement is not correct, mic should have higher impedance
than headphone

https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/tree/Documentation/sound/alsa/HD-Audio.txt

You can disable it by hint trigger_sense=0

- trigger_sense (bool): indicates that the jack detection needs the
  explicit call of AC_VERB_SET_PIN_SENSE verb

Node 0x14 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Control: name="Master Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Control: name="Headphone Mic Phantom Jack", index=0, device=0
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

To get back headphone phantom jack if HP is really shared with speaker

Disable hp mic by hint  hp_mic_detect=0

- hp_mic_detect (bool): enable/disable the hp/mic shared input for a single
built-in mic case; default true
