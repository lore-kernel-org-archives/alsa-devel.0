From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH 1/2] ALSA: ASoC: add STA32X codec driver
Date: Thu, 16 Jun 2011 13:54:51 +0200
Message-ID: <BANLkTi=kzFjqz=aA-MtZEeTgAEKFKzubWw@mail.gmail.com>
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
	<BANLkTi=c9DAZVMmKqqUOK=3-ChAARYQgvw@mail.gmail.com>
	<4DF9EE28.80707@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f51.google.com (mail-pz0-f51.google.com
	[209.85.210.51]) by alsa0.perex.cz (Postfix) with ESMTP id 425DC2415E
	for <alsa-devel@alsa-project.org>;
	Thu, 16 Jun 2011 13:54:53 +0200 (CEST)
Received: by pzk26 with SMTP id 26so1109954pzk.38
	for <alsa-devel@alsa-project.org>; Thu, 16 Jun 2011 04:54:51 -0700 (PDT)
In-Reply-To: <4DF9EE28.80707@metafoo.de>
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

On Thu, Jun 16, 2011 at 1:51 PM, Lars-Peter Clausen <lars@metafoo.de> wrote:
> On 06/16/2011 01:47 PM, Daniel Mack wrote:
>> On Thu, Jun 16, 2011 at 1:38 PM, Lars-Peter Clausen <lars@metafoo.de> wr=
ote:
>>> On 06/16/2011 01:26 PM, Daniel Mack wrote:
>>>> [...]
>>>> Looks different now, but I'd say that's still not what you expected:
>>>>
>>>> # amixer cget numid=3D39
>>>> numid=3D39,iface=3DMIXER,name=3D'Limiter1 Attack Threshold (DRC Mode)'
>>>> =A0 ; type=3DINTEGER,access=3Drw---R--,values=3D1,min=3D0,max=3D16,ste=
p=3D0
>>>> =A0 : values=3D9
>>>> =A0 | dBrange-
>>>> =A0 =A0 rangemin=3D3,,rangemax=3D72
>>>> =A0 =A0 =A0 |
>>>> =A0 =A0 rangemin=3D3,,rangemax=3D72
>>>> =A0 =A0 =A0 |
>>>> =A0 =A0 rangemin=3D3,,rangemax=3D72
>>>> =A0 =A0 =A0 |
>>>
>>> Ok, looks like the current implementation is completely broken...
>>>
>>
>> Nope, that's not yet it ...
>>
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (idx < size) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (size >=3D 0) {
> Should have been while(size > 0) {
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0print_spaces(spaces + 2);
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printf("rangemin=3D%i,", =
tlv[0]);
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printf(",rangemax=3D%i\n"=
, tlv[1]);
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 decode_tlv(spaces + 4, tl=
v + 2, 6 * sizeof(unsigned int));
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 idx +=3D 6 * sizeof(unsig=
ned int);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printf("rangemin=3D%i,", =
tlv[idx++]);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printf(",rangemax=3D%i\n"=
, tlv[idx++]);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 decode_tlv(spaces + 4, tl=
v + idx, 4 * sizeof(unsigned int));
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 idx +=3D 4 * sizeof(unsig=
ned int);
> Should have been idx +=3D 4;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 size -=3D 6 * sizeof(unsi=
gned int);
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
>>> =A0#endif

# amixer cget numid=3D39
numid=3D39,iface=3DMIXER,name=3D'Limiter1 Attack Threshold (DRC Mode)'
  ; type=3DINTEGER,access=3Drw---R--,values=3D1,min=3D0,max=3D16,step=3D0
  : values=3D9
  | dBrange-
    rangemin=3D0,,rangemax=3D7
      | dBscale-min=3D-31.00dB,step=3D2.00dB,mute=3D0
    rangemin=3D8,,rangemax=3D13
      | dBscale-min=3D-16.00dB,step=3D1.00dB,mute=3D0
    rangemin=3D14,,rangemax=3D16
      | dBscale-min=3D-10.00dB,step=3D3.00dB,mute=3D0

Great. Thanks a lot!

Daniel
