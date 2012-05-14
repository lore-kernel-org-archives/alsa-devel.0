From: Yang Liu <fred.yang.liu@gmail.com>
Subject: what happened in this sound crackling log?
Date: Mon, 14 May 2012 17:20:04 +1000
Message-ID: <CAOhLAZoz3+mKdk7jkmLT4kjKOSi05JtFB5U0-j2cbacOQ4s-Yw@mail.gmail.com>
References: <CAOhLAZopuo2MQ3-ADOVFoOu=N-FLnNkmhS_EgOOeTj_4AuLbEA@mail.gmail.com>
	<CAOhLAZrMAczJdr8iS6FeV0O0UA_5W=AdAtwYOpUsN1groosk8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gg0-f179.google.com (mail-gg0-f179.google.com
	[209.85.161.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 8F77724931
	for <alsa-devel@alsa-project.org>;
	Mon, 14 May 2012 09:20:25 +0200 (CEST)
Received: by ggnk3 with SMTP id k3so2905218ggn.38
	for <alsa-devel@alsa-project.org>; Mon, 14 May 2012 00:20:25 -0700 (PDT)
In-Reply-To: <CAOhLAZrMAczJdr8iS6FeV0O0UA_5W=AdAtwYOpUsN1groosk8g@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

My sound get crackling after 3 days running. Here is the log I
captured. =A0What happened here? I appreciate any help.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
period_update: pcmC0D0p:0: pos=3D0x440/0x440/0x1540, hwptr=3D0x18b5f162,
hw_base=3D0x18b5f140, hw_intr=3D0x18b5f140
hw_update: pcmC0D0p:0: pos=3D0x441/0x440/0x1540, hwptr=3D0x18b5f580,
hw_base=3D0x18b5f140, hw_intr=3D0x18b5f580
hw_update: pcmC0D0p:0: pos=3D0x441/0x440/0x1540, hwptr=3D0x18b5f581,
hw_base=3D0x18b5f140, hw_intr=3D0x18b5f580
May 14 05:19:04 172.25.18.160 last message repeated 2 times
period_update: pcmC0D0p:0: pos=3D0x880/0x440/0x1540, hwptr=3D0x18b5f581,
hw_base=3D0x18b5f140, hw_intr=3D0x18b5f580
period_update: pcmC0D0p:0: pos=3D0xcc0/0x440/0x1540, hwptr=3D0x18b5f9c0,
hw_base=3D0x18b5f140, hw_intr=3D0x18b5f9c0
hw_update: pcmC0D0p:0: pos=3D0xe1a/0x440/0x1540, hwptr=3D0x18b5fe00,
hw_base=3D0x18b5f140, hw_intr=3D0x18b5fe00
hw_update: pcmC0D0p:0: pos=3D0xe1a/0x440/0x1540, hwptr=3D0x18b5ff5a,
hw_base=3D0x18b5f140, hw_intr=3D0x18b5fe00
hw_update: pcmC0D0p:0: pos=3D0xe1d/0x440/0x1540, hwptr=3D0x18b5ff5a,
hw_base=3D0x18b5f140, hw_intr=3D0x18b5fe00
period_update: pcmC0D0p:0: pos=3D0x1100/0x440/0x1540, hwptr=3D0x18b5ff5d,
hw_base=3D0x18b5f140, hw_intr=3D0x18b5fe00
hw_update: pcmC0D0p:0: pos=3D0x1290/0x440/0x1540, hwptr=3D0x18b60240,
hw_base=3D0x18b5f140, hw_intr=3D0x18b60240
hw_update: pcmC0D0p:0: pos=3D0x1290/0x440/0x1540, hwptr=3D0x18b603d0,
hw_base=3D0x18b5f140, hw_intr=3D0x18b60240
hw_update: pcmC0D0p:0: pos=3D0x1290/0x440/0x1540, hwptr=3D0x18b603d0,
hw_base=3D0x18b5f140, hw_intr=3D0x18b60240
period_update: pcmC0D0p:0: pos=3D0x1/0x440/0x1540, hwptr=3D0x18b603d0,
hw_base=3D0x18b5f140, hw_intr=3D0x18b60240
hw_update: pcmC0D0p:0: pos=3D0x1c0/0x440/0x1540, hwptr=3D0x18b60681,
hw_base=3D0x18b60680, hw_intr=3D0x18b60680
hw_update: pcmC0D0p:0: pos=3D0x1c0/0x440/0x1540, hwptr=3D0x18b60840,
hw_base=3D0x18b60680, hw_intr=3D0x18b60680
hw_update: pcmC0D0p:0: pos=3D0x1c0/0x440/0x1540, hwptr=3D0x18b60840,
hw_base=3D0x18b60680, hw_intr=3D0x18b60680
period_update: pcmC0D0p:0: pos=3D0x440/0x440/0x1540, hwptr=3D0x18b60840,
hw_base=3D0x18b60680, hw_intr=3D0x18b60680
hw_update: pcmC0D0p:0: pos=3D0x652/0x440/0x1540, hwptr=3D0x18b60ac0,
hw_base=3D0x18b60680, hw_intr=3D0x18b60ac0
hw_update: pcmC0D0p:0: pos=3D0x652/0x440/0x1540, hwptr=3D0x18b60cd2,
hw_base=3D0x18b60680, hw_intr=3D0x18b60ac0
hw_update: pcmC0D0p:0: pos=3D0x652/0x440/0x1540, hwptr=3D0x18b60cd2,
hw_base=3D0x18b60680, hw_intr=3D0x18b60ac0
period_update: pcmC0D0p:0: pos=3D0x880/0x440/0x1540, hwptr=3D0x18b60cd2,
hw_base=3D0x18b60680, hw_intr=3D0x18b60ac0
hw_update: pcmC0D0p:0: pos=3D0xaed/0x440/0x1540, hwptr=3D0x18b60f00,
hw_base=3D0x18b60680, hw_intr=3D0x18b60f00
period_update: pcmC0D0p:0: pos=3D0xcc0/0x440/0x1540, hwptr=3D0x18b6116d,
hw_base=3D0x18b60680, hw_intr=3D0x18b60f00
hw_update: pcmC0D0p:0: pos=3D0xfa5/0x440/0x1540, hwptr=3D0x18b61340,
hw_base=3D0x18b60680, hw_intr=3D0x18b61340
period_update: pcmC0D0p:0: pos=3D0x1100/0x440/0x1540, hwptr=3D0x18b61625,
hw_base=3D0x18b60680, hw_intr=3D0x18b61340
hw_update: pcmC0D0p:0: pos=3D0x14ea/0x440/0x1540, hwptr=3D0x18b61780,
hw_base=3D0x18b60680, hw_intr=3D0x18b61780
period_update: pcmC0D0p:0: pos=3D0x0/0x440/0x1540, hwptr=3D0x18b61b6a,
hw_base=3D0x18b60680, hw_intr=3D0x18b61780
period_update: pcmC0D0p:0: pos=3D0x440/0x440/0x1540, hwptr=3D0x18b61bc0,
hw_base=3D0x18b61bc0, hw_intr=3D0x18b61bc0
hw_update: pcmC0D0p:0: pos=3D0x47d/0x440/0x1540, hwptr=3D0x18b62000,
hw_base=3D0x18b61bc0, hw_intr=3D0x18b62000
period_update: pcmC0D0p:0: pos=3D0x881/0x440/0x1540, hwptr=3D0x18b6203d,
hw_base=3D0x18b61bc0, hw_intr=3D0x18b62000
hw_update: pcmC0D0p:0: pos=3D0x935/0x440/0x1540, hwptr=3D0x18b62441,
hw_base=3D0x18b61bc0, hw_intr=3D0x18b62440
period_update: pcmC0D0p:0: pos=3D0xcc0/0x440/0x1540, hwptr=3D0x18b624f5,
hw_base=3D0x18b61bc0, hw_intr=3D0x18b62440
hw_update: pcmC0D0p:0: pos=3D0xddd/0x440/0x1540, hwptr=3D0x18b62880,
hw_base=3D0x18b61bc0, hw_intr=3D0x18b62880
period_update: pcmC0D0p:0: pos=3D0x1100/0x440/0x1540, hwptr=3D0x18b6299d,
hw_base=3D0x18b61bc0, hw_intr=3D0x18b62880
hw_update: pcmC0D0p:0: pos=3D0x128a/0x440/0x1540, hwptr=3D0x18b62cc0,
hw_base=3D0x18b61bc0, hw_intr=3D0x18b62cc0
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D


Below is a piece of normal log. I found there were some more hw_update
between period_update. And the "pos" was a little bit different.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
period_update: pcmC0D0p:0: pos=3D0xcc1/0x440/0x1540, hwptr=3D0x3b69a355,
hw_base=3D0x3b699ac0, hw_intr=3D0x3b69a3
40
hw_update: pcmC0D0p:0: pos=3D0xcc1/0x440/0x1540, hwptr=3D0x3b69a781,
hw_base=3D0x3b699ac0, hw_intr=3D0x3b69a780
May 14 00:00:00 172.25.18.160 last message repeated 3 times
hw_update: pcmC0D0p:0: pos=3D0xcca/0x440/0x1540, hwptr=3D0x3b69a781,
hw_base=3D0x3b699ac0, hw_intr=3D0x3b69a780
hw_update: pcmC0D0p:0: pos=3D0xcca/0x440/0x1540, hwptr=3D0x3b69a78a,
hw_base=3D0x3b699ac0, hw_intr=3D0x3b69a780
hw_update: pcmC0D0p:0: pos=3D0xcca/0x440/0x1540, hwptr=3D0x3b69a78a,
hw_base=3D0x3b699ac0, hw_intr=3D0x3b69a780
hw_update: pcmC0D0p:0: pos=3D0xcd2/0x440/0x1540, hwptr=3D0x3b69a78a,
hw_base=3D0x3b699ac0, hw_intr=3D0x3b69a780
hw_update: pcmC0D0p:0: pos=3D0xcd2/0x440/0x1540, hwptr=3D0x3b69a792,
hw_base=3D0x3b699ac0, hw_intr=3D0x3b69a780
period_update: pcmC0D0p:0: pos=3D0x1100/0x440/0x1540, hwptr=3D0x3b69a792,
hw_base=3D0x3b699ac0, hw_intr=3D0x3b69a
780
hw_update: pcmC0D0p:0: pos=3D0x1101/0x440/0x1540, hwptr=3D0x3b69abc0,
hw_base=3D0x3b699ac0, hw_intr=3D0x3b69abc0
hw_update: pcmC0D0p:0: pos=3D0x1101/0x440/0x1540, hwptr=3D0x3b69abc1,
hw_base=3D0x3b699ac0, hw_intr=3D0x3b69abc0
hw_update: pcmC0D0p:0: pos=3D0x1101/0x440/0x1540, hwptr=3D0x3b69abc1,
hw_base=3D0x3b699ac0, hw_intr=3D0x3b69abc0
hw_update: pcmC0D0p:0: pos=3D0x1103/0x440/0x1540, hwptr=3D0x3b69abc1,
hw_base=3D0x3b699ac0, hw_intr=3D0x3b69abc0
hw_update: pcmC0D0p:0: pos=3D0x110a/0x440/0x1540, hwptr=3D0x3b69abc3,
hw_base=3D0x3b699ac0, hw_intr=3D0x3b69abc0
hw_update: pcmC0D0p:0: pos=3D0x110a/0x440/0x1540, hwptr=3D0x3b69abca,
hw_base=3D0x3b699ac0, hw_intr=3D0x3b69abc0
hw_update: pcmC0D0p:0: pos=3D0x110d/0x440/0x1540, hwptr=3D0x3b69abca,
hw_base=3D0x3b699ac0, hw_intr=3D0x3b69abc0
hw_update: pcmC0D0p:0: pos=3D0x1112/0x440/0x1540, hwptr=3D0x3b69abcd,
hw_base=3D0x3b699ac0, hw_intr=3D0x3b69abc0
hw_update: pcmC0D0p:0: pos=3D0x1112/0x440/0x1540, hwptr=3D0x3b69abd2,
hw_base=3D0x3b699ac0, hw_intr=3D0x3b69abc0
period_update: pcmC0D0p:0: pos=3D0x1/0x440/0x1540, hwptr=3D0x3b69abd2,
hw_base=3D0x3b699ac0, hw_intr=3D0x3b69abc0
hw_update: pcmC0D0p:0: pos=3D0x1/0x440/0x1540, hwptr=3D0x3b69b001,
hw_base=3D0x3b69b000, hw_intr=3D0x3b69b000
May 14 00:00:00 172.25.18.160 last message repeated 2 times
hw_update: pcmC0D0p:0: pos=3D0x3/0x440/0x1540, hwptr=3D0x3b69b001,
hw_base=3D0x3b69b000, hw_intr=3D0x3b69b000
hw_update: pcmC0D0p:0: pos=3D0x6/0x440/0x1540, hwptr=3D0x3b69b003,
hw_base=3D0x3b69b000, hw_intr=3D0x3b69b000
hw_update: pcmC0D0p:0: pos=3D0xd/0x440/0x1540, hwptr=3D0x3b69b006,
hw_base=3D0x3b69b000, hw_intr=3D0x3b69b000
hw_update: pcmC0D0p:0: pos=3D0xd/0x440/0x1540, hwptr=3D0x3b69b00d,
hw_base=3D0x3b69b000, hw_intr=3D0x3b69b000
hw_update: pcmC0D0p:0: pos=3D0x10/0x440/0x1540, hwptr=3D0x3b69b00d,
hw_base=3D0x3b69b000, hw_intr=3D0x3b69b000
hw_update: pcmC0D0p:0: pos=3D0x15/0x440/0x1540, hwptr=3D0x3b69b010,
hw_base=3D0x3b69b000, hw_intr=3D0x3b69b000
hw_update: pcmC0D0p:0: pos=3D0x15/0x440/0x1540, hwptr=3D0x3b69b015,
hw_base=3D0x3b69b000, hw_intr=3D0x3b69b000
period_update: pcmC0D0p:0: pos=3D0x441/0x440/0x1540, hwptr=3D0x3b69b015,
hw_base=3D0x3b69b000, hw_intr=3D0x3b69b0
00
hw_update: pcmC0D0p:0: pos=3D0x441/0x440/0x1540, hwptr=3D0x3b69b441,
hw_base=3D0x3b69b000, hw_intr=3D0x3b69b440
May 14 00:00:00 172.25.18.160 last message repeated 2 times
hw_update: pcmC0D0p:0: pos=3D0x443/0x440/0x1540, hwptr=3D0x3b69b441,
hw_base=3D0x3b69b000, hw_intr=3D0x3b69b440
hw_update: pcmC0D0p:0: pos=3D0x44a/0x440/0x1540, hwptr=3D0x3b69b443,
hw_base=3D0x3b69b000, hw_intr=3D0x3b69b440
hw_update: pcmC0D0p:0: pos=3D0x44a/0x440/0x1540, hwptr=3D0x3b69b44a,
hw_base=3D0x3b69b000, hw_intr=3D0x3b69b440
hw_update: pcmC0D0p:0: pos=3D0x44d/0x440/0x1540, hwptr=3D0x3b69b44a,
hw_base=3D0x3b69b000, hw_intr=3D0x3b69b440
hw_update: pcmC0D0p:0: pos=3D0x452/0x440/0x1540, hwptr=3D0x3b69b44d,
hw_base=3D0x3b69b000, hw_intr=3D0x3b69b440
hw_update: pcmC0D0p:0: pos=3D0x452/0x440/0x1540, hwptr=3D0x3b69b452,
hw_base=3D0x3b69b000, hw_intr=3D0x3b69b440
period_update: pcmC0D0p:0: pos=3D0x880/0x440/0x1540, hwptr=3D0x3b69b452,
hw_base=3D0x3b69b000, hw_intr=3D0x3b69b4
40
hw_update: pcmC0D0p:0: pos=3D0x881/0x440/0x1540, hwptr=3D0x3b69b880,
hw_base=3D0x3b69b000, hw_intr=3D0x3b69b880
hw_update: pcmC0D0p:0: pos=3D0x881/0x440/0x1540, hwptr=3D0x3b69b881,
hw_base=3D0x3b69b000, hw_intr=3D0x3b69b880
May 14 00:00:00 172.25.18.160 last message repeated 2 times
hw_update: pcmC0D0p:0: pos=3D0x886/0x440/0x1540, hwptr=3D0x3b69b881,
hw_base=3D0x3b69b000, hw_intr=3D0x3b69b880
hw_update: pcmC0D0p:0: pos=3D0x886/0x440/0x1540, hwptr=3D0x3b69b886,
hw_base=3D0x3b69b000, hw_intr=3D0x3b69b880
hw_update: pcmC0D0p:0: pos=3D0x889/0x440/0x1540, hwptr=3D0x3b69b886,
hw_base=3D0x3b69b000, hw_intr=3D0x3b69b880
hw_update: pcmC0D0p:0: pos=3D0x88d/0x440/0x1540, hwptr=3D0x3b69b889,
hw_base=3D0x3b69b000, hw_intr=3D0x3b69b880
hw_update: pcmC0D0p:0: pos=3D0x88d/0x440/0x1540, hwptr=3D0x3b69b88d,
hw_base=3D0x3b69b000, hw_intr=3D0x3b69b880
hw_update: pcmC0D0p:0: pos=3D0x88d/0x440/0x1540, hwptr=3D0x3b69b88d,
hw_base=3D0x3b69b000, hw_intr=3D0x3b69b880
hw_update: pcmC0D0p:0: pos=3D0x892/0x440/0x1540, hwptr=3D0x3b69b88d,
hw_base=3D0x3b69b000, hw_intr=3D0x3b69b880
hw_update: pcmC0D0p:0: pos=3D0x892/0x440/0x1540, hwptr=3D0x3b69b892,
hw_base=3D0x3b69b000, hw_intr=3D0x3b69b880
hw_update: pcmC0D0p:0: pos=3D0xa0d/0x440/0x1540, hwptr=3D0x3b69b892,
hw_base=3D0x3b69b000, hw_intr=3D0x3b69b880
hw_update: pcmC0D0p:0: pos=3D0xa10/0x440/0x1540, hwptr=3D0x3b69ba0d,
hw_base=3D0x3b69b000, hw_intr=3D0x3b69b880
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D


I try to get some alsa information here. Sorry I can't use
"alsa-info.sh" because my environment is a customized linux
environment.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
./Intel/pcm0p/sub0/prealloc_max:32768
./Intel/pcm0p/sub0/prealloc:64
./Intel/pcm0p/sub0/status:state: RUNNING
./Intel/pcm0p/sub0/status:trigger_time: 139.020790344
./Intel/pcm0p/sub0/status:tstamp      : 273665.508245384
./Intel/pcm0p/sub0/status:delay       : -654836061
./Intel/pcm0p/sub0/status:avail       : 654841501
./Intel/pcm0p/sub0/status:avail_max   : 654841501
./Intel/pcm0p/sub0/status:-----
./Intel/pcm0p/sub0/status:hw_ptr      : 654836061
./Intel/pcm0p/sub0/status:appl_ptr    : 0
./Intel/pcm0p/sub0/sw_params:tstamp_mode: ENABLE
./Intel/pcm0p/sub0/sw_params:period_step: 1
./Intel/pcm0p/sub0/sw_params:avail_min: 1088
./Intel/pcm0p/sub0/sw_params:start_threshold: 1
./Intel/pcm0p/sub0/sw_params:stop_threshold: 1426063360
./Intel/pcm0p/sub0/sw_params:silence_threshold: 0
./Intel/pcm0p/sub0/sw_params:silence_size: 1426063360
./Intel/pcm0p/sub0/sw_params:boundary: 1426063360
./Intel/pcm0p/sub0/hw_params:access: MMAP_INTERLEAVED
./Intel/pcm0p/sub0/hw_params:format: S16_LE
./Intel/pcm0p/sub0/hw_params:subformat: STD
./Intel/pcm0p/sub0/hw_params:channels: 6
./Intel/pcm0p/sub0/hw_params:rate: 44100 (44100/1)
./Intel/pcm0p/sub0/hw_params:period_size: 1088
./Intel/pcm0p/sub0/hw_params:buffer_size: 5440
./Intel/pcm0p/sub0/info:card: 0
./Intel/pcm0p/sub0/info:device: 0
./Intel/pcm0p/sub0/info:subdevice: 0
./Intel/pcm0p/sub0/info:stream: PLAYBACK
./Intel/pcm0p/sub0/info:id: ALC883 Analog
./Intel/pcm0p/sub0/info:name: ALC883 Analog
./Intel/pcm0p/sub0/info:subname: subdevice #0
./Intel/pcm0p/sub0/info:class: 0
./Intel/pcm0p/sub0/info:subclass: 0
./Intel/pcm0p/sub0/info:subdevices_count: 1
./Intel/pcm0p/sub0/info:subdevices_avail: 0
./Intel/pcm0p/xrun_debug:31
./Intel/pcm0p/info:card: 0
./Intel/pcm0p/info:device: 0
./Intel/pcm0p/info:subdevice: 0
./Intel/pcm0p/info:stream: PLAYBACK
./Intel/pcm0p/info:id: ALC883 Analog
./Intel/pcm0p/info:name: ALC883 Analog
./Intel/pcm0p/info:subname: subdevice #0
./Intel/pcm0p/info:class: 0
./Intel/pcm0p/info:subclass: 0
./Intel/pcm0p/info:subdevices_count: 1
./Intel/pcm0p/info:subdevices_avail: 0
...
./card0/id:Intel
./card0/codec#0:Codec: Realtek ALC883
./card0/codec#0:Address: 0
./card0/codec#0:Function Id: 0x1
./card0/codec#0:Vendor Id: 0x10ec0883
./card0/codec#0:Subsystem Id: 0x10ec0883
./card0/codec#0:Revision Id: 0x100002
./card0/codec#0:No Modem Function Group found
./card0/codec#0:Default PCM:
./card0/codec#0:    rates [0x560]: 44100 48000 96000 192000
./card0/codec#0:    bits [0xe]: 16 20 24
./card0/codec#0:    formats [0x1]: PCM
./card0/codec#0:Default Amp-In caps: N/A
./card0/codec#0:Default Amp-Out caps: N/A
./card0/codec#0:GPIO: io=3D2, o=3D0, i=3D0, unsolicited=3D1, wake=3D0
./card0/codec#0:  IO[0]: enable=3D0, dir=3D0, wake=3D0, sticky=3D0, data=3D=
0, unsol=3D0
./card0/codec#0:  IO[1]: enable=3D0, dir=3D0, wake=3D0, sticky=3D0, data=3D=
0, unsol=3D0
./card0/codec#0:Node 0x02 [Audio Output] wcaps 0x11: Stereo
./card0/codec#0:  Converter: stream=3D5, channel=3D0
./card0/codec#0:  PCM:
./card0/codec#0:    rates [0x560]: 44100 48000 96000 192000
./card0/codec#0:    bits [0xe]: 16 20 24
./card0/codec#0:    formats [0x1]: PCM
./card0/codec#0:Node 0x03 [Audio Output] wcaps 0x11: Stereo
./card0/codec#0:  Converter: stream=3D5, channel=3D4
./card0/codec#0:  PCM:
./card0/codec#0:    rates [0x560]: 44100 48000 96000 192000
./card0/codec#0:    bits [0xe]: 16 20 24
./card0/codec#0:    formats [0x1]: PCM
./card0/codec#0:Node 0x04 [Audio Output] wcaps 0x11: Stereo
./card0/codec#0:  Converter: stream=3D5, channel=3D2
./card0/codec#0:  PCM:
./card0/codec#0:    rates [0x560]: 44100 48000 96000 192000
./card0/codec#0:    bits [0xe]: 16 20 24
./card0/codec#0:    formats [0x1]: PCM
./card0/codec#0:Node 0x05 [Audio Output] wcaps 0x11: Stereo
./card0/codec#0:  Converter: stream=3D5, channel=3D0
./card0/codec#0:  PCM:
./card0/codec#0:    rates [0x560]: 44100 48000 96000 192000
./card0/codec#0:    bits [0xe]: 16 20 24
./card0/codec#0:    formats [0x1]: PCM
./card0/codec#0:Node 0x06 [Audio Output] wcaps 0x211: Stereo Digital
./card0/codec#0:  Converter: stream=3D0, channel=3D0
./card0/codec#0:  Digital:
./card0/codec#0:  Digital category: 0x0
./card0/codec#0:  PCM:
./card0/codec#0:    rates [0x560]: 44100 48000 96000 192000
./card0/codec#0:    bits [0x1e]: 16 20 24 32
./card0/codec#0:    formats [0x1]: PCM
./card0/codec#0:Node 0x07 [Vendor Defined Widget] wcaps 0xf00000: Mono
./card0/codec#0:Node 0x08 [Audio Input] wcaps 0x10011b: Stereo Amp-In
./card0/codec#0:  Amp-In caps: ofs=3D0x08, nsteps=3D0x1f, stepsize=3D0x05, =
mute=3D1
./card0/codec#0:  Amp-In vals:  [0x00 0x00]
./card0/codec#0:  Converter: stream=3D0, channel=3D0
./card0/codec#0:  SDI-Select: 0
./card0/codec#0:  PCM:
./card0/codec#0:    rates [0x160]: 44100 48000 96000
./card0/codec#0:    bits [0x6]: 16 20
./card0/codec#0:    formats [0x1]: PCM
./card0/codec#0:  Connection: 1
./card0/codec#0:     0x23
./card0/codec#0:Node 0x09 [Audio Input] wcaps 0x10011b: Stereo Amp-In
./card0/codec#0:  Amp-In caps: ofs=3D0x08, nsteps=3D0x1f, stepsize=3D0x05, =
mute=3D1
./card0/codec#0:  Amp-In vals:  [0x00 0x00]
./card0/codec#0:  Converter: stream=3D0, channel=3D0
./card0/codec#0:  SDI-Select: 0
./card0/codec#0:  PCM:
./card0/codec#0:    rates [0x160]: 44100 48000 96000
./card0/codec#0:    bits [0x6]: 16 20
./card0/codec#0:    formats [0x1]: PCM
./card0/codec#0:  Connection: 1
./card0/codec#0:     0x22
./card0/codec#0:Node 0x0a [Audio Input] wcaps 0x100391: Stereo Digital
./card0/codec#0:  Converter: stream=3D0, channel=3D0
./card0/codec#0:  SDI-Select: 0
./card0/codec#0:  Digital:
./card0/codec#0:  Digital category: 0x0
./card0/codec#0:  PCM:
./card0/codec#0:    rates [0x560]: 44100 48000 96000 192000
./card0/codec#0:    bits [0x1e]: 16 20 24 32
./card0/codec#0:    formats [0x1]: PCM
./card0/codec#0:  Unsolicited: tag=3D00, enabled=3D0
./card0/codec#0:  Connection: 1
./card0/codec#0:     0x1f
./card0/codec#0:Node 0x0b [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
./card0/codec#0:  Amp-In caps: ofs=3D0x17, nsteps=3D0x1f, stepsize=3D0x05, =
mute=3D1
./card0/codec#0:  Amp-In vals:  [0x9f 0x9f] [0x80 0x80] [0x80 0x80]
[0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80
0x80] [0x80 0x80]
./card0/codec#0:  Connection: 10
./card0/codec#0:     0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x14 0x15 0x16 0x17
./card0/codec#0:Node 0x0c [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-O=
ut
./card0/codec#0:  Amp-In caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, =
mute=3D1
./card0/codec#0:  Amp-In vals:  [0x00 0x00] [0x00 0x00]
./card0/codec#0:  Amp-Out caps: ofs=3D0x1f, nsteps=3D0x1f, stepsize=3D0x05,=
 mute=3D0
./card0/codec#0:  Amp-Out vals:  [0x1f 0x1f]
./card0/codec#0:  Connection: 2
./card0/codec#0:     0x02 0x0b
./card0/codec#0:Node 0x0d [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-O=
ut
./card0/codec#0:  Amp-In caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, =
mute=3D1
./card0/codec#0:  Amp-In vals:  [0x00 0x00] [0x00 0x00]
./card0/codec#0:  Amp-Out caps: ofs=3D0x1f, nsteps=3D0x1f, stepsize=3D0x05,=
 mute=3D0
./card0/codec#0:  Amp-Out vals:  [0x1f 0x1f]
./card0/codec#0:  Connection: 2
./card0/codec#0:     0x03 0x0b
./card0/codec#0:Node 0x0e [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-O=
ut
./card0/codec#0:  Amp-In caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, =
mute=3D1
./card0/codec#0:  Amp-In vals:  [0x00 0x00] [0x00 0x00]
./card0/codec#0:  Amp-Out caps: ofs=3D0x1f, nsteps=3D0x1f, stepsize=3D0x05,=
 mute=3D0
./card0/codec#0:  Amp-Out vals:  [0x1f 0x1f]
./card0/codec#0:  Connection: 2
./card0/codec#0:     0x04 0x0b
./card0/codec#0:Node 0x0f [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-O=
ut
./card0/codec#0:  Amp-In caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, =
mute=3D1
./card0/codec#0:  Amp-In vals:  [0x00 0x00] [0x00 0x00]
./card0/codec#0:  Amp-Out caps: ofs=3D0x1f, nsteps=3D0x1f, stepsize=3D0x05,=
 mute=3D0
./card0/codec#0:  Amp-Out vals:  [0x00 0x00]
./card0/codec#0:  Connection: 2
./card0/codec#0:     0x05 0x0b
./card0/codec#0:Node 0x10 [Vendor Defined Widget] wcaps 0xf00000: Mono
./card0/codec#0:Node 0x11 [Vendor Defined Widget] wcaps 0xf00000: Mono
./card0/codec#0:Node 0x12 [Vendor Defined Widget] wcaps 0xf00000: Mono
./card0/codec#0:Node 0x13 [Vendor Defined Widget] wcaps 0xf00000: Mono
./card0/codec#0:Node 0x14 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-O=
ut
./card0/codec#0:  Amp-In caps: ofs=3D0x00, nsteps=3D0x03, stepsize=3D0x27, =
mute=3D0
./card0/codec#0:  Amp-In vals:  [0x00 0x00]
./card0/codec#0:  Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00,=
 mute=3D1
./card0/codec#0:  Amp-Out vals:  [0x00 0x00]
./card0/codec#0:  Pincap 0x0000003e: IN OUT HP Detect Trigger
./card0/codec#0:  Pin Default 0x01014030: [Jack] Line Out at Ext Rear
./card0/codec#0:    Conn =3D 1/8, Color =3D Green
./card0/codec#0:    DefAssociation =3D 0x3, Sequence =3D 0x0
./card0/codec#0:  Pin-ctls: 0x40: OUT
./card0/codec#0:  Unsolicited: tag=3D00, enabled=3D0
./card0/codec#0:  Connection: 5
./card0/codec#0:     0x0c* 0x0d 0x0e 0x0f 0x26
./card0/codec#0:Node 0x15 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-O=
ut
./card0/codec#0:  Amp-In caps: ofs=3D0x00, nsteps=3D0x03, stepsize=3D0x27, =
mute=3D0
./card0/codec#0:  Amp-In vals:  [0x00 0x00]
./card0/codec#0:  Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00,=
 mute=3D1
./card0/codec#0:  Amp-Out vals:  [0x00 0x00]
./card0/codec#0:  Pincap 0x0000003e: IN OUT HP Detect Trigger
./card0/codec#0:  Pin Default 0x01011031: [Jack] Line Out at Ext Rear
./card0/codec#0:    Conn =3D 1/8, Color =3D Black
./card0/codec#0:    DefAssociation =3D 0x3, Sequence =3D 0x1
./card0/codec#0:  Pin-ctls: 0x40: OUT
./card0/codec#0:  Unsolicited: tag=3D00, enabled=3D0
./card0/codec#0:  Connection: 5
./card0/codec#0:     0x0c 0x0d* 0x0e 0x0f 0x26
./card0/codec#0:Node 0x16 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-O=
ut
./card0/codec#0:  Amp-In caps: ofs=3D0x00, nsteps=3D0x03, stepsize=3D0x27, =
mute=3D0
./card0/codec#0:  Amp-In vals:  [0x00 0x00]
./card0/codec#0:  Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00,=
 mute=3D1
./card0/codec#0:  Amp-Out vals:  [0x00 0x00]
./card0/codec#0:  Pincap 0x0000003e: IN OUT HP Detect Trigger
./card0/codec#0:  Pin Default 0x01016032: [Jack] Line Out at Ext Rear
./card0/codec#0:    Conn =3D 1/8, Color =3D Orange
./card0/codec#0:    DefAssociation =3D 0x3, Sequence =3D 0x2
./card0/codec#0:  Pin-ctls: 0x40: OUT
./card0/codec#0:  Unsolicited: tag=3D00, enabled=3D0
./card0/codec#0:  Connection: 5
./card0/codec#0:     0x0c 0x0d 0x0e* 0x0f 0x26
./card0/codec#0:Node 0x17 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-O=
ut
./card0/codec#0:  Amp-In caps: ofs=3D0x00, nsteps=3D0x03, stepsize=3D0x27, =
mute=3D0
./card0/codec#0:  Amp-In vals:  [0x00 0x00]
./card0/codec#0:  Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00,=
 mute=3D1
./card0/codec#0:  Amp-Out vals:  [0x00 0x00]
./card0/codec#0:  Pincap 0x0000003e: IN OUT HP Detect Trigger
./card0/codec#0:  Pin Default 0x01012033: [Jack] Line Out at Ext Rear
./card0/codec#0:    Conn =3D 1/8, Color =3D Grey
./card0/codec#0:    DefAssociation =3D 0x3, Sequence =3D 0x3
./card0/codec#0:  Pin-ctls: 0x40: OUT
./card0/codec#0:  Unsolicited: tag=3D00, enabled=3D0
./card0/codec#0:  Connection: 5
./card0/codec#0:     0x0c 0x0d 0x0e 0x0f* 0x26
./card0/codec#0:Node 0x18 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-O=
ut
./card0/codec#0:  Amp-In caps: ofs=3D0x00, nsteps=3D0x03, stepsize=3D0x27, =
mute=3D0
./card0/codec#0:  Amp-In vals:  [0x00 0x00]
./card0/codec#0:  Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00,=
 mute=3D1
./card0/codec#0:  Amp-Out vals:  [0x80 0x80]
./card0/codec#0:  Pincap 0x0000173e: IN OUT HP Detect Trigger
./card0/codec#0:    Vref caps: HIZ 50 GRD 80
./card0/codec#0:  Pin Default 0x01a19850: [Jack] Mic at Ext Rear
./card0/codec#0:    Conn =3D 1/8, Color =3D Pink
./card0/codec#0:    DefAssociation =3D 0x5, Sequence =3D 0x0
./card0/codec#0:  Pin-ctls: 0x24: IN VREF_80
./card0/codec#0:  Unsolicited: tag=3D00, enabled=3D0
./card0/codec#0:  Connection: 5
./card0/codec#0:     0x0c* 0x0d 0x0e 0x0f 0x26
./card0/codec#0:Node 0x19 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-O=
ut
./card0/codec#0:  Amp-In caps: ofs=3D0x00, nsteps=3D0x03, stepsize=3D0x27, =
mute=3D0
./card0/codec#0:  Amp-In vals:  [0x00 0x00]
./card0/codec#0:  Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00,=
 mute=3D1
./card0/codec#0:  Amp-Out vals:  [0x80 0x80]
./card0/codec#0:  Pincap 0x0000173e: IN OUT HP Detect Trigger
./card0/codec#0:    Vref caps: HIZ 50 GRD 80
./card0/codec#0:  Pin Default 0x02a19c80: [Jack] Mic at Ext Front
./card0/codec#0:    Conn =3D 1/8, Color =3D Pink
./card0/codec#0:    DefAssociation =3D 0x8, Sequence =3D 0x0
./card0/codec#0:  Pin-ctls: 0x24: IN VREF_80
./card0/codec#0:  Unsolicited: tag=3D00, enabled=3D0
./card0/codec#0:  Connection: 5
./card0/codec#0:     0x0c* 0x0d 0x0e 0x0f 0x26
./card0/codec#0:Node 0x1a [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-O=
ut
./card0/codec#0:  Amp-In caps: ofs=3D0x00, nsteps=3D0x03, stepsize=3D0x27, =
mute=3D0
./card0/codec#0:  Amp-In vals:  [0x00 0x00]
./card0/codec#0:  Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00,=
 mute=3D1
./card0/codec#0:  Amp-Out vals:  [0x80 0x80]
./card0/codec#0:  Pincap 0x0000173e: IN OUT HP Detect Trigger
./card0/codec#0:    Vref caps: HIZ 50 GRD 80
./card0/codec#0:  Pin Default 0x01813050: [Jack] Line In at Ext Rear
./card0/codec#0:    Conn =3D 1/8, Color =3D Blue
./card0/codec#0:    DefAssociation =3D 0x5, Sequence =3D 0x0
./card0/codec#0:  Pin-ctls: 0x20: IN VREF_HIZ
./card0/codec#0:  Unsolicited: tag=3D00, enabled=3D0
./card0/codec#0:  Connection: 5
./card0/codec#0:     0x0c* 0x0d 0x0e 0x0f 0x26
./card0/codec#0:Node 0x1b [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-O=
ut
./card0/codec#0:  Amp-In caps: ofs=3D0x00, nsteps=3D0x03, stepsize=3D0x27, =
mute=3D0
./card0/codec#0:  Amp-In vals:  [0x00 0x00]
./card0/codec#0:  Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00,=
 mute=3D1
./card0/codec#0:  Amp-Out vals:  [0x00 0x00]
./card0/codec#0:  Pincap 0x0000173e: IN OUT HP Detect Trigger
./card0/codec#0:    Vref caps: HIZ 50 GRD 80
./card0/codec#0:  Pin Default 0x02214c40: [Jack] HP Out at Ext Front
./card0/codec#0:    Conn =3D 1/8, Color =3D Green
./card0/codec#0:    DefAssociation =3D 0x4, Sequence =3D 0x0
./card0/codec#0:  Pin-ctls: 0xc0: OUT HP VREF_HIZ
./card0/codec#0:  Unsolicited: tag=3D00, enabled=3D0
./card0/codec#0:  Connection: 5
./card0/codec#0:     0x0c* 0x0d 0x0e 0x0f 0x26
./card0/codec#0:Node 0x1c [Pin Complex] wcaps 0x400001: Stereo
./card0/codec#0:  Pincap 0x00000020: IN
./card0/codec#0:  Pin Default 0x99331150: [Fixed] CD at Int ATAPI
./card0/codec#0:    Conn =3D ATAPI, Color =3D Black
./card0/codec#0:    DefAssociation =3D 0x5, Sequence =3D 0x0
./card0/codec#0:    Misc =3D NO_PRESENCE
./card0/codec#0:  Pin-ctls: 0x00:
./card0/codec#0:Node 0x1d [Pin Complex] wcaps 0x400000: Mono
./card0/codec#0:  Pincap 0x00000020: IN
./card0/codec#0:  Pin Default 0x00000100: [Jack] Line Out at Ext N/A
./card0/codec#0:    Conn =3D Unknown, Color =3D Unknown
./card0/codec#0:    DefAssociation =3D 0x0, Sequence =3D 0x0
./card0/codec#0:    Misc =3D NO_PRESENCE
./card0/codec#0:  Pin-ctls: 0x00:
./card0/codec#0:Node 0x1e [Pin Complex] wcaps 0x400300: Mono Digital
./card0/codec#0:  Pincap 0x00000010: OUT
./card0/codec#0:  Pin Default 0x01441170: [Jack] SPDIF Out at Ext Rear
./card0/codec#0:    Conn =3D RCA, Color =3D Black
./card0/codec#0:    DefAssociation =3D 0x7, Sequence =3D 0x0
./card0/codec#0:    Misc =3D NO_PRESENCE
./card0/codec#0:  Pin-ctls: 0x00:
./card0/codec#0:  Connection: 1
./card0/codec#0:     0x06
./card0/codec#0:Node 0x1f [Pin Complex] wcaps 0x400200: Mono Digital
./card0/codec#0:  Pincap 0x00000020: IN
./card0/codec#0:  Pin Default 0x01c46160: [Jack] SPDIF In at Ext Rear
./card0/codec#0:    Conn =3D RCA, Color =3D Orange
./card0/codec#0:    DefAssociation =3D 0x6, Sequence =3D 0x0
./card0/codec#0:    Misc =3D NO_PRESENCE
./card0/codec#0:  Pin-ctls: 0x00:
./card0/codec#0:Node 0x20 [Vendor Defined Widget] wcaps 0xf00040: Mono
./card0/codec#0:  Processing caps: benign=3D0, ncoeff=3D17
./card0/codec#0:  Processing Coefficient: 0xcccc
./card0/codec#0:  Coefficient Index: 0x10
./card0/codec#0:Node 0x21 [Vendor Defined Widget] wcaps 0xf00000: Mono
./card0/codec#0:Node 0x22 [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-O=
ut
./card0/codec#0:  Amp-In caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, =
mute=3D1
./card0/codec#0:  Amp-In vals:  [0x00 0x00] [0x80 0x80] [0x80 0x80]
[0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80
0x80] [0x80 0x80] [0x80 0x80]
./card0/codec#0:  Amp-Out caps: N/A
./card0/codec#0:  Amp-Out vals:  [0x00 0x00]
./card0/codec#0:  Connection: 11
./card0/codec#0:     0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x14 0x15 0x16 0x17 0x0b
./card0/codec#0:Node 0x23 [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-O=
ut
./card0/codec#0:  Amp-In caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, =
mute=3D1
./card0/codec#0:  Amp-In vals:  [0x00 0x00] [0x80 0x80] [0x80 0x80]
[0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80
0x80] [0x80 0x80] [0x80 0x80]
./card0/codec#0:  Amp-Out caps: N/A
./card0/codec#0:  Amp-Out vals:  [0x00 0x00]
./card0/codec#0:  Connection: 11
./card0/codec#0:     0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x14 0x15 0x16 0x17 0x0b
./card0/codec#0:Node 0x24 [Vendor Defined Widget] wcaps 0xf00000: Mono
./card0/codec#0:Node 0x25 [Audio Output] wcaps 0x11: Stereo
./card0/codec#0:  Converter: stream=3D0, channel=3D0
./card0/codec#0:  PCM:
./card0/codec#0:    rates [0x560]: 44100 48000 96000 192000
./card0/codec#0:    bits [0xe]: 16 20 24
./card0/codec#0:    formats [0x1]: PCM
./card0/codec#0:Node 0x26 [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-O=
ut
./card0/codec#0:  Amp-In caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, =
mute=3D1
./card0/codec#0:  Amp-In vals:  [0x00 0x00] [0x00 0x00]
./card0/codec#0:  Amp-Out caps: ofs=3D0x1f, nsteps=3D0x1f, stepsize=3D0x05,=
 mute=3D0
./card0/codec#0:  Amp-Out vals:  [0x00 0x00]
./card0/codec#0:  Connection: 2
./card0/codec#0:     0x25 0x0b
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D


Thanks,
Fred
