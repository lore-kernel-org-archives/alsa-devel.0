From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [alsa-devel] [PATCH 28/44] fireworks: Add command/response
	functionality into hwdep interface
Date: Fri, 04 Apr 2014 14:15:16 +0200
Message-ID: <533EA254.3080202@ladisch.de>
References: <1395400229-22957-1-git-send-email-o-takashi@sakamocchi.jp>
	<1395400229-22957-29-git-send-email-o-takashi@sakamocchi.jp>
	<533E7C01.8040000@ladisch.de> <533E9350.6090201@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <533E9350.6090201@sakamocchi.jp>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux1394-devel>
List-Post: <mailto:linux1394-devel@lists.sourceforge.net>
List-Help: <mailto:linux1394-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux1394-devel-bounces@lists.sourceforge.net
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Takashi Sakamoto wrote:
> (Apr 04 2014 18:31), Clemens Ladisch wrote:
>> Takashi Sakamoto wrote:
>>> +/* each field should be in big endian */
>>> +struct snd_efw_transaction {
>>> +    uint32_t length;
>>> +    uint32_t version;
>>> +    uint32_t seqnum;
>>> +    uint32_t category;
>>> +    uint32_t command;
>>> +    uint32_t status;
>>> +    uint32_t params[0];
>>> +};
>>
>> uint32_t is not guaranteed to be available in a userspace header.
>> Add <linux/types.h>, and use __u32.
>
> Can I request the reason?
>
> Here I force users to include <stdint.h> and use types defined in
> ISO C99. I think this way is standard. (but not standard between
> kernel/user-land?)

Headers should always be self-contained, i.e., they must include any
other headers they need.

As for the ISO C types, Linus Torvalds wrote:
| On Mon, 29 Nov 2004, Paul Mackerras wrote:
| >
| > uint32_t is defined to be exactly 32 bits wide, so where's the problem
| > in using it instead of __u32 in the headers that describe the
| > user/kernel interface?  (Ditto for uint{8,16,64}_t, of course.
|
| The kernel uses u8/u16/u32 because:
|
| 	- the kernel should not depend on, or pollute user-space naming.
| 	  YOU MUST NOT USE "uint32_t" when that may not be defined, and
| 	  user-space rules for when it is defined are arcane and totally
| 	  arbitrary.
|
| 	- since the kernel cannot use those types for anything that is
| 	  visible to user space anyway, there has to be alternate names.
| 	  The tradition is to prepend two underscores, so the kernel would
| 	  have to use "__uint32_t" etc for its header files.
|
| 	- at that point, there's no longer any valid argument that it's a
| 	  "standard type" (it ain't), and I personally find it a lot more
| 	  readable to just use the types that the kernel has always used:
| 	  __u8/__u16/__u32. For stuff that is only used for the kernel,
| 	  the shorter "u8/u16/u32" versions may be used.
|
| In short: having the kernel use the same names as user space is ACTIVELY
| BAD, exactly because those names have standards-defined visibility, which
| means that the kernel _cannot_ use them in all places anyway. So don't
| even _try_.
<http://yarchive.net/comp/linux/kernel_headers.html>

>>> +static long
>>> +hwdep_write(struct snd_hwdep *hwdep, const char __user *data, long count,
>>> +        loff_t *offset)
>>> +{
>>> +    ...
>>> +    if (count < sizeof(struct snd_efw_transaction))
>>> +        return -EINVAL;
>>
>> The size must not be larger than allowed for a single write transaction.
>> This would eventually be caught by the firewire core, but checking it
>> here would avoid allocating lots of memory.
>
> I investigate the length of all commands and realize the maximum bytes
> is 304 (0x130) for isochronous channel mapping. With leaving some
> space for this value, I think 0x140 is better for this purpose.

IEEE-1394 defines the maximum payload for asynchronous data packets (see
table 6-4); for S100/S200/S400/S800, it's 512/1024/2048/4096 bytes.

Fireworks devices always are S400; just use the maximum of 0x200 bytes.
(Anything less risks incompatibilities with an old kernel when some
mixer application wants to use a new command introduced in some new
firmware version.)


Regards,
Clemens

------------------------------------------------------------------------------
