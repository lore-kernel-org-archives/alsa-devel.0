From: Margarita Olaya <magi@slimlogic.co.uk>
Subject: Re: UCM list/set/get
Date: Mon, 31 Jan 2011 17:44:54 -0600
Message-ID: <AANLkTinbtXS4G0uHYKiu9RRjP8hVEKY53xn6gzGYLZia@mail.gmail.com>
References: <AANLkTi=pwNpK-c+h_xSkiQG8V8nhLZs-9X8+DceDw0S3@mail.gmail.com>
	<20110131112257.GC11937@sirena.org.uk>
	<1296482038.3316.160.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from slimlogic.co.uk (slimlogic.co.uk [89.16.172.20])
	by alsa0.perex.cz (Postfix) with ESMTP id C6C162432C
	for <alsa-devel@alsa-project.org>; Tue,  1 Feb 2011 00:44:58 +0100 (CET)
Received: from mail-qw0-f51.google.com (mail-qw0-f51.google.com
	[209.85.216.51])
	by slimlogic.co.uk (Postfix) with ESMTPSA id 55AD31304DA
	for <alsa-devel@alsa-project.org>; Mon, 31 Jan 2011 23:44:55 +0000 (GMT)
Received: by qwg5 with SMTP id 5so6239620qwg.38
	for <alsa-devel@alsa-project.org>; Mon, 31 Jan 2011 15:44:54 -0800 (PST)
In-Reply-To: <1296482038.3316.160.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>, pl bossart <bossart.nospam@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 31, 2011 at 7:53 AM, Liam Girdwood <lrg@slimlogic.co.uk> wrote:
> On Mon, 2011-01-31 at 11:22 +0000, Mark Brown wrote:
>> On Fri, Jan 28, 2011 at 11:36:47AM -0600, pl bossart wrote:
>> > I've been trying to figure out what exactly needs to be filled in UCM
>> > configuration files, and so far it's been a pretty frustrating
>> > experience with alsa-utils/alsaucm :-(
>>
>> CCing in Liam - please always remember to CC maintainers.
>>
>> > The interactive mode in alsa-utils/alsaucm is broken, I fixed a couple
>> > of segfaults and bad output (patches attached), but so far the only
>> > thing I can do is list the verbs...It looks like
>> > alsa-lib/include/use-case.h and alsa-utils/alsaucm are not aligned,
>> > whenever I query with predefined identifiers alsaucm seg faults or
>> > provides an error message that doesn't help much. This happens with
>> > the latest code.
>
>> >
>> > [ume@plb alsaucm]$ ./alsaucm listcards
>> > =A0 0: AudioPC
>> > =A0 =A0 this is my AudioPCI card
>> > =A0 1: SDP4430
>> > =A0 =A0 this is my SDP4430 card
>> > =A0 2: TestHDA
>> > =A0 =A0 A test HDA card
>> > [ume@plb alsaucm]$ ./alsaucm -c AudioPCI list _verbs
>> > =A0 0: HiFi
>> > =A0 =A0 Play and record HiFi quality Music.
>> > =A0 1: Voice
>> > =A0 =A0 Full duplex low-power voice call
>> >
>> > So far so good. Now the fun begins
>> >
>> > [ume@plb alsaucm]$ ./alsaucm -c AudioPCI list _devices
>> > ./alsaucm: error failed to get list _devices: No such file or directory
>> > [ume@plb alsaucm]$ ./alsaucm -c AudioPCI set _verb HiFi
>> > ALSA lib main.c:1250:(set_verb_user) error: failed to initialize new
>> > use case: HiFi
>> > ./alsaucm: error failed to set _verb=3DHiFi: No such device
>> > [ume@plb alsaucm]$ ./alsaucm -c AudioPCI get _verb
>> > ./alsaucm: error failed to get _verb: No such file or directory
>> >
>
> It looks like we need to improve the config file error reporting here.
> Adding line numbers would be good.
>
>> > Likewise if the .conf file contains a cset in the default values, then
>> > the parser fails (I took the example from src/ucm/parser.c).
>> > Commenting out the cset is the only solution. What exactly is this
>> > index supposed to mean?
>> > SectionDefaults [
>> > cdev "hw:AudioPCI"
>> > cset "name=3D'Master Playback Switch',index=3D2 1,1"
>> > ]
>
> Jaroslav is probably best placed to answer about the cset syntax.
>
> The "index" is not required :-
>
> cset "name=3D'Master Playback Switch' 1,1"
>
>> >
>> > [ume@plb alsaucm]$ ./alsaucm -c AudioPCI list _verbs
>> > ALSA lib main.c:302:(import_master_config) Unable to execute default s=
equence
>> > ALSA lib main.c:637:(snd_use_case_mgr_open) error: failed to import
>> > AudioPCI use case configuration -19
>> > ./alsaucm: error failed to open sound card AudioPCI: No such device
>> >
>> > Ideally I'd like to write an interface between PulseAudio and UCM,
>> > there are existing modules I can reuse to set voice or hifi modes,
>> > depending on what the client roles are. But if I can't make the
>> > examples work I don't think this is going to go anywhere.
>>
>> There's some existing work going on with PulseAudio/UCM integration -
>> Liam, I'd CC in Marga but I don't know what her new address.
>
> I've CC'ed Margarita. She has started some work on PA and UCM
> integration and has some code that can read in the UCM verbs.
>
> Margarita, could you provide a link to your PA git.
>

Here is the link to the  PA git, it has the code that can read the ucm verb=
s.

http://git.slimlogic.co.uk/cgi-bin/cgit.cgi/pulseaudio.git/?h=3D9.20-ucm

If the following ucm command works then you will not have issues with the p=
atch

$ alsaucm YOUR_CARD listv

Regards,
Margarita

> Thanks
>
> Liam
> --
> Freelance Developer, SlimLogic Ltd
> ASoC and Voltage Regulator Maintainer.
> http://www.slimlogic.co.uk
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
