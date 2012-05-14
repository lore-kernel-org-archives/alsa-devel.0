From: Patrick Lai <plai@codeaurora.org>
Subject: Re: Multicasting transfer mode
Date: Mon, 14 May 2012 13:21:41 -0700
Message-ID: <4FB16955.70605@codeaurora.org>
References: <4FB0ADA3.3020304@codeaurora.org>
	<20120514085405.GI31985@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wolverine02.qualcomm.com (wolverine02.qualcomm.com
	[199.106.114.251])
	by alsa0.perex.cz (Postfix) with ESMTP id 1C0F324B14
	for <alsa-devel@alsa-project.org>;
	Mon, 14 May 2012 22:21:44 +0200 (CEST)
In-Reply-To: <20120514085405.GI31985@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On 5/14/2012 1:54 AM, Mark Brown wrote:
> On Mon, May 14, 2012 at 12:00:51AM -0700, Patrick Lai wrote:
>
>> The hardware I am working on has CODEC transfer microphone signal to
>> two SOCs simultaneously . In the machine driver, I have two dai-links
>
> This isn't something the framework supports.  You'd need to either
> implement the support or wait for someone else to do so.
>

Yes, I intended to implement framework support. However, I just want to
make sure I am not hijacking playback_active and capture_active flags
for unintended purpose. Base on existing code, playback_active is only
used for handling click and pop and capture_active flag is not used at
all.

Thanks
Patrick

>
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel


-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
