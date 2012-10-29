From: Patrick Lai <plai@codeaurora.org>
Subject: Re: Back-end state transition query
Date: Sun, 28 Oct 2012 17:24:27 -0700
Message-ID: <508DCCBB.4000109@codeaurora.org>
References: <5088ECF2.8010007@codeaurora.org> <50897DF4.1020402@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wolverine01.qualcomm.com (wolverine01.qualcomm.com
 [199.106.114.254])
 by alsa0.perex.cz (Postfix) with ESMTP id CCC882652D5
 for <alsa-devel@alsa-project.org>; Mon, 29 Oct 2012 01:25:08 +0100 (CET)
In-Reply-To: <50897DF4.1020402@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 10/25/2012 10:59 AM, Liam Girdwood wrote:
Hi Liam,

> It should be OK to allow the paused state in hw_free(), but I'm thinking we should probably see the trigger stop when we close the FE (although I'm not 100% certain atm of seeing the STOP as I've not traced this PAUSE -> CLOSE sequence).
I am also surprised to see that trigger stop never comes. I can dig in
more to figure out why.

I assume you have a patch that allows this ?

Yes, I will publish to alsa-devel

Thanks
Patrick

>
> Thanks
>
> Liam
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
