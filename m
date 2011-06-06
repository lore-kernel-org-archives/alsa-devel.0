From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH] wm8940: remove unecessary if statement
Date: Mon, 6 Jun 2011 10:51:58 +0100
Message-ID: <4DECA33E.5040306@ti.com>
References: <1307321274-21858-1-git-send-email-Gregory.Dietsche@cuw.edu>
	<4DEC9E6B.8030505@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
	by alsa0.perex.cz (Postfix) with ESMTP id E948210399D
	for <alsa-devel@alsa-project.org>;
	Mon,  6 Jun 2011 11:52:01 +0200 (CEST)
In-Reply-To: <4DEC9E6B.8030505@cam.ac.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Greg Dietsche <Gregory.Dietsche@cuw.edu>
Cc: "dp@opensource.wolfsonmicro.com" <dp@opensource.wolfsonmicro.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "tiwai@suse.de" <tiwai@suse.de>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jonathan Cameron <jic23@cam.ac.uk>
List-Id: alsa-devel@alsa-project.org

On 06/06/11 10:31, Jonathan Cameron wrote:
> On 06/06/11 01:47, Greg Dietsche wrote:
>> the code always returns ret regardless, so if(ret) check is unecessary.
> Good point, though please spell check your commit messages.
> unecessary -> unnecessary
> 
> Also if you want to do this sort of cleanup, please also fix the
> equivalent in wm8940_resume and wm8940_add_widgets.  Ack is for
> what is here, plus those if you do them.
> 
> Just as an aside, there is no earthly point in cc'ing lkml for a
> simple cleanup like this. Just adds to already huge amount of noise!
>>
>> Signed-off-by: Greg Dietsche <Gregory.Dietsche@cuw.edu>
> Acked-by: Jonathan Cameron <jic23@cam.ac.uk>

Acked-by: Liam Girdwood <lrg@ti.com>
