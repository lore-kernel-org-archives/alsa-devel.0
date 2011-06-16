From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH 1/2] ALSA: ASoC: add STA32X codec driver
Date: Thu, 16 Jun 2011 13:47:41 +0200
Message-ID: <BANLkTi=c9DAZVMmKqqUOK=3-ChAARYQgvw@mail.gmail.com>
References: <1308079626-31239-1-git-send-email-zonque@gmail.com>
	<1308079626-31239-2-git-send-email-zonque@gmail.com>
	<20110615150516.GC2806@opensource.wolfsonmicro.com>
	<20110615205329.GA7445@sig21.net> <4DF9C13A.2000205@metafoo.de>
	<BANLkTikfDFrh8Bm24ZbUCk1V3ejrgTDU-w@mail.gmail.com>
	<20110616101313.GB5262@opensource.wolfsonmicro.com>
	<BANLkTim0DDg2FBzHDESFbgrHyrz-STq=Yg@mail.gmail.com>
	<4DF9E4D7.9090309@metafoo.de>
	<BANLkTin5VO10e9xAsPfTf-kajq5j5yATtQ@mail.gmail.com>
	<4DF9EB3D.3080105@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f51.google.com (mail-pz0-f51.google.com
	[209.85.210.51])
	by alsa0.perex.cz (Postfix) with ESMTP id ABEA2103810
	for <alsa-devel@alsa-project.org>;
	Thu, 16 Jun 2011 13:47:43 +0200 (CEST)
Received: by pzk26 with SMTP id 26so1106466pzk.38
	for <alsa-devel@alsa-project.org>; Thu, 16 Jun 2011 04:47:41 -0700 (PDT)
