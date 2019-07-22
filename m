From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] ASoC: SOF: use __u32 instead of uint32_t
 in uapi headers
Date: Mon, 22 Jul 2019 10:18:25 -0500
Message-ID: <9a56ccdb-397b-3046-4043-49bc20aaa804@linux.intel.com>
References: <20190721142308.30306-1-yamada.masahiro@socionext.com>
 <de9e94ee-9c01-1c0c-4359-b637319a298f@linux.intel.com>
 <s5hftmy8byl.wl-tiwai@suse.de>
 <ec306745-052d-f52c-2cce-d8915822d4ff@linux.intel.com>
 <CAK8P3a2tLuqu+upt0nW8dUzXc+t_kEJwVhLcqY8TXydHLb_nCw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E9733F800E8
 for <alsa-devel@alsa-project.org>; Mon, 22 Jul 2019 17:18:29 +0200 (CEST)
In-Reply-To: <CAK8P3a2tLuqu+upt0nW8dUzXc+t_kEJwVhLcqY8TXydHLb_nCw@mail.gmail.com>
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
To: Arnd Bergmann <arnd@arndb.de>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Mark Brown <broonie@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org



On 7/22/19 8:34 AM, Arnd Bergmann wrote:
> On Mon, Jul 22, 2019 at 3:16 PM Pierre-Louis Bossart
> <pierre-louis.bossart@linux.intel.com> wrote:
>> On 7/22/19 7:56 AM, Takashi Iwai wrote:
>>> On Mon, 22 Jul 2019 14:49:34 +0200,
>>> Pierre-Louis Bossart wrote:
>>>>
>>>>
>>>>
>>>> On 7/21/19 9:23 AM, Masahiro Yamada wrote:
>>>>> When CONFIG_UAPI_HEADER_TEST=y, exported headers are compile-tested to
>>>>> make sure they can be included from user-space.
>>>>>
>>>>> Currently, header.h and fw.h are excluded from the test coverage.
>>>>> To make them join the compile-test, we need to fix the build errors
>>>>> attached below.
>>>>>
>>>>> For a case like this, we decided to use __u{8,16,32,64} variable types
>>>>> in this discussion:
>>>>>
>>>>>      https://lkml.org/lkml/2019/6/5/18
>>>>
>>>> these files are shared with the SOF project and used as is (with minor
>>>> formatting) for the firmware compilation. I am not sure I understand
>>>> the ask here, are you really asking SOF to use linux-specific type
>>>> definitions?
>>>
>>> Actually this is linux-kernel UAPI header files, so yes, we should
>>> follow the convention there as much as possible.
>>>
>>> So far we haven't been strict about these types.  But now we have a
>>> unit test for checking it, so it's a good opportunity to address the
>>> issues.
>>
>> Maybe a bit of background. For SOF we split the includes in 4 directories
>>
>> https://github.com/thesofproject/sof/tree/master/src/include
>>
>> - sof: internal includes for firmware only
>> - ipc: definitions of the structures for information exchanged over the
>> IPC channel. This directory is used as is by the Linux kernel and
>> mirrored in include/sound/sof
>> - user: definitions needed for firmware tools, e.g. to generate the
>> image or parse the trace. this directory is not used by the Linux kernel.
>> - kernel: definitions for the firmware format, needed for the loader to
>> parse the firmware files. This is not directly used by applications
>> running on the target, it really defines the content passed to the
>> kernel with request_firmware. This directory is mirrored in the Linux
>> include/uapi/sound/sof directory.
>>
>> Our goal is to minimize the differences and allow deltas e.g. for
>> license or comments. We could add a definition for __u32 when linux is
>> not used, I am just not sure if these two files really fall in the UAPI
>> category and if the checks make sense.
> 
> If you can build all the SOF user space without these headers being
> installed to /usr/include/sound/sof/, you can move them from
> include/uapi/sound/sof to include/sounds/sof and leave the types
> unchanged.

yes we don't need those files to build userspace stuff. The idea was 
that these format definitions establish a contract between userspace 
(more specifically the files stored in /lib/firmware) and the kernel. 
IIRC we wanted to make sure that any changes would be tracked as 
breaking userspace. If the consensus is that the uapi directory is 
strictly used for builds then we should indeed move those files
