From: Patrick Lai <plai@codeaurora.org>
Subject: Re: ALSA framework problem: FE disconnected,
 BE still connected!
Date: Thu, 18 Apr 2013 13:26:40 -0700
Message-ID: <51705700.8090005@codeaurora.org>
References: <7e576a6bf7cb6ca6a9be95b0d14e3a87.squirrel@www.codeaurora.org>
 <20130418165844.GN13687@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wolverine02.qualcomm.com (wolverine02.qualcomm.com
 [199.106.114.251])
 by alsa0.perex.cz (Postfix) with ESMTP id 59B592610CD
 for <alsa-devel@alsa-project.org>; Thu, 18 Apr 2013 22:26:43 +0200 (CEST)
In-Reply-To: <20130418165844.GN13687@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: asishb@codeaurora.org, lkasam@codeaurora.org, alsa-devel@alsa-project.org, lgirdwood@gmail.com, gsantosh@codeaurora.org
List-Id: alsa-devel@alsa-project.org

On 4/18/2013 9:58 AM, Mark Brown wrote:
> On Thu, Apr 18, 2013 at 09:56:25AM -0700, lkasam@codeaurora.org wrote:
>> Hi Liam,
>> We have a problem encountered in ALSA framework wrt FE/BE disconnection and
>> fix to it is mentioned in below code change. please check it and provide
>> your valuable comments.
>
> Please submit patches in hte form covered in SubmittingPatches.
Hi Mark,

We are not sure if the solution is correct. Change from Kasam will skip
the step which trigger stop the hardware and directly call hardware
free. Is it expected that every driver internally stops the hardware
before freeing the hardware resource if not stopped?

Thanks
Patrick

>
>
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>


-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
