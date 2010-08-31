From: Martin Wolf <mwolf@adiumentum.com>
Subject: Re: problem with bisecting a bug in the alsa driver
Date: Tue, 31 Aug 2010 21:09:55 +0200
Message-ID: <4C7D5383.1090306@adiumentum.com>
References: <4C7A8375.3000009@adiumentum.com>	<alpine.LNX.2.00.1008291805250.10278@eeebox2.perex-int.cz>	<4C7A9067.8090809@adiumentum.com>	<alpine.LNX.2.00.1008291926590.10278@eeebox2.perex-int.cz>
	<4C7A9FE9.5090500@adiumentum.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adiumentum.com (adiumentum.com [83.142.83.186])
	by alsa0.perex.cz (Postfix) with ESMTP id 5C537103818
	for <alsa-devel@alsa-project.org>;
	Tue, 31 Aug 2010 21:10:03 +0200 (CEST)
Received: from [127.0.0.1] (p4FFE4491.dip.t-dialin.net [79.254.68.145])
	by adiumentum.com (Postfix) with ESMTPSA id 8138F4400A0
	for <alsa-devel@alsa-project.org>;
	Tue, 31 Aug 2010 21:10:01 +0200 (CEST)
In-Reply-To: <4C7A9FE9.5090500@adiumentum.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

 can you send me a working .config file for bisecting the kernel?
my system contains a P35 chipset core2duo
ext4 filesystem
ahci sata
intel hd audio (here is the problem)

because if i use the standard ubuntu 10.04 settings it takes ages to
compile...

Am 29.08.2010 19:59, schrieb Martin:
> i also tried with
>
>   bdl_pos_adj=3D256
>
> the "error" in the last line went away but the crackling is still there
>
> Am 29.08.2010 19:28, schrieb Jaroslav Kysela:
>> On Sun, 29 Aug 2010, Martin wrote:
>>
>>    =

>>> hi,
>>>
>>> thanks for the quick help.
>>> here is the diff.txt
>>>      =

>> I would try to play with these two module parameters:
>>
>>           bdl_pos_adj : 1,-1,-1,-1,-1,-1,-1,-1
>>           enable_msi : -1
>>
>> Try to set 'enable_msi=3D0' and 'bdl_pos_adj=3D16' for the snd-hda-intel
>> module.
>>
>>   						Jaroslav
>>
>> -----
>> Jaroslav Kysela<perex@perex.cz>
>> Linux Kernel Sound Maintainer
>> ALSA Project, Red Hat, Inc.
>>
>> _______________________________________________
>> Alsa-devel mailing list
>> Alsa-devel@alsa-project.org
>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>>    =

> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel


-- =

Adiumentum GmbH
Gf. Martin Wolf
Banderbacherstra=DFe 76
90513 Zirndorf

0911 / 9601470
mwolf@adiumentum.com
