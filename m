From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 1/2] ALSA: ASoC: add STA32X codec driver
Date: Thu, 16 Jun 2011 13:51:04 +0200
Message-ID: <4DF9EE28.80707@metafoo.de>
References: <1308079626-31239-1-git-send-email-zonque@gmail.com>	<1308079626-31239-2-git-send-email-zonque@gmail.com>	<20110615150516.GC2806@opensource.wolfsonmicro.com>	<20110615205329.GA7445@sig21.net>	<4DF9C13A.2000205@metafoo.de>	<BANLkTikfDFrh8Bm24ZbUCk1V3ejrgTDU-w@mail.gmail.com>	<20110616101313.GB5262@opensource.wolfsonmicro.com>	<BANLkTim0DDg2FBzHDESFbgrHyrz-STq=Yg@mail.gmail.com>	<4DF9E4D7.9090309@metafoo.de>	<BANLkTin5VO10e9xAsPfTf-kajq5j5yATtQ@mail.gmail.com>	<4DF9EB3D.3080105@metafoo.de>
	<BANLkTi=c9DAZVMmKqqUOK=3-ChAARYQgvw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailhost.informatik.uni-hamburg.de
	(mailhost.informatik.uni-hamburg.de [134.100.9.70])
	by alsa0.perex.cz (Postfix) with ESMTP id D1F5724333
	for <alsa-devel@alsa-project.org>;
	Thu, 16 Jun 2011 13:52:29 +0200 (CEST)
In-Reply-To: <BANLkTi=c9DAZVMmKqqUOK=3-ChAARYQgvw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On 06/16/2011 01:47 PM, Daniel Mack wrote:
> On Thu, Jun 16, 2011 at 1:38 PM, Lars-Peter Clausen <lars@metafoo.de> wrote:
>> On 06/16/2011 01:26 PM, Daniel Mack wrote:
>>> [...]
>>> Looks different now, but I'd say that's still not what you expected:
>>>
>>> # amixer cget numid=39
>>> numid=39,iface=MIXER,name='Limiter1 Attack Threshold (DRC Mode)'
>>>   ; type=INTEGER,access=rw---R--,values=1,min=0,max=16,step=0
>>>   : values=9
>>>   | dBrange-
>>>     rangemin=3,,rangemax=72
>>>       |
>>>     rangemin=3,,rangemax=72
>>>       |
>>>     rangemin=3,,rangemax=72
>>>       |
>>
>> Ok, looks like the current implementation is completely broken...
>>
>
> Nope, that's not yet it ...
>
>> -               while (idx < size) {
>> +               while (size >= 0) {
Should have been while(size > 0) {
>>                        print_spaces(spaces + 2);
>> -                       printf("rangemin=%i,", tlv[0]);
>> -                       printf(",rangemax=%i\n", tlv[1]);
>> -                       decode_tlv(spaces + 4, tlv + 2, 6 * sizeof(unsigned int));
>> -                       idx += 6 * sizeof(unsigned int);
>> +                       printf("rangemin=%i,", tlv[idx++]);
>> +                       printf(",rangemax=%i\n", tlv[idx++]);
>> +                       decode_tlv(spaces + 4, tlv + idx, 4 * sizeof(unsigned int));
>> +                       idx += 4 * sizeof(unsigned int);
Should have been idx += 4;
>> +                       size -= 6 * sizeof(unsigned int);
>>                }
>>                break;
>>  #endif
