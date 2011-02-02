From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: UCM list/set/get
Date: Wed, 2 Feb 2011 09:11:57 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1102020909000.6272@eeebox2.perex-int.cz>
References: <AANLkTi=pwNpK-c+h_xSkiQG8V8nhLZs-9X8+DceDw0S3@mail.gmail.com>
	<20110131112257.GC11937@sirena.org.uk>
	<1296482038.3316.160.camel@odin>
	<AANLkTinbtXS4G0uHYKiu9RRjP8hVEKY53xn6gzGYLZia@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-306721100-1296634317=:6272"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 8699C10380E
	for <alsa-devel@alsa-project.org>; Wed,  2 Feb 2011 09:11:57 +0100 (CET)
In-Reply-To: <AANLkTinbtXS4G0uHYKiu9RRjP8hVEKY53xn6gzGYLZia@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Margarita Olaya <magi@slimlogic.co.uk>
Cc: pl bossart <bossart.nospam@gmail.com>, ALSA development <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-306721100-1296634317=:6272
Content-Type: TEXT/PLAIN; charset=UTF-8; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 31 Jan 2011, Margarita Olaya wrote:

> On Mon, Jan 31, 2011 at 7:53 AM, Liam Girdwood <lrg@slimlogic.co.uk> wrot=
e:
>> On Mon, 2011-01-31 at 11:22 +0000, Mark Brown wrote:
>>> On Fri, Jan 28, 2011 at 11:36:47AM -0600, pl bossart wrote:
>>>> I've been trying to figure out what exactly needs to be filled in UCM
>>>> configuration files, and so far it's been a pretty frustrating
>>>> experience with alsa-utils/alsaucm :-(
>>>
>>> CCing in Liam - please always remember to CC maintainers.
>>>
>>>> The interactive mode in alsa-utils/alsaucm is broken, I fixed a couple
>>>> of segfaults and bad output (patches attached), but so far the only
>>>> thing I can do is list the verbs...It looks like
>>>> alsa-lib/include/use-case.h and alsa-utils/alsaucm are not aligned,
>>>> whenever I query with predefined identifiers alsaucm seg faults or
>>>> provides an error message that doesn't help much. This happens with
>>>> the latest code.
>>
>>>>
>>>> [ume@plb alsaucm]$ ./alsaucm listcards
>>>> =C2=A0 0: AudioPC
>>>> =C2=A0 =C2=A0 this is my AudioPCI card
>>>> =C2=A0 1: SDP4430
>>>> =C2=A0 =C2=A0 this is my SDP4430 card
>>>> =C2=A0 2: TestHDA
>>>> =C2=A0 =C2=A0 A test HDA card
>>>> [ume@plb alsaucm]$ ./alsaucm -c AudioPCI list _verbs
>>>> =C2=A0 0: HiFi
>>>> =C2=A0 =C2=A0 Play and record HiFi quality Music.
>>>> =C2=A0 1: Voice
>>>> =C2=A0 =C2=A0 Full duplex low-power voice call
>>>>
>>>> So far so good. Now the fun begins
>>>>
>>>> [ume@plb alsaucm]$ ./alsaucm -c AudioPCI list _devices
>>>> ./alsaucm: error failed to get list _devices: No such file or director=
y
>>>> [ume@plb alsaucm]$ ./alsaucm -c AudioPCI set _verb HiFi
>>>> ALSA lib main.c:1250:(set_verb_user) error: failed to initialize new
>>>> use case: HiFi
>>>> ./alsaucm: error failed to set _verb=3DHiFi: No such device
>>>> [ume@plb alsaucm]$ ./alsaucm -c AudioPCI get _verb
>>>> ./alsaucm: error failed to get _verb: No such file or directory
>>>>
>>
>> It looks like we need to improve the config file error reporting here.
>> Adding line numbers would be good.
>>
>>>> Likewise if the .conf file contains a cset in the default values, then
>>>> the parser fails (I took the example from src/ucm/parser.c).
>>>> Commenting out the cset is the only solution. What exactly is this
>>>> index supposed to mean?
>>>> SectionDefaults [
>>>> cdev "hw:AudioPCI"
>>>> cset "name=3D'Master Playback Switch',index=3D2 1,1"
>>>> ]
>>
>> Jaroslav is probably best placed to answer about the cset syntax.
>>
>> The "index" is not required :-
>>
>> cset "name=3D'Master Playback Switch' 1,1"
>>
>>>>
>>>> [ume@plb alsaucm]$ ./alsaucm -c AudioPCI list _verbs
>>>> ALSA lib main.c:302:(import_master_config) Unable to execute default s=
equence
>>>> ALSA lib main.c:637:(snd_use_case_mgr_open) error: failed to import
>>>> AudioPCI use case configuration -19
>>>> ./alsaucm: error failed to open sound card AudioPCI: No such device
>>>>
>>>> Ideally I'd like to write an interface between PulseAudio and UCM,
>>>> there are existing modules I can reuse to set voice or hifi modes,
>>>> depending on what the client roles are. But if I can't make the
>>>> examples work I don't think this is going to go anywhere.
>>>
>>> There's some existing work going on with PulseAudio/UCM integration -
>>> Liam, I'd CC in Marga but I don't know what her new address.
>>
>> I've CC'ed Margarita. She has started some work on PA and UCM
>> integration and has some code that can read in the UCM verbs.
>>
>> Margarita, could you provide a link to your PA git.
>>
>
> Here is the link to the  PA git, it has the code that can read the ucm ve=
rbs.
>
> http://git.slimlogic.co.uk/cgi-bin/cgit.cgi/pulseaudio.git/?h=3D9.20-ucm
>
> If the following ucm command works then you will not have issues with the=
 patch
>
> $ alsaucm YOUR_CARD listv
>
> Regards,
> Margarita

This patch does not use the released UCM API in alsa-lib. Also, more work=
=20
is required to separate ALSA card from UCM card (to support virtual or=20
mixed "soundcards").

 =09=09=09=09=09Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.

--8323584-306721100-1296634317=:6272
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--8323584-306721100-1296634317=:6272--
