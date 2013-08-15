From: Knut Petersen <Knut_Petersen@t-online.de>
Subject: Re: [PATCH] rme96 add stream synchronization and PM
 support
Date: Thu, 15 Aug 2013 09:16:57 +0200
Message-ID: <520C8069.7090800@t-online.de>
References: <51FF9C55.80701@t-online.de> <51FFA643.7060504@ladisch.de>
 <52013579.7020304@t-online.de> <s5h4nb2asg5.wl%tiwai@suse.de>
 <52037864.9000205@t-online.de> <s5h61vacb25.wl%tiwai@suse.de>
 <520A0B2C.7060500@t-online.de> <s5hy585x4e3.wl%tiwai@suse.de>
 <520AA125.5010803@t-online.de> <s5hd2pgs45i.wl%tiwai@suse.de>
 <520C6EA1.8090608@t-online.de> <s5hd2pfo4m6.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout02.t-online.de (mailout02.t-online.de [194.25.134.17])
 by alsa0.perex.cz (Postfix) with ESMTP id E599F26556F
 for <alsa-devel@alsa-project.org>; Thu, 15 Aug 2013 09:17:02 +0200 (CEST)
In-Reply-To: <s5hd2pfo4m6.wl%tiwai@suse.de>
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

On 15.08.2013 08:22, Takashi Iwai wrote:
> At Thu, 15 Aug 2013 08:01:05 +0200,
> Knut Petersen wrote:
>> On 14.08.2013 17:06, Takashi Iwai wrote:
>>> Please resubmit only the second patch with the fixes.
>> Ah, yes. That should have been obvious.
>>
>> After a 2nd thought I believe that  it is an even better idea
>> not to abort but to handle that error condition graciously.
> Why?  It's a serious error.

The probability that two 64k vmallocs will fail is pretty low,
and the probability that after that failure there is enough memory
for an audio application to be executed successfully is even lower.

Nevertheless, in that unlikely case I would prefer max 0.37 seconds
of silence (=skipped audio) during resume to a failed start of a
recording caused by an unloaded module. Limited functionality
is better than complete failure.


cu,
  Knut
