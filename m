From: "Alexander E. Patrakov" <patrakov@gmail.com>
Subject: Re: [PATCH 13/13] libhinawa: add sample scripts
Date: Tue, 27 Jan 2015 20:16:30 +0500
Message-ID: <54C7ABCE.9000305@gmail.com>
References: <1422185674-16431-1-git-send-email-o-takashi@sakamocchi.jp>
	<1422185674-16431-14-git-send-email-o-takashi@sakamocchi.jp>
	<54C4DE43.1050105@gmail.com> <54C7AA1E.4040900@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <54C7AA1E.4040900@sakamocchi.jp>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux1394-devel>
List-Post: <mailto:linux1394-devel@lists.sourceforge.net>
List-Help: <mailto:linux1394-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux1394-devel-bounces@lists.sourceforge.net
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>, clemens@ladisch.de, tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

27.01.2015 20:09, Takashi Sakamoto wrote:
> Hi Alexander,
>
> On Jan 25 2014 21:14, Alexander E. Patrakov wrote:
>> 25.01.2015 16:34, Takashi Sakamoto wrote:
>>> +from array import array
>>> +
>>> +# helper function
>>> +def get_array():
>>> +    # The width with 'L' parameter is depending on environment.
>>> +    arr = array('L')
>>> +    if arr.itemsize is not 4:
>>> +        arr = array('I')
>>> +    return arr
>>
>>
>> If you insist on using arrays, then please add an assertion that you
>> have actually got an array with itemsize 4 at the end.
>
> Thanks for your comment. Certainly, I should put assersion to the
> function for guarantee to return 32bit array.
>
>> But, if I were you, I'd go with the "ctypes" module instead, if it
>> works. Here is how you get a fixed-size (in the example, 10 elements)
>> array with signed 4-byte elements:
>>
>> from ctypes import *
>> TenInts = c_int32 * 10
>> ii = TenInts()
>>
>> The result supports buffer protocol.
>
> I didn't realize this way, thank you.
>
> But I'm too lazy to like fixed size of array. With the array module, I
> can expand the length of array automatically, like:
>
> {{{
> from array import array
> arr = array('L')
> arr.append(1)
> arr.append(2)
> ...
> arr.append("Aaargh, how large number!")
> }}}
>
> Do you know the ways for flexible length in ctype array?

Unfortunately, there is no such thing in ctypes.

-- 
Alexander E. Patrakov

------------------------------------------------------------------------------
Dive into the World of Parallel Programming. The Go Parallel Website,
sponsored by Intel and developed in partnership with Slashdot Media, is your
hub for all things parallel software development, from weekly thought
leadership blogs to news, videos, case studies, tutorials and more. Take a
look and join the conversation now. http://goparallel.sourceforge.net/
