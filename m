From: Qais Yousef <qais.yousef@imgtec.com>
Subject: Re: [TINYCOMPRESS][PATCH 0/6] Convert build system to
	autotools
Date: Tue, 24 Mar 2015 09:57:15 +0000
Message-ID: <551134FB.3070908@imgtec.com>
References: <1427116145-519-1-git-send-email-qais.yousef@imgtec.com>
 <20150323164055.GA32683@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailapp01.imgtec.com (mailapp01.imgtec.com [195.59.15.196])
 by alsa0.perex.cz (Postfix) with ESMTP id 6FC90260418
 for <alsa-devel@alsa-project.org>; Tue, 24 Mar 2015 10:57:17 +0100 (CET)
In-Reply-To: <20150323164055.GA32683@intel.com>
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

On 03/23/2015 04:40 PM, Vinod Koul wrote:
> On Mon, Mar 23, 2015 at 01:08:59PM +0000, Qais Yousef wrote:
>> This series converts the build system to use autotools and splits the files into
>> lib and utils.
>>
>> Also patch 5 fixes error handling code.
>>
>> I can't test Android builds but both cross and native compiling worked for me.
>>
>> I left AUTHORS, ChangeLog and NEWS files empty. I used the license header to fill COPYING.
> Thanks :)
>
> I was planning to do this after my current SKL work but this is welcome too.
> Just one advise, pls generate patches using -M option, that shows code moves
> nicely...
>
Oh sorry I forgot about this option. I'll send v2 with this change and a 
couple of other fixes.

Thanks,
Qais
