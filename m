From: Patrick Lai <plai@codeaurora.org>
Subject: Re: Ambiguous DAPM widget names and DPCM
Date: Fri, 21 Mar 2014 09:50:39 -0700
Message-ID: <532C6DDF.5030809@codeaurora.org>
References: <51EE3F18.3030207@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.11.231])
 by alsa0.perex.cz (Postfix) with ESMTP id 3075C2610D2
 for <alsa-devel@alsa-project.org>; Fri, 21 Mar 2014 17:50:42 +0100 (CET)
In-Reply-To: <51EE3F18.3030207@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 7/23/2013 1:30 AM, Daniel Mack wrote:
>
> I don't know how to handle this, but I believe that nobody was really
> hit by this issue yet, as DPCM doesn't seem to be used widely, at least
> not by any machine code in mainline.

For your information, DPCM framework is heavily used by drivers
developed by Qualcomm Innovation Center, Inc. even though they are not
upstreamed. I 'll check internally if we came across similar issue or
not.

Thanks
Patrick

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
