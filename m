From: Joern Nettingsmeier <nettings@folkwang-hochschule.de>
Subject: Re: sequencer: handling non-registered parameter numbers....
Date: Thu, 19 Jun 2003 11:17:54 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3EF17FC2.8070808@folkwang-hochschule.de>
References: <Pine.LNX.4.44.0306161803330.11284-200000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0306161803330.11284-200000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela wrote:
> On Mon, 16 Jun 2003, Joern Nettingsmeier wrote:
>=20
>=20
>>Jaroslav Kysela wrote:
>>
>>>On Mon, 16 Jun 2003, Jaroslav Kysela wrote:
>>>
>>>
>>>
>>>>>thanks for the clarification. i'd be glad to help, but i doubt i cou=
ld=20
>>>>>meet the coding standards of alsa-lib. at least i could help test it=
=2E
>>>>>do you or anyone of the alsa core developers have plans to tackle th=
is=20
>>>>>some time soon ? i'd love to be able to use my controller box for th=
e=20
>>>>>LinuxTag presentations in mid-July.
>>>>
>>>>I am working on it right now, but it requires to add new states to=20
>>>>sequencer event encoder...
>>>
>>>
>>>Initial code is in CVS. It is not tested, but hopefully, without any m=
ajor=20
>>>bugs. It seems that we have also missing encoding of CONTROL14 events.=

>>>
>>>						Jaroslav
>>
>>shit. anon cvs seems to be lagging behind. do you happen to have a patc=
h=20
>>? otherwise it will probably be another day before i can test it...
>=20
>=20
> Attached.

hi jaroslav !

i've read and tried to understand the patch... now since this is against =

alsa-core, how am i supposed to test it, since it's not in alsa-lib ?
i read some files in alsa-lib, and it seems a lot of code in alsa-core=20
is duplicated there. i played around a bit, but i couldn't figure out=20
how to make the new alsa-core functions available to alsa-lib...

is there some (dirty) way to use the alsa-core api directly for testing?
(sorry for such elementary questions, but i'm really green and alsa is a =

frightening thing for beginners :)

btw, current (anonymous) cvs is broken, there are a number of warnings=20
related to alsa-kernel/core/seq/seq_midi_event.c and the nrpn functions..=
=2E

best regards,

j=F6rn


--=20
All Members shall refrain in their international relations from
the threat or use of force against the territorial integrity or
political independence of any state, or in any other manner
inconsistent with the Purposes of the United Nations.
	-- Charter of the United Nations, Article 2.4


J=F6rn Nettingsmeier
Kurf=FCrstenstr 49, 45138 Essen, Germany
http://spunk.dnsalias.org (my server)
http://www.linuxdj.com/audio/lad/ (Linux Audio Developers)






-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers & Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
