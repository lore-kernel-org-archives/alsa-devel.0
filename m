From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH 1/2] ALSA: ASoC: add STA32X codec driver
Date: Thu, 16 Jun 2011 13:03:58 +0200
Message-ID: <BANLkTim0DDg2FBzHDESFbgrHyrz-STq=Yg@mail.gmail.com>
References: <1308079626-31239-1-git-send-email-zonque@gmail.com>
	<1308079626-31239-2-git-send-email-zonque@gmail.com>
	<20110615150516.GC2806@opensource.wolfsonmicro.com>
	<20110615205329.GA7445@sig21.net> <4DF9C13A.2000205@metafoo.de>
	<BANLkTikfDFrh8Bm24ZbUCk1V3ejrgTDU-w@mail.gmail.com>
	<20110616101313.GB5262@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f49.google.com (mail-pz0-f49.google.com
	[209.85.210.49])
	by alsa0.perex.cz (Postfix) with ESMTP id 5E4C11037E3
	for <alsa-devel@alsa-project.org>;
	Thu, 16 Jun 2011 13:04:00 +0200 (CEST)
Received: by pzk28 with SMTP id 28so1219547pzk.8
	for <alsa-devel@alsa-project.org>; Thu, 16 Jun 2011 04:03:58 -0700 (PDT)
In-Reply-To: <20110616101313.GB5262@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Thu, Jun 16, 2011 at 12:13 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Thu, Jun 16, 2011 at 11:51:20AM +0200, Daniel Mack wrote:
>
>> # amixer cget numid=3D39
>> numid=3D39,iface=3DMIXER,name=3D'Limiter1 Attack Threshold (DRC Mode)'
>> =A0 ; type=3DINTEGER,access=3Drw---R--,values=3D1,min=3D0,max=3D16,step=
=3D0
>> =A0 : values=3D9
>> =A0 | dBrange-
>> 0x00000000,0x00000007,0x00000001,0x00000008,0xfffff3e4,0x000000c8,0x0000=
0008,0x0000000d,0x00000001,0x00000008,0xfffff9c0,0x00000064,0x0000000e,0x00=
000010,0x00000001,0x00000008,0xfffffc18,0x0000012c,
>
>> Is there a way to get more descriptive information about possible
>> values for such controls?
>
> This looks rather like a buggy userspace - are you sure you're using a
> current version?

# amixer --version
amixer version 1.0.24.2

This is indeed strange, and I can't see how I use the API in any
illegal way. Any other way to debug this?

Thanks,
Daniel
