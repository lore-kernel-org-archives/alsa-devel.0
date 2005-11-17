From: =?iso-8859-2?B?QWRhbSBUbGGza2E=?= <atlka@pg.gda.pl>
Subject: Re: Dmix and non SND_PCM_TYPE_HW slaves
Date: Thu, 17 Nov 2005 12:09:39 +0100
Message-ID: <op.s0dtadhrq5yxc3@merlin>
References: <OFB5C60420.D5C0FB76-ON652570BA.00273D48-652570BA.00273D59@flextronicssoftware.com> <437B6D8D.50101@superbug.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; delsp=yes; charset=iso-8859-2
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <437B6D8D.50101@superbug.co.uk>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Dnia 16-11-2005 o 18:34:05 James Courtier-Dutton <James@superbug.co.uk> =20
napisa=B3:

> sameer.kittur@flextronicssoftware.com wrote:
>> Hi all,
>>      Is there a reason why Dmix cannot use a non SND_PCM_TYPE_HW slave=
? =20
>> Is there no way to re-direct the Dmix output to another plugin or an =20
>> external I/O or a filter plugin?
>>  Thanks,
>> Sameer.
>>
>
> Why would you want to do this?
> The purpose of dmix is to simply work around the limitation of the =20
> hardware.
> If you want some other purpose, I would suggest using a sound server =20
> like arts or a different approach altogether like using jackd

He just want to use ALSA :-).
It seems impossible to use default dmix output in case of non hardware =20
slave
or non DMA ring buffer hw device so for some people dmix is a solution
but for some of them it is not. Also there is a problem with some OSS app=
s.

Using jackd on top of ALSA is just wasting resorces. If jackd is so good =
=20
then it should
work directly on top of device driver. ALSA lib is not needed in this cas=
e.

But jackd needs patched kernel, RT priority and jackd-aware applications.
So it is not easy solution anyway. If you are using just a few apps which=
 =20
you
can patch then no problem here. But in case of workstation and WWW =20
browsers,
Flash, Java, Realplayer and some other proprietary apps with no sources =20
(games ;-))
it is really hard. aoss is far from perfect and some apps disable use of =
=20
LD_PRELOAD
so this method is sometimes unusable, kernel OSS emulation is not complet=
e =20
and
not mixing at all (it needs kernel mixing IMHO which is not politically =20
correct :-)).

So where to go - commercial OSS software is doing input/output mixing in =
=20
kernel
and for private use is free of charge. There are some limitations of cour=
se
but its normal.

 From my point of view ALSA API is not much better then OSS.
There are some weak points in both. Programming sound in ALSA needs a =20
little bit
more lines of code then in OSS case. Lack of good doc is a very bad =20
situaction.

You can use many methods to access sound card through ALSA: normal =20
read/write,
memory mapping, calbacks and some mixed modes. I just can't find a doc =20
stating
clearly which mode is the best one in which situaction and how to properl=
y =20
use it.
For example I tested aoss with callbacks but because callbacks use signal=
s =20
which
are disabled by some apps so we have no sound in this case.

Some programs work better with OSS aoss emulation then while directly =20
using ALSA
which means that their ALSA code is bad. Lack of good explanation of =20
proper API
usage is the reason. Source doxygen means not much for me - I know that =20
this parameter
is int and mean period size for example but what period size to use and i=
n =20
which case.
Examples are rather simple and often not explaining what to do in error =20
situactions.
Creators of ALSA should made some good docs - users just don't know enoug=
h =20
to point out
important things. Users Wiki pages are nice but they often present result=
s =20
of user experiments
and no real explanation.

Regards
--=20
Adam Tla=B3ka      mailto:atlka@pg.gda.pl    ^v^ ^v^ ^v^
PGP public key:   finger atlka@sunrise.pg.gda.pl


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
