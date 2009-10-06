From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH] ascenario: Add scenario support to alsa-lib
Date: Tue, 6 Oct 2009 10:23:56 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.0910060949070.31529@eeebox2.perex-int.cz>
References: <1254390436-5283-1-git-send-email-stefan@datenfreihafen.org>
	<1254390436-5283-2-git-send-email-stefan@datenfreihafen.org>
	<20091001122835.GC14417@sirena.org.uk>
	<20091001131948.GA5936@excalibur.local>
	<20091001150849.GE5936@excalibur.local>
	<20091005082747.GA3983@excalibur.local>
	<alpine.LNX.2.00.0910051111220.31529@eeebox2.perex-int.cz>
	<20091005093502.GC3983@excalibur.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 7EE9D1038D7
	for <alsa-devel@alsa-project.org>;
	Tue,  6 Oct 2009 10:23:57 +0200 (CEST)
In-Reply-To: <20091005093502.GC3983@excalibur.local>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stefan Schmidt <stefan@datenfreihafen.org>
Cc: Graeme Gregory <gg@slimlogic.co.uk>, ALSA development <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Ian Molton <ian@mnementh.co.uk>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Hi,

 	Some ideas, proposal for further discussion...

On Mon, 5 Oct 2009, Stefan Schmidt wrote:

> Hello.
>
> On Mon, 2009-10-05 at 11:14, Jaroslav Kysela wrote:
>> On Mon, 5 Oct 2009, Stefan Schmidt wrote:
>>
>>> On Thu, 2009-10-01 at 17:08, Stefan Schmidt wrote:
>>>>
>>>> For an updated patch with all your comments inlcuded see below.
>>>
>>> Here is another update on this patch. Fixed a problem I introduced in the last
>>> iteration and changed the config tokens from MasterPlaybackVolume to Master
>>> Playback Volume, etc. That's based on a siggestion from Mark which we had
>>> offlist. Let me quote it here to explain the good reasoning behind it.
>>
>> Question: What's the IDs (integers) returned with
>> snd_scenario_get_master_playback_volume() etc. functions?
>
> That is part of the code Liam wrote, but let me answer it (and maybe 
> Liam chime in if it is wrong or needs more explanation).
>
> It's just the numid of an alsa control which should be used as master 
> playback, etc in this scenario. It aliases the function we can use with 
> ascenario to the real ones in alsa which can bedifferent for different 
> scenarios.

It's not very clear. The exported functions should be documented at least 
with doxygen.

Also, I would move all _get_ functions to one with this interface:

#define SND_SCENARIO_KEY_KCTL_MASTER_PLAYBACK_VOLUME	1
.....

int snd_scenario_get(scenario, int key, void *result);

It will allow us to extend this interface without adding many functions in 
future, something like:

#define SND_SCENARIO_KEY_PCM_PLAYBACK			11
.....

Also, using numid's is not much ideal if something changes in the driver. 
I would prefer to use standard ctl IDs (string, index, interface - 
result should be snd_ctl_elem_id_t).

>> Please, include also some test configuration files to review the
>> configurationsyntax.
>
> Attached. default.conf is the main configuration file located at
> /etc/alsa/scenario/default.conf

Again, I would make configuration syntax compatible with other alsa-lib 
configuration files. The changes in the configuration files will be small 
and it will allow us to rewrite the code using parsers in alsa-lib.

Something like:

default.conf:

scenario."playback speaker" {
   file playback_spk
   qos HIFI
   "Master Playback Volume" 8
# should be rather something like:
   kcontrol.'Master Playback Volume' "'Master Playback Volume':33"
# or a short form might be implemented (:33 is ctl_id index, ctl_id.name
# would be copied from the variable key name):
   kcontrol.'Master Playback Volume' ":33"
   ...
}

scenario."playback headphones" {
   ...
}

About "playback_hs_*" files. It seems that the purpose of files is quite 
similar. I don't understand the reason to have 2 different descriptions.

Also, I would like to consider moving the parser from alsactl 
initialization code (see alsactl_init.c in alsa-utils package) to alsa-lib 
and use this parser also for these files. It gives much flexibility, 
although udev-like syntax is not ideal, I know. But we have full 
documentation in alsactl_init.xml, at least.

 						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
