From: =?ISO-8859-2?Q?Adam_Tla=B3ka?= <atlka@pg.gda.pl>
Subject: Re: Re: [Alsa-user] AD1985 full-duplex(?)
Date: Sun, 29 Aug 2004 20:35:53 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <41322209.70900@pg.gda.pl>
References: <Pine.HPX.4.33n.0408181538550.24798-100000@studcom.urz.uni-halle.de> <1092842830.13603.3.camel@localhost.localdomain> <20040818181350.2b38e875@mango.fruits.de> <Pine.LNX.4.58.0408181918160.1769@pnote.perex-int.cz> <20040818201535.1f49a128@mango.fruits.de> <Pine.LNX.4.58.0408191050220.1779@pnote.perex-int.cz> <s5h8ycbv4s9.wl@alsa2.suse.de> <Pine.LNX.4.58.0408191225170.1779@pnote.perex-int.cz> <4129D6A2.7020801@pg.gda.pl> <s5hoel1hny9.wl@alsa2.suse.de> <4130D8BF.8030502@pg.gda.pl> <Pine.LNX.4.58.0408291135330.1778@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from sunrise.pg.gda.pl (sunrise.pg.gda.pl [153.19.40.230])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 2F96123F
	for <alsa-devel@alsa-project.org>; Sun, 29 Aug 2004 20:36:47 +0200 (MEST)
Received: from pg.gda.pl (host-ip149-240.crowley.pl [62.111.240.149])
	(authenticated bits=0)
	by sunrise.pg.gda.pl (8.12.11/8.12.11) with ESMTP id i7TIaaUZ012436
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <alsa-devel@alsa-project.org>; Sun, 29 Aug 2004 20:36:43 +0200 (CEST)
In-Reply-To: <Pine.LNX.4.58.0408291135330.1778@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

[2004-08-29 11:54] Jaroslav Kysela:
> On Sat, 28 Aug 2004, Adam Tla=B3ka wrote:
>=20
>=20
>>I imagine sound system as some layered structure:
>>
>>program
>>|
>>v
>>dev -> redirecting, routing and up/down mixing kernel layer
>>                |                                           |
>>                v                                           v
>>           kernel device driver                       net
>>                |
>>                v
>>           hardware
>=20
>=20
> It's kernel centristic view. I don't see much reasons to have everythin=
g=20
> in kernel.
Because of latency issues and need for direct access to hardware
it's sometimes better to have this functions in kernel - if card
can mix in hardware N streams use that feature for N streams but if you=20
need N+1
then you must do it in software. If again streams count lowers to N you=20
should
return to hardware mixing. I can't see this is possible with current=20
ALSA dmix
plugin.

> What about this direct way: program -> alsa-lib -> net ?
> I proposed network driver mainly to solve OSS redirecting problems.
> We can implement this driver completely in user space.
OK it was my error - bad spaceing - you are right.

>>No mixer calls on dsp stream,
> Huh, that's new for me. It does not work? It's implemented.
Maybe with kernel emulation, but not in aoss.

>>no multichannel streams (4...7.1) are possible with OSS emulation,
> Additional information which is moved to alsa-lib is required. Anyway,
> actually almost all new applications requiring this feature support ALS=
A.
OK, but OSS compability is not full.

>>DMA mode broken. I just can't abandon using OSS because of that :-(.
> Could you specify which is broken with the kernel ALSA's OSS mmap=20
> emulation?
I am not using kernel module. I am using patched aoss lib and dmix plugin=
.
I think that we should carefully read OSS pdf doc and look at the OSS
emulation code to find which is not compatible with documented original
OSS behaviour.
As I can tell there is one thing according to DMA mode - buffer size and
number of periods. In original OSS for example GETOSPACE call reports
these values and after that call or any of GETxPTR, GETxDELAY, read
or write operation these values are fixed. So if an app read buffer size
and num of periods first and then sets stream parameters (format, stereo,
rate) buffer size and num of periods are not changed - in original OSS.
If we changing parameters using ALSA lib buffer size and num of periods=20
could
change so if we now have different OSS values some apps just broke.
OK - this app behaviour is not quite correct - it should set stream=20
parameters
first and ask about buffer size after that. But this is an original OSS=20
documented
behaviour so it should be supported.

> Note that the direct device access is the major problem with the OSS AP=
I.
I don't think so. You don't need to link an app with any additional=20
libraries
and these device open, read, write, select, poll and ioctl are just norma=
l
Unix filesystem calls. We only should have kernel module which could=20
redirect
data stream and control to user space (maybe RT) daemon which does the re=
st.

program -> OSS dev -> redirector module -> special RT daemon -> alsa lib=20
-> card

> If a library which hide the direct syscalls exists, we never had such=20
> problems to redirect OSS calls to our code. The library can be very=20
> small.
But we have some closed source proprietary apps which should work too.

> I feel that it's mainly about fixing bugs. Unfortunately, most of users
> (including you) point me to quake binaries. I cannot run them on my
> machines.
Hmm, I am frequently testing aoss with quake.x11 (quake1) binary which=20
is plain X11
app - no OpenGL. I don't now how is accesible quake2 in your country
but I just bought cheap CD with full version in some multimedia store.
quake1 and quake2 program sources are accesible on the net.

> Anyway, this call is to all people on this list. Could you create a Wik=
i
> page which exact (version, source URL) OSS applications have trouble wi=
th:
>=20
> 1) ALSA's kernel OSS emulation
> 2) ALSA's aoss (libaoss)
OK if I find some time and test this more I write some info.

Regards
--=20
Adam Tla/lka      mailto:atlka@pg.gda.pl    ^v^ ^v^ ^v^
System  & Network Administration Group           ~~~~~~
Computer Center,  Gdansk University of Technology, Poland
PGP public key:   finger atlka@sunrise.pg.gda.pl


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
