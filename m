From: nick <xerofoify@gmail.com>
Subject: Re: Possible Bug Found with Xonar Stx Driver
Date: Fri, 10 Jul 2015 08:25:39 -0400
Message-ID: <559FB9C3.2050108@gmail.com>
References: <559EFC14.2090408@gmail.com> <559FB6F2.2000606@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ie0-f169.google.com (mail-ie0-f169.google.com
 [209.85.223.169])
 by alsa0.perex.cz (Postfix) with ESMTP id CF4E0260447
 for <alsa-devel@alsa-project.org>; Fri, 10 Jul 2015 14:25:41 +0200 (CEST)
Received: by iebmu5 with SMTP id mu5so194701295ieb.1
 for <alsa-devel@alsa-project.org>; Fri, 10 Jul 2015 05:25:40 -0700 (PDT)
In-Reply-To: <559FB6F2.2000606@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: tiwai@suse.de, axboe@kernel.dk, alsa-devel@alsa-project.org, tytso@mit.edu, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org



On 2015-07-10 08:13 AM, Clemens Ladisch wrote:
> nick wrote:
>> After running the latest version of Linus's tree I am noticed way more buffering
> 
> What exactly do you mean with the word "buffering"?
> 
>> when playing music with my Xonar STX card when building kernels then
>> under the Ubuntu kernel version of 3.19.16.
> 
> Sounds like a change in the disk access patterns.
> 
> The audio buffer size is chosen by the playing application (whatever it
> is).
> 
>> I have tried bisecting it between the releases of 3.18 and 4.0
>> and was unable to narrow it down to a buggy commit.
> 
> There was no relevant change in the sound driver.
> 
> 
> Regards,
> Clemens
> 
I was looking just to see if there was just a direct commit that caused this not in the sound 
driver but overall. Seems this is most likely either disk access issues or locking issues with
timeout related to refilling the audio buffer. In addition by buffering I mean the music halts
for a minute then continues when compiling the kernel. Further more I am also noticed my builds
are much fast upwards of 25% on the latest rc so a performance improvement in locking or better
disk access improvement may be a likely culprit. Ccing Ted and Jen as they are maintainers of
the file system I am using and Jen maintains the block layer.
Cheers,
Nick
