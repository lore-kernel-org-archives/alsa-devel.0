From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH 1/2] ALSA: ASoC: add STA32X codec driver
Date: Thu, 16 Jun 2011 13:26:05 +0200
Message-ID: <BANLkTin5VO10e9xAsPfTf-kajq5j5yATtQ@mail.gmail.com>
References: <1308079626-31239-1-git-send-email-zonque@gmail.com>
	<1308079626-31239-2-git-send-email-zonque@gmail.com>
	<20110615150516.GC2806@opensource.wolfsonmicro.com>
	<20110615205329.GA7445@sig21.net> <4DF9C13A.2000205@metafoo.de>
	<BANLkTikfDFrh8Bm24ZbUCk1V3ejrgTDU-w@mail.gmail.com>
	<20110616101313.GB5262@opensource.wolfsonmicro.com>
	<BANLkTim0DDg2FBzHDESFbgrHyrz-STq=Yg@mail.gmail.com>
	<4DF9E4D7.9090309@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pv0-f179.google.com (mail-pv0-f179.google.com
	[74.125.83.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 1974B1037EE
	for <alsa-devel@alsa-project.org>;
	Thu, 16 Jun 2011 13:26:07 +0200 (CEST)
Received: by pvg18 with SMTP id 18so183704pvg.38
	for <alsa-devel@alsa-project.org>; Thu, 16 Jun 2011 04:26:05 -0700 (PDT)
In-Reply-To: <4DF9E4D7.9090309@metafoo.de>
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

On Thu, Jun 16, 2011 at 1:11 PM, Lars-Peter Clausen <lars@metafoo.de> wrote:
> On 06/16/2011 01:03 PM, Daniel Mack wrote:
>> On Thu, Jun 16, 2011 at 12:13 PM, Mark Brown
>> <broonie@opensource.wolfsonmicro.com> wrote:
>>> On Thu, Jun 16, 2011 at 11:51:20AM +0200, Daniel Mack wrote:
>>>
>>>> # amixer cget numid=3D39
>>>> numid=3D39,iface=3DMIXER,name=3D'Limiter1 Attack Threshold (DRC Mode)'
>>>> =A0 ; type=3DINTEGER,access=3Drw---R--,values=3D1,min=3D0,max=3D16,ste=
p=3D0
>>>> =A0 : values=3D9
>>>> =A0 | dBrange-
>>>> 0x00000000,0x00000007,0x00000001,0x00000008,0xfffff3e4,0x000000c8,0x00=
000008,0x0000000d,0x00000001,0x00000008,0xfffff9c0,0x00000064,0x0000000e,0x=
00000010,0x00000001,0x00000008,0xfffffc18,0x0000012c,
>>>
>>>> Is there a way to get more descriptive information about possible
>>>> values for such controls?
>>>
>>> This looks rather like a buggy userspace - are you sure you're using a
>>> current version?
>>
>> # amixer --version
>> amixer version 1.0.24.2
>>
>> This is indeed strange, and I can't see how I use the API in any
>> illegal way. Any other way to debug this?
>>
> There seems to be a bug in amixer, please try:
>
> diff --git a/amixer/amixer.c b/amixer/amixer.c
> index a177288..c7b93b7 100644
> --- a/amixer/amixer.c
> +++ b/amixer/amixer.c
> @@ -517,7 +517,7 @@ static void decode_tlv(unsigned int spaces, unsigned =
int *tlv, unsigned int tlv_
> =A0#ifdef SND_CTL_TLVT_DB_RANGE
> =A0 =A0 =A0 =A0case SND_CTL_TLVT_DB_RANGE:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printf("dBrange-\n");
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((size / (6 * sizeof(unsigned int))) !=
=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((size % (6 * sizeof(unsigned int))) !=
=3D 0) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0while (size > 0) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printf("0x=
%08x,", tlv[idx++]);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0size -=3D =
sizeof(unsigned int);
> @@ -529,7 +529,7 @@ static void decode_tlv(unsigned int spaces, unsigned =
int *tlv, unsigned int tlv_
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0print_spaces(spaces + 2);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printf("rangemin=3D%i,", t=
lv[0]);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printf(",rangemax=3D%i\n",=
 tlv[1]);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 decode_tlv(spaces + 4, tlv =
+ 2, 6 * sizeof(unsigned int));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 decode_tlv(spaces + 4, tlv =
+ 2, 4 * sizeof(unsigned int));
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0idx +=3D 6 * sizeof(unsign=
ed int);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
>

Looks different now, but I'd say that's still not what you expected:

# amixer cget numid=3D39
numid=3D39,iface=3DMIXER,name=3D'Limiter1 Attack Threshold (DRC Mode)'
  ; type=3DINTEGER,access=3Drw---R--,values=3D1,min=3D0,max=3D16,step=3D0
  : values=3D9
  | dBrange-
    rangemin=3D3,,rangemax=3D72
      |
    rangemin=3D3,,rangemax=3D72
      |
    rangemin=3D3,,rangemax=3D72
      |
