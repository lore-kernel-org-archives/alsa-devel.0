From: Qais Yousef <qais.yousef@imgtec.com>
Subject: Re: [TINYCOMPRESS][v2 PATCH 0/7] Convert build system
 to autotools
Date: Tue, 24 Mar 2015 16:26:23 +0000
Message-ID: <5511902F.5040000@imgtec.com>
References: <1427193154-6753-1-git-send-email-qais.yousef@imgtec.com>
 <20150324160754.GB32683@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailapp01.imgtec.com (mailapp01.imgtec.com [195.59.15.196])
 by alsa0.perex.cz (Postfix) with ESMTP id 7C9D02604A1
 for <alsa-devel@alsa-project.org>; Tue, 24 Mar 2015 17:26:25 +0100 (CET)
In-Reply-To: <20150324160754.GB32683@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 03/24/2015 04:07 PM, Vinod Koul wrote:
> On Tue, Mar 24, 2015 at 10:32:27AM +0000, Qais Yousef wrote:
>> This series converts the build system to use autotools and splits the files into
>> lib and utils.
>>
>> Also patch 5 fixes error handling code.
>>
>> I can't test Android builds but both cross and native compiling worked for me.
>>
>> I left AUTHORS, ChangeLog and NEWS files empty. I used the license header to fill COPYING.
>>
>> Changes in v2:
>>   - Use -M option when generating the patches
>>   - Add Makefile.am to include directory that exports tinycompress.h
>>   - New patch (7) that fixes include dependency in tinycompress.h
> This looks okay to me. I have two issue though:
>
> 1. So after applying tha patches, I did ./autogen.sh, that seems to have
> updated INSTALL, do you know why?

I'm no autotools expert. Either I'm passing wrong args to autoreconf or 
I need to replace it with something better. I'll have a look.

>
> 2. For the fun part, I did make and then make install. Running cplay w/o
> args should have printed the help menu, but that didnt ahppen
>
> $ cplay
> cplay: error while loading shared libraries: libtinycompress.so.0: cannot
> open shared object file: No such file or directory
>
> Not sure why...
>
> I will try Android build possibly tomorrow
>

Weird. I can't reproduce this.
Can you see libtinycompress.so.0 in /usr/local/lib?Do you need to update 
your LD_LIBRARY_PATH to include /usr/local/lib?

Thanks for having a look and testing.
