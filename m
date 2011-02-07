From: "Matti J. Aaltonen" <matti.j.aaltonen@nokia.com>
Subject: Re: WL1273 FM Radio driver...
Date: Mon, 07 Feb 2011 12:52:02 +0200
Message-ID: <1297075922.15320.31.camel@masi.mnp.nokia.com>
Reply-To: matti.j.aaltonen@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-da01.nokia.com (smtp.nokia.com [147.243.128.24])
	by alsa0.perex.cz (Postfix) with ESMTP id 47A84246EA
	for <alsa-devel@alsa-project.org>; Mon,  7 Feb 2011 11:52:13 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk, mchehab@redhat.com, hverkuil@xs4all.nl, sameo@linux.intel.com, linux-media@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hello.

Mark Brown wrote:
> On Wed, Feb 02, 2011 at 01:35:01PM -0200, Mauro 
> Carvalho Chehab wrote:
>
> [Reflowed into 80 columns.]
>> My concerns is that the V4L2-specific part of the code should be at
>> drivers/media.  I prefer that the specific MFD I/O part to be at
>> drivers/mfd, just like the other drivers.
>
> Currently that's not the case - the I/O functionality is not in any
> meaningful sense included in the MFD, it's provided by the V4L portion.

I've been away for two and a half weeks so I haven't been able to
comment...

But before I start to make changes, I'd still like to ask for a comment
on my original plan, which was to have the I/O functions in the MFD
driver and also have there things like interrupt handling etc.

My vision was that the MFD part would have the application logic and the
child drivers would be just true interfaces to the core functionality,
because I kind of saw the children to be of equal importance and because
the codec and the v4l2 driver share some controls like for example the
volume control. 

If you'd care to take a look an earlier version of the MFD driver here:

http://article.gmane.org/gmane.linux.drivers.video-input-infrastructure/23602/match=aaltonen

So the question is if I put only the I/O stuff into the MFD driver or
can I have the other application logic there as well?

Thanks,
Matti
