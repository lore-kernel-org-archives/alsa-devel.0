From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [Sound-open-firmware] Signed firmware availability
	for kbl/cnl
Date: Wed, 24 Jul 2019 18:23:38 +0200
Message-ID: <8dceb60b-35a5-93e9-ce01-1eb852e93f44@perex.cz>
References: <CAD8Lp45Bp1xVC7NjuNaANA7kAEN2Edshw+cViaTF3tRZEumgZA@mail.gmail.com>
 <cc9fa5b52138daffb09dc5b66ea9248379c9f60e.camel@linux.intel.com>
 <CAD8Lp46GW8n8K7ttOeSje_au06BsyvCp4seVwj2wNbipei5ssA@mail.gmail.com>
 <a4b17a75-d4e0-fc6b-a286-aa6b7b281b7d@linux.intel.com>
 <CAD8Lp444soO1i8mWF73eucT16yAhy2js1byWJCTV5fn=TikHBg@mail.gmail.com>
 <9e8b667f1aa2333dbcc34b5253372d1a8667551e.camel@linux.intel.com>
 <ee34f820-0753-dfbe-09c0-7147cf229cc0@perex.cz>
 <6493f195-eb5a-1a6d-2c31-e3a4123b2ad1@linux.intel.com>
 <7c940d90-297e-19c0-2f74-1843439d5ccf@perex.cz>
 <d41b02286db2a827648d1c1ec793bbd0a55e99c1.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <d41b02286db2a827648d1c1ec793bbd0a55e99c1.camel@linux.intel.com>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Daniel Drake <drake@endlessm.com>
Cc: Jian-Hong Pan <jian-hong@endlessm.com>, ALSA development <alsa-devel@alsa-project.org>, sound-open-firmware@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Dne 24. 07. 19 v 18:09 Liam Girdwood napsal(a):
> On Wed, 2019-07-24 at 18:00 +0200, Jaroslav Kysela wrote:
>> Dne 24. 07. 19 v 16:41 Pierre-Louis Bossart napsal(a):
>>> On 7/24/19 8:59 AM, Jaroslav Kysela wrote:
>>>> Dne 23. 07. 19 v 16:22 Liam Girdwood napsal(a):
>>>>> On Thu, 2019-07-18 at 16:43 +0800, Daniel Drake
>>>>> wrote:_______________________________________________
>>>>>> Sound-open-firmware mailing list
>>>>>> Sound-open-firmware@alsa-project.org
>>>>>>
>>>>> https://mailman.alsa-project.org/mailman/listinfo/sound-open-firmware
>>>>>
>>>>>> On Wed, Jul 17, 2019 at 8:09 AM Pierre-Louis Bossart
>>>>>> <pierre-louis.bossart@linux.intel.com>
>>>>>> wrote:_______________________________________________
>>>>>>> Sound-open-firmware mailing list
>>>>>>> Sound-open-firmware@alsa-project.org
>>>>>>>
>>>>>> https://mailman.alsa-project.org/mailman/listinfo/sound-open-firmware
>>>>>>
>>>>>>> I was indeed told a while ago that there was a limited
>>>>>>> number of
>>>>>>> KBL-based devices with DMIC, but mistakenly assumed we
>>>>>>> could avoid
>>>>>>> dealing with this configuration and Murphy's Law applied of
>>>>>>> course.
>>>>>>> we'll have to huddle with our Intel colleagues to figure
>>>>>>> this one
>>>>>>> out.
>>>>>>
>>>>>> OK, thanks.
>>>>>>
>>>>>> Is there any update on the release of signed firmware files
>>>>>> for the
>>>>>> other platforms? We are under pressure to return the other
>>>>>> unit we
>>>>>> have to the vendor (which needs the cnl files), but we would
>>>>>> like to
>>>>>> try SOF first.
>>>>>>
>>>>>
>>>>> Apologies for the delay, I hurt my back and was off work for a
>>>>> few
>>>>> weeks. Signed binaries now on v1.3 github release tag. Will now
>>>>> be
>>>>> upstreaming into Linux FW repo.
>>>>
>>>> Liam, the sizes of signed firmware binaries are a lot different
>>>> than the
>>>> unsigned ones (v1.3 tag) which I can build in docker:
>>>>
>>>> -rw-rw-r--. 1 perex perex 270336 Jul 24 15:44 sof-apl-signed-
>>>> intel.ri
>>>> -rw-r--r--. 1 perex perex 167936 Jul 24 15:44 sof-apl.ri
>>>> -rw-rw-r--. 1 perex perex 278528 Jul 24 15:44 sof-cnl-signed-
>>>> intel.ri
>>>> -rw-r--r--. 1 perex perex 172032 Jul 24 15:44 sof-cnl.ri
>>>> -rw-rw-r--. 1 perex perex 278528 Jul 24 15:44 sof-icl-signed-
>>>> intel.ri
>>>> -rw-r--r--. 1 perex perex 172032 Jul 24 15:44 sof-icl.ri
>>>>
>>>> Is that ok?
>>>
>>> The firmware used for production is typically built with the
>>> Cadence 
>>> tools, which unfortunately are not available publicly (but can be
>>> made 
>>> available to Intel partners). It wouldn't be surprising if the code
>>> size 
>>> was different due to the use of intrinsics (though 100K seems like
>>> a lot 
>>> indeed).
>>>
>>> Liam, I think we ought to release binaries with the community key
>>> as 
>>> well so that people can use them as is, e.g. on the Up2 board which
>>> does 
>>> not require the Intel production key. Same for GLK Chromebooks.
>>
>> It would be probably more nice to create a tar ball with all firmware
>> and
>> topology files bundled with the proper (usual) filesystem location
>> (/lib/firmware/intel/sof/... and /lib/firmware/intel/sof-tplg/...).
>> So we
>> (users/distribution packagers) can just use it.
> 
> Yeah, been thinking about this atm. It may be better to package the
> binaries (firmware and topologies) as part of Linux firmware repo
> (since the driver expects to load them all from lib/firmware) and
> package the sources (firmware and topology) via sof tarball ?

It looks good in my eyes, because topology files are another pieces of the
driver from the user space perspective. The unanswered question is the UCM
configuration which is linked to the topology configuration (if I understand
this correctly). I proposed to place an unique identifier/version to the
topology file and propagate this identifier to the user space, so the alsa-lib
can pick the right UCM configuration when topology changes. The component
string (snd_component_add function / struct snd_ctl_card_info -> components)
can be used for this identification.

					Jaroslav

> 
> Would this be OK for the distros ?
> 
> Liam 
> 
>>
>> BTW: Do we need UCM config files for SOF, too?
>>
>> 					Jaroslav
>>
> 


-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
