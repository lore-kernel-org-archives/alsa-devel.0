From: Eliot Blennerhassett <eliot@blennerhassett.gen.nz>
Subject: Re: missing link to uapi in alsa-driver-build
Date: Sun, 25 Nov 2012 15:01:47 +1300
Message-ID: <50B17C0B.300@blennerhassett.gen.nz>
References: <50AFD594.8050709@blennerhassett.gen.nz>
 <s5hmwy7ayyy.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp4.clear.net.nz (smtp4.clear.net.nz [203.97.37.64])
 by alsa0.perex.cz (Postfix) with ESMTP id 36A0B2625D5
 for <alsa-devel@alsa-project.org>; Sun, 25 Nov 2012 03:01:51 +0100 (CET)
Received: from mxin1-orange.clear.net.nz
 (lb2-srcnat.clear.net.nz [203.97.32.237])
 by smtp4.clear.net.nz (CLEAR Net Mail)
 with ESMTP id <0ME000F0YTN0Z750@smtp4.clear.net.nz> for
 alsa-devel@alsa-project.org; Sun, 25 Nov 2012 15:01:48 +1300 (NZDT)
In-reply-to: <s5hmwy7ayyy.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

On 25/11/12 02:53, Takashi Iwai wrote:
> At Sat, 24 Nov 2012 08:59:16 +1300,
> Eliot Blennerhassett wrote:
>>
>> Hi Takashi,
>>
>> I'm building in alsa-driver-build, (local kernel 3.2.0)
>>
>> I found I had to add the following for a successful build
>>
>>   cd alsa-kernel
>>   ln -s [checkout of kernel/git/tiwai]/sound/include/uapi/sound uapi

Completely cleaned alsa-driver-build, then ran gitcompile:

make[1]: Entering directory `/usr/src/linux-headers-3.2.0-33-generic'
  CC [M]  /home/eliot/src/alsa/alsa-driver-build/acore/hrtimer.o
In file included from
/home/eliot/src/alsa/alsa-driver-build/include/sound/timer.h:26:0,
                 from
/home/eliot/src/alsa/alsa-driver-build/acore/hrtimer.c:28:
/home/eliot/src/alsa/alsa-driver-build/include/sound/asound.h:39:31:
fatal error: uapi/sound/asound.h: No such file or directory
compilation terminated.

The generated alsa-kernel directory doesn't contain uapi, where your
snapshot does...

>>
>> I don't know where this should be fixed in the build system...
> 
> Could you check the latest snapshot?
>   ftp://ftp.suse.com/pub/people/tiwai/snapshot/alsa-driver-snapshot.tar.gz

Yes, that builds fine.

--
Eliot