In-Reply-To: <4DF9EB3D.3080105@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Thu, Jun 16, 2011 at 1:38 PM, Lars-Peter Clausen <lars@metafoo.de> wrote:
> On 06/16/2011 01:26 PM, Daniel Mack wrote:
>> [...]
>> Looks different now, but I'd say that's still not what you expected:
>>
>> # amixer cget numid=3D39
>> numid=3D39,iface=3DMIXER,name=3D'Limiter1 Attack Threshold (DRC Mode)'
>> =A0 ; type=3DINTEGER,access=3Drw---R--,values=3D1,min=3D0,max=3D16,step=
=3D0
>> =A0 : values=3D9
>> =A0 | dBrange-
>> =A0 =A0 rangemin=3D3,,rangemax=3D72
>> =A0 =A0 =A0 |
>> =A0 =A0 rangemin=3D3,,rangemax=3D72
>> =A0 =A0 =A0 |
>> =A0 =A0 rangemin=3D3,,rangemax=3D72
>> =A0 =A0 =A0 |
>
> Ok, looks like the current implementation is completely broken...
>
> diff --git a/amixer/amixer.c b/amixer/amixer.c
> index a177288..3bc6743 100644
> --- a/amixer/amixer.c
> +++ b/amixer/amixer.c
> @@ -517,20 +517,20 @@ static void decode_tlv(unsigned int spaces, unsigne=
d int *tlv, unsigned int tlv_
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
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 idx =3D 0;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (idx < size) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (size >=3D 0) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0print_spaces(spaces + 2);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printf("rangemin=3D%i,", tl=
v[0]);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printf(",rangemax=3D%i\n", =
tlv[1]);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 decode_tlv(spaces + 4, tlv =
+ 2, 6 * sizeof(unsigned int));
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 idx +=3D 6 * sizeof(unsigne=
d int);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printf("rangemin=3D%i,", tl=
v[idx++]);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printf(",rangemax=3D%i\n", =
tlv[idx++]);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 decode_tlv(spaces + 4, tlv =
+ idx, 4 * sizeof(unsigned int));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 idx +=3D 4 * sizeof(unsigne=
d int);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 size -=3D 6 * sizeof(unsign=
ed int);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0#endif

Nope, that's not yet it ...

# amixer cget numid=3D39
numid=3D39,iface=3DMIXER,name=3D'Limiter1 Attack Threshold (DRC Mode)'
  ; type=3DINTEGER,access=3Drw---R--,values=3D1,min=3D0,max=3D16,step=3D0
  : values=3D9
  | dBrange-
    rangemin=3D0,,rangemax=3D7
      | dBscale-min=3D-31.00dB,step=3D2.00dB,mute=3D0
    rangemin=3D0,,rangemax=3D0
      |
    rangemin=3D0,,rangemax=3D0
      |
    rangemin=3D0,,rangemax=3D0
      |
    rangemin=3D0,,rangemax=3D0
      |
    rangemin=3D0,,rangemax=3D0
      |
    rangemin=3D0,,rangemax=3D0
      |
    rangemin=3D0,,rangemax=3D0
      |
    rangemin=3D0,,rangemax=3D0
      |
    rangemin=3D0,,rangemax=3D0
      |
    rangemin=3D0,,rangemax=3D0
      |
    rangemin=3D0,,rangemax=3D0
      |
    rangemin=3D0,,rangemax=3D0
      |
    rangemin=3D0,,rangemax=3D0
      |
    rangemin=3D0,,rangemax=3D0
      |
    rangemin=3D0,,rangemax=3D0
      |
    rangemin=3D0,,rangemax=3D0
      |
    rangemin=3D0,,rangemax=3D0
      |
    rangemin=3D0,,rangemax=3D0
      |
    rangemin=3D0,,rangemax=3D0
      |
    rangemin=3D0,,rangemax=3D0
      |
    rangemin=3D0,,rangemax=3D0
      |
    rangemin=3D0,,rangemax=3D0
      |
    rangemin=3D0,,rangemax=3D0
      |
    rangemin=3D0,,rangemax=3D0
      |
    rangemin=3D0,,rangemax=3D0
      |
    rangemin=3D0,,rangemax=3D0
      |
    rangemin=3D0,,rangemax=3D0
      |
    rangemin=3D0,,rangemax=3D0
      |
    rangemin=3D0,,rangemax=3D0
      |
    rangemin=3D0,,rangemax=3D0
      |
    rangemin=3D0,,rangemax=3D0
      |
    rangemin=3D0,,rangemax=3D0
      |
    rangemin=3D0,,rangemax=3D0
      |
    rangemin=3D0,,rangemax=3D0
      |
    rangemin=3D0,,rangemax=3D0
      |
    rangemin=3D0,,rangemax=3D0
      |
    rangemin=3D0,,rangemax=3D0
      |
    rangemin=3D0,,rangemax=3D0
      |
    rangemin=3D0,,rangemax=3D0
      |
    rangemin=3D0,,rangemax=3D0
      |
    rangemin=3D0,,rangemax=3D0
      |
    rangemin=3D0,,rangemax=3D0
      |
    rangemin=3D0,,rangemax=3D0
      |
    rangemin=3D0,,rangemax=3D0
      |
    rangemin=3D0,,rangemax=3D0
      |
    rangemin=3D0,,rangemax=3D0
      |
    rangemin=3D0,,rangemax=3D0
      |
    rangemin=3D0,,rangemax=3D0
      |
    rangemin=3D0,,rangemax=3D0
      |
    rangemin=3D0,,rangemax=3D0
      |
    rangemin=3D0,,rangemax=3D0
      |
    rangemin=3D0,,rangemax=3D0
      |
    rangemin=3D0,,rangemax=3D0
      |
    rangemin=3D0,,rangemax=3D0
      |
    rangemin=3D0,,rangemax=3D0
      |
    rangemin=3D0,,rangemax=3D0
      |
    rangemin=3D3,,rangemax=3D72
      |
    rangemin=3D-1000,,rangemax=3D300
      |
    rangemin=3D0,,rangemax=3D0
      |
    rangemin=3D0,,rangemax=3D0
      |
    rangemin=3D0,,rangemax=3D0
      |
    rangemin=3D0,,rangemax=3D0
      |
    rangemin=3D0,,rangemax=3D0
      |
    rangemin=3D0,,rangemax=3D0
      |
    rangemin=3D0,,rangemax=3D0
      |
    rangemin=3D0,,rangemax=3D0
      |
    rangemin=3D0,,rangemax=3D0
      |
    rangemin=3D0,,rangemax=3D0
      |
    rangemin=3D0,,rangemax=3D0
      |
    rangemin=3D0,,rangemax=3D0
      |
    rangemin=3D0,,rangemax=3D0
      |
    rangemin=3D0,,rangemax=3D0
      |
    rangemin=3D0,,rangemax=3D0
      |
    rangemin=3D0,,rangemax=3D0
      |
    rangemin=3D0,,rangemax=3D0
      |
    rangemin=3D0,,rangemax=3D0
      |
    rangemin=3D0,,rangemax=3D0
      |
    rangemin=3D0,,rangemax=3D0
      |
    rangemin=3D0,,rangemax=3D0
      |
    rangemin=3D0,,rangemax=3D0
      |
    rangemin=3D0,,rangemax=3D0
      |
    rangemin=3D0,,rangemax=3D0
      |
    rangemin=3D0,,rangemax=3D0
      |
    rangemin=3D0,,rangemax=3D0
      |
    rangemin=3D0,,rangemax=3D0
      |
    rangemin=3D0,,rangemax=3D0
      |
    rangemin=3D0,,rangemax=3D0
      |
    rangemin=3D0,,rangemax=3D0
      |
    rangemin=3D0,,rangemax=3D0
      |
    rangemin=3D0,,rangemax=3D0
      |
    rangemin=3D0,,rangemax=3D0
      |
    rangemin=3D0,,rangemax=3D0
      |
    rangemin=3D0,,rangemax=3D0
      |
    rangemin=3D0,,rangemax=3D0
      |
    rangemin=3D0,,rangemax=3D0
      |
    rangemin=3D0,,rangemax=3D0
      |
    rangemin=3D0,,rangemax=3D0
      |
    rangemin=3D0,,rangemax=3D0
      |
    rangemin=3D0,,rangemax=3D0
      |
    rangemin=3D0,,rangemax=3D0
      |
    rangemin=3D0,,rangemax=3D0
      |
    rangemin=3D0,,rangemax=3D0
      |
    rangemin=3D0,,rangemax=3D0
      |
    rangemin=3D0,,rangemax=3D0
      |
    rangemin=3D0,,rangemax=3D0
      |
    rangemin=3D0,,rangemax=3D0
      |
    rangemin=3D0,,rangemax=3D0
      |
    rangemin=3D0,,rangemax=3D0
      |
    rangemin=3D0,,rangemax=3D0
      |
    rangemin=3D0,,rangemax=3D0
      |
    rangemin=3D0,,rangemax=3D0
      |
    rangemin=3D0,,rangemax=3D0
      |
    rangemin=3D0,,rangemax=3D0
      |
    rangemin=3D0,,rangemax=3D0
      |
    rangemin=3D0,,rangemax=3D0
      |
    rangemin=3D0,,rangemax=3D0
      |
    rangemin=3D0,,rangemax=3D0
      |
    rangemin=3D0,,rangemax=3D0
      |
    rangemin=3D0,,rangemax=3D0
      |
    rangemin=3D0,,rangemax=3D0
      |
    rangemin=3D0,,rangemax=3D0
      |
    rangemin=3D0,,rangemax=3D0
      |
    rangemin=3D0,,rangemax=3D0
      |
    rangemin=3D0,,rangemax=3D0
      |
    rangemin=3D0,,rangemax=3D0
      |
    rangemin=3D0,,rangemax=3D0
      |
    rangemin=3D0,,rangemax=3D0
      |
    rangemin=3D0,,rangemax=3D0
      |
    rangemin=3D0,,rangemax=3D0
      |
    rangemin=3D0,,rangemax=3D0
      |
    rangemin=3D0,,rangemax=3D0
      |
    rangemin=3D0,,rangemax=3D0
      |
    rangemin=3D0,,rangemax=3D0
      |
    rangemin=3D0,,rangemax=3D0
      |
Segmentation fault
