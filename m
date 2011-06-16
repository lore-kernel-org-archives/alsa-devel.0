From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH 1/2] ALSA: ASoC: add STA32X codec driver
Date: Thu, 16 Jun 2011 11:51:20 +0200
Message-ID: <BANLkTikfDFrh8Bm24ZbUCk1V3ejrgTDU-w@mail.gmail.com>
References: <1308079626-31239-1-git-send-email-zonque@gmail.com>
	<1308079626-31239-2-git-send-email-zonque@gmail.com>
	<20110615150516.GC2806@opensource.wolfsonmicro.com>
	<20110615205329.GA7445@sig21.net> <4DF9C13A.2000205@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
	[209.85.160.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 71D9D1039E0
	for <alsa-devel@alsa-project.org>;
	Thu, 16 Jun 2011 11:51:24 +0200 (CEST)
Received: by pwi18 with SMTP id 18so138705pwi.38
	for <alsa-devel@alsa-project.org>; Thu, 16 Jun 2011 02:51:20 -0700 (PDT)
In-Reply-To: <4DF9C13A.2000205@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Thu, Jun 16, 2011 at 10:39 AM, Lars-Peter Clausen <lars@metafoo.de> wrot=
e:
> You can put multiple scale items each with their own min/max value into a=
 TLV.
> For example for DRC attack in your case this would look like:
>
> static const unsigned int drc_attack_tlv[] =3D {
> =A0 =A0 =A0 =A0TLV_DB_RANGE_HEAD(3),
> =A0 =A0 =A0 =A00, 7, TLV_DB_SCALE_ITEM(-3100, 200, 0),
> =A0 =A0 =A0 =A08, 13, TLV_DB_SCALE_ITEM(-1600, 100, 0),
> =A0 =A0 =A0 =A014, 16, TLV_DB_SCALE_ITEM(-1000, 300, 0),
> };

Using this results in strange values in userspace:

# amixer cget numid=3D39
numid=3D39,iface=3DMIXER,name=3D'Limiter1 Attack Threshold (DRC Mode)'
  ; type=3DINTEGER,access=3Drw---R--,values=3D1,min=3D0,max=3D16,step=3D0
  : values=3D9
  | dBrange-
0x00000000,0x00000007,0x00000001,0x00000008,0xfffff3e4,0x000000c8,0x0000000=
8,0x0000000d,0x00000001,0x00000008,0xfffff9c0,0x00000064,0x0000000e,0x00000=
010,0x00000001,0x00000008,0xfffffc18,0x0000012c,

Is there a way to get more descriptive information about possible
values for such controls?

Thanks,
Daniel
