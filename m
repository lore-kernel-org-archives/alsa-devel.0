From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: SOF: use __u32 instead of uint32_t in
 uapi headers
Date: Mon, 22 Jul 2019 08:16:46 -0500
Message-ID: <ec306745-052d-f52c-2cce-d8915822d4ff@linux.intel.com>
References: <20190721142308.30306-1-yamada.masahiro@socionext.com>
 <de9e94ee-9c01-1c0c-4359-b637319a298f@linux.intel.com>
 <s5hftmy8byl.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hftmy8byl.wl-tiwai@suse.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Arnd Bergmann <arnd@arndb.de>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org



On 7/22/19 7:56 AM, Takashi Iwai wrote:
> On Mon, 22 Jul 2019 14:49:34 +0200,
> Pierre-Louis Bossart wrote:
>>
>>
>>
>> On 7/21/19 9:23 AM, Masahiro Yamada wrote:
>>> When CONFIG_UAPI_HEADER_TEST=y, exported headers are compile-tested to
>>> make sure they can be included from user-space.
>>>
>>> Currently, header.h and fw.h are excluded from the test coverage.
>>> To make them join the compile-test, we need to fix the build errors
>>> attached below.
>>>
>>> For a case like this, we decided to use __u{8,16,32,64} variable types
>>> in this discussion:
>>>
>>>     https://lkml.org/lkml/2019/6/5/18
>>
>> these files are shared with the SOF project and used as is (with minor
>> formatting) for the firmware compilation. I am not sure I understand
>> the ask here, are you really asking SOF to use linux-specific type
>> definitions?
> 
> Actually this is linux-kernel UAPI header files, so yes, we should
> follow the convention there as much as possible.
> 
> So far we haven't been strict about these types.  But now we have a
> unit test for checking it, so it's a good opportunity to address the
> issues.

Maybe a bit of background. For SOF we split the includes in 4 directories

https://github.com/thesofproject/sof/tree/master/src/include

- sof: internal includes for firmware only
- ipc: definitions of the structures for information exchanged over the 
IPC channel. This directory is used as is by the Linux kernel and 
mirrored in include/sound/sof
- user: definitions needed for firmware tools, e.g. to generate the 
image or parse the trace. this directory is not used by the Linux kernel.
- kernel: definitions for the firmware format, needed for the loader to 
parse the firmware files. This is not directly used by applications 
running on the target, it really defines the content passed to the 
kernel with request_firmware. This directory is mirrored in the Linux 
include/uapi/sound/sof directory.

Our goal is to minimize the differences and allow deltas e.g. for 
license or comments. We could add a definition for __u32 when linux is 
not used, I am just not sure if these two files really fall in the UAPI 
category and if the checks make sense.
