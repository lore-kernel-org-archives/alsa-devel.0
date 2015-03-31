From: Qais Yousef <qais.yousef@imgtec.com>
Subject: Re: [TINYCOMPRESS][v2 PATCH 1/7] Convert the build
	system to autotools
Date: Tue, 31 Mar 2015 10:22:06 +0100
Message-ID: <551A673E.60300@imgtec.com>
References: <1427193154-6753-1-git-send-email-qais.yousef@imgtec.com>
 <1427193154-6753-2-git-send-email-qais.yousef@imgtec.com>
 <55197399.9070202@imgtec.com> <20150330165008.GE7192@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailapp01.imgtec.com (mailapp01.imgtec.com [195.59.15.196])
 by alsa0.perex.cz (Postfix) with ESMTP id 7A46726065A
 for <alsa-devel@alsa-project.org>; Tue, 31 Mar 2015 11:22:07 +0200 (CEST)
In-Reply-To: <20150330165008.GE7192@intel.com>
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

On 03/30/2015 05:50 PM, Vinod Koul wrote:
> On Mon, Mar 30, 2015 at 05:02:33PM +0100, Qais Yousef wrote:
>> On 03/24/2015 10:32 AM, Qais Yousef wrote:
>>> Hopefully this should make tinycompress a more robust package.
>>> This change splits the source into utils and lib.
>>> No functional changes was introduced.
>>>
>>> diff --git a/src/utils/Makefile.am b/src/utils/Makefile.am
>>> new file mode 100644
>>> index 000000000000..0a3fc43c92cb
>>> --- /dev/null
>>> +++ b/src/utils/Makefile.am
>>> @@ -0,0 +1,11 @@
>>> +bin_PROGRAMS = cplay crecord
>>> +
>>> +cplay_SOURCES = cplay.c
>>> +crecord_SOURCES = cplay.c
>>> +
>> This should be crec.c :-/
>>
>> Can you fix when you apply or do you want me to send v3?
> No issues I can fix it up
>
> I am running few more stuff, I will merge this shortly
>

Thanks
