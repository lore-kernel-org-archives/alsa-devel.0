From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [ALSA-UTILS][PATCH] Add support for cplay and
	crecord
Date: Thu, 05 Mar 2015 14:39:14 +0100
Message-ID: <54F85C82.9010608@perex.cz>
References: <1425483360-1806-1-git-send-email-qais.yousef@imgtec.com>	<20150304161013.GU2613@intel.com>	<54F73421.3000108@imgtec.com>	<20150305070018.GW2613@intel.com>	<54F80916.50703@perex.cz>	<20150305083054.GY2613@intel.com>
 <s5h7fuv25dc.wl-tiwai@suse.de> <54F84E0D.1070907@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 by alsa0.perex.cz (Postfix) with ESMTP id C2DF526047B
 for <alsa-devel@alsa-project.org>; Thu,  5 Mar 2015 14:39:15 +0100 (CET)
In-Reply-To: <54F84E0D.1070907@imgtec.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Qais Yousef <qais.yousef@imgtec.com>, Takashi Iwai <tiwai@suse.de>, Vinod Koul <vinod.koul@intel.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Dne 5.3.2015 v 13:37 Qais Yousef napsal(a):
> On 03/05/2015 08:52 AM, Takashi Iwai wrote:
>> At Thu, 5 Mar 2015 14:00:54 +0530,
>> Vinod Koul wrote:
>>> On Thu, Mar 05, 2015 at 08:43:18AM +0100, Jaroslav Kysela wrote:
>>>> Dne 5.3.2015 v 08:00 Vinod Koul napsal(a):
>>>>> On Wed, Mar 04, 2015 at 04:34:41PM +0000, Qais Yousef wrote:
>>>>>> On 03/04/2015 04:10 PM, Vinod Koul wrote:
>>>>>>> On Wed, Mar 04, 2015 at 03:36:00PM +0000, Qais Yousef wrote:
>>>>>>>> cplay and crecord use compress offload API to play and record compressed audio.
>>>>>>>>
>>>>>>>> They're based on cplay and crec from tinycompress library using LGPL license.
>>>>>>>>
>>>>>>>> For now cplay only supports playing mp3 files.
>>>>>>>>
>>>>>>>> Signed-off-by: Qais Yousef <qais.yousef@imgtec.com>
>>>>>>>> Cc: Takashi Iwai <tiwai@suse.de>
>>>>>>>> Cc: Vinod Koul <vinod.koul@intel.com>
>>>>>>>> Cc: Mark Brown <broonie@kernel.org>
>>>>>>>> ---
>>>>>>>> I renamed crec to crecord also to match aplay and arecord, hopefully
>>>>>>>> you don't mind Vinod.
>>>>>>> No thats fine..
>>>>>>>
>>>>>>>> This patch is dependent on my other patch that adds support for compress offload
>>>>>>>> to alsa-lib.
>>>>>>> And where is that, should have preceded this
>>>>>> Hmm not sure what went wrong. I resent it. Seems I have some emailer
>>>>>> issues as I had this problem before.
>>>>>> Hopefully you received it now.
>>>>>>
>>>>>>>> I needed to include <sound/compress_params.h> in cplay.c and crec.c
>>>>>>>> but I couldn't find an example of any C file which directly includes <sound/*.h>
>>>>>>>> The norm seems to be to just include <alsa/asoundlib.h>. Do I need to
>>>>>>>> redefine structs from <sound/compress_params.h> to newly added <alsa/compress.h>?
>>>>>>>> <alsa/pcm.h> seems to redefine structs from <sound/asound.h>.
>>>>>>> These are kernel headers and should be in your include path if you have
>>>>>>> those installed
>>>>>>>> I could only test cplay but have no means to test crecord at the moment.
>>>>>>>>
>>>>>>>>   Makefile.am       |   3 +
>>>>>>>>   configure.ac      |   6 +-
>>>>>>>>   cplay/Makefile.am |  14 ++
>>>>>>>>   cplay/cplay.c     | 294 +++++++++++++++++++++++++++++++++++
>>>>>>>>   cplay/crec.c      | 449 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>>>>>>>   cplay/tinymp3.h   |  72 +++++++++
>>>>>>>>   6 files changed, 837 insertions(+), 1 deletion(-)
>>>>>>>>   create mode 100644 cplay/Makefile.am
>>>>>>>>   create mode 100644 cplay/cplay.c
>>>>>>>>   create mode 100644 cplay/crec.c
>>>>>>>>   create mode 100644 cplay/tinymp3.h
>>>>>>> Okay here is where we need discussion on the future course. If we do this
>>>>>>> then we end up in two code bases, something I would not encourage!
>>>>>>>
>>>>>>> On the other hand if we add the make file changes to tinycompress or if
>>>>>>> required split this into two, lib and tools and then package lib part into
>>>>>>> alsa-lib and players into tools, that way we can have single code base. That
>>>>>>> was my intent behind ensuring that this is dual licensed.
>>>>>> I'm not sure I follow you completely here. You mean keep cplay and
>>>>>> crec in tinycompress with the dual licensing but only merge the lib
>>>>>> part (which my other patch does) into alsa-lib? For me having this
>>>>>> lib part into alsa-lib is the important bit. Moving crec and cplay
>>>>>> to alsa-utils was something I thought would be useful but maybe not.
>>>>> Not that
>>>>>
>>>>> Since alsa splits lib and tools, in order to take this into alsa-libs we
>>>>> need to split tinycompress, to something like lib and tool part.
>>>>>
>>>>> Then alsa-lib can import the lib part of tinycompress. Please note I am not
>>>>> saying we should copy or move code into alsa-lib.
>>>>> The reason for that is
>>>>> 1. copying code will cause more maintaince of same code in two places :(
>>>>> 2. moving into alsa-lib is not an option as existing users like android will
>>>>> suffer as they dont use alsa-lib
>>>>>
>>>>> So I think, while building and packaging alsa-library and tools we can
>>>>> import the tinycompress using LGPL license and use that to give complete
>>>>> library on Linux to users
>>>>>
>>>>> Takashi, can we get you blessing for this approach before we embark on this,
>>>>> or any other better ideas?
>>>> The problem is if the code is not duplicated, then the parts of the
>>>> alsa-lib binary will be dual-licenced. I don't think that it's the right
>>>> way.
>>>>
>>>> And if the code is duplicated, then patch authors for all next updates
>>>> in both libraries (alsa-lib, tinycompress) must be asked for permissions
>>>> to change code licence for the merge to the second library.
>>>>
>>>> I think that a plugin-style extension should be created here (so
>>>> tinycompress will be used at runtime as the dynamic library).
>>>>
>>>> compress API -> tinycompress plugin -> tinycompress .so functions
>>>>
>>>> This will allow us also to create another plugins in future.
>>> That does solve the issue for me as well. The intent is to provide
>>> compressed functionality within alsa-libs so asa plugin that can work very
>>> well...
>>>
>>> Any other thoughts... ?
>> Well, tinycompress itself is merely a thin layer covering the kernel
>> ABI.  So, writing a plugin infrastructure itself already achieves the
>> whole rewrite of tinycompress library.  What else remains as a plugin
>> content?
>>
>>
>> Takashi
> 
> OK reading a bit more about dual license what I understood is that it's 
> ok for alsa-lib to choose redistribute tinycompress as LGPL only.
> To cope with code duplication we could create tinycompress as a git 
> submodule and educate alsa-lib build system to pull a tag and use that 
> to compile the support for compress api.
> 
> Makes sense?

Thinking again about this and all suggested variants to use the
tinycompress code are not ideal. The alsa-lib is LGPL. Dot. I don't
think that we want to link (compile time linking) to any external code.

My .so plugin proposal is probably ok, but as Takashi said, it means
that the alsa-lib API code would be more bigger than the ioctl wrapper
code in tinycompress - the question is if it makes sense.

So I think that the best way is to fork the code and create compatible
APIs (headers) with the possible API change syncing.

				Thanks,
					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project; Red Hat, Inc.
