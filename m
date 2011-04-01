From: "Christopher K." <c.krooss@googlemail.com>
Subject: Re: Linux 2.6.38 freeze because of sound/core/pcm_lib.c commit 59ff878ffb26bc0be812ca8295799164f413ae88
Date: Fri, 1 Apr 2011 05:05:54 +0200
Message-ID: <AANLkTi=g6C5T3x-GoncuHNvhZ1r3h8WOjmouYR0JqpFz@mail.gmail.com>
References: <AANLkTin17=rCU4eDGYtnVFZ1ffbUn+var4Q_AQUuGKaw@mail.gmail.com>
	<4D946C73.4090402@ladisch.de>
	<AANLkTinyRqEa_ML47DOqAJU8aLDEA12geiUUrPGjXHrN@mail.gmail.com>
	<4D94F728.60609@silka.with-linux.com>
	<4D952B76.7000201@silka.with-linux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4D952B76.7000201@silka.with-linux.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kelly Anderson <kelly@silka.with-linux.com>
Cc: Clemens Ladisch <clemens@ladisch.de>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> On 03/31/11 15:50, Kelly Anderson wrote:
>>
>> Just to let you know. =C2=A0I'm using a gtx460 also. =C2=A0I haven't=
 had a chance to
>> reboot into the newly patched kernel yet. =C2=A0It is interesting th=
at we both
>> have gtx460's. =C2=A0I have a machine with a gtx430 that doesn't see=
m to exhibit
>> the problem.
>>
>> cat /etc/modprobe.d/snd_hda_intel.conf
>>
>> options snd-hda-intel probe_mask=3D-1,0xa
>>
> OK, I debugged the problem and came up with a solution. =C2=A0The bot=
tom line is
> that it's a problem with a signed to unsigned compare. =C2=A0First th=
e fix:

I can confirm that this patch fixes the issue. Thanks a lot!
