From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 13/13] libhinawa: add sample scripts
Date: Wed, 28 Jan 2015 00:09:18 +0900
Message-ID: <54C7AA1E.4040900@sakamocchi.jp>
References: <1422185674-16431-1-git-send-email-o-takashi@sakamocchi.jp>
 <1422185674-16431-14-git-send-email-o-takashi@sakamocchi.jp>
 <54C4DE43.1050105@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id 6DE832608BC
 for <alsa-devel@alsa-project.org>; Tue, 27 Jan 2015 16:09:24 +0100 (CET)
In-Reply-To: <54C4DE43.1050105@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Alexander E. Patrakov" <patrakov@gmail.com>, clemens@ladisch.de, tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Hi Alexander,

On Jan 25 2014 21:14, Alexander E. Patrakov wrote:
> 25.01.2015 16:34, Takashi Sakamoto wrote:
>> +from array import array
>> +
>> +# helper function
>> +def get_array():
>> +    # The width with 'L' parameter is depending on environment.
>> +    arr = array('L')
>> +    if arr.itemsize is not 4:
>> +        arr = array('I')
>> +    return arr
> 
> 
> If you insist on using arrays, then please add an assertion that you
> have actually got an array with itemsize 4 at the end.

Thanks for your comment. Certainly, I should put assersion to the
function for guarantee to return 32bit array.

> But, if I were you, I'd go with the "ctypes" module instead, if it
> works. Here is how you get a fixed-size (in the example, 10 elements)
> array with signed 4-byte elements:
> 
> from ctypes import *
> TenInts = c_int32 * 10
> ii = TenInts()
> 
> The result supports buffer protocol.

I didn't realize this way, thank you.

But I'm too lazy to like fixed size of array. With the array module, I
can expand the length of array automatically, like:

{{{
from array import array
arr = array('L')
arr.append(1)
arr.append(2)
...
arr.append("Aaargh, how large number!")
}}}

Do you know the ways for flexible length in ctype array?


Regards

Takashi Sakamoto
