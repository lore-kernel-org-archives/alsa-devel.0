From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: UCM list/set/get
Date: Mon, 31 Jan 2011 11:22:57 +0000
Message-ID: <20110131112257.GC11937@sirena.org.uk>
References: <AANLkTi=pwNpK-c+h_xSkiQG8V8nhLZs-9X8+DceDw0S3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 261912449A
	for <alsa-devel@alsa-project.org>; Mon, 31 Jan 2011 12:22:59 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <AANLkTi=pwNpK-c+h_xSkiQG8V8nhLZs-9X8+DceDw0S3@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: pl bossart <bossart.nospam@gmail.com>
Cc: alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 28, 2011 at 11:36:47AM -0600, pl bossart wrote:
> I've been trying to figure out what exactly needs to be filled in UCM
> configuration files, and so far it's been a pretty frustrating
> experience with alsa-utils/alsaucm :-(

CCing in Liam - please always remember to CC maintainers.

> The interactive mode in alsa-utils/alsaucm is broken, I fixed a couple
> of segfaults and bad output (patches attached), but so far the only
> thing I can do is list the verbs...It looks like
> alsa-lib/include/use-case.h and alsa-utils/alsaucm are not aligned,
> whenever I query with predefined identifiers alsaucm seg faults or
> provides an error message that doesn't help much. This happens with
> the latest code.
> 
> [ume@plb alsaucm]$ ./alsaucm listcards
>   0: AudioPC
>     this is my AudioPCI card
>   1: SDP4430
>     this is my SDP4430 card
>   2: TestHDA
>     A test HDA card
> [ume@plb alsaucm]$ ./alsaucm -c AudioPCI list _verbs
>   0: HiFi
>     Play and record HiFi quality Music.
>   1: Voice
>     Full duplex low-power voice call
> 
> So far so good. Now the fun begins
> 
> [ume@plb alsaucm]$ ./alsaucm -c AudioPCI list _devices
> ./alsaucm: error failed to get list _devices: No such file or directory
> [ume@plb alsaucm]$ ./alsaucm -c AudioPCI set _verb HiFi
> ALSA lib main.c:1250:(set_verb_user) error: failed to initialize new
> use case: HiFi
> ./alsaucm: error failed to set _verb=HiFi: No such device
> [ume@plb alsaucm]$ ./alsaucm -c AudioPCI get _verb
> ./alsaucm: error failed to get _verb: No such file or directory
> 
> Likewise if the .conf file contains a cset in the default values, then
> the parser fails (I took the example from src/ucm/parser.c).
> Commenting out the cset is the only solution. What exactly is this
> index supposed to mean?
> SectionDefaults [
> cdev "hw:AudioPCI"
> cset "name='Master Playback Switch',index=2 1,1"
> ]
> 
> [ume@plb alsaucm]$ ./alsaucm -c AudioPCI list _verbs
> ALSA lib main.c:302:(import_master_config) Unable to execute default sequence
> ALSA lib main.c:637:(snd_use_case_mgr_open) error: failed to import
> AudioPCI use case configuration -19
> ./alsaucm: error failed to open sound card AudioPCI: No such device
> 
> Ideally I'd like to write an interface between PulseAudio and UCM,
> there are existing modules I can reuse to set voice or hifi modes,
> depending on what the client roles are. But if I can't make the
> examples work I don't think this is going to go anywhere.

There's some existing work going on with PulseAudio/UCM integration -
Liam, I'd CC in Marga but I don't know what her new address.
