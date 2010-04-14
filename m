From: Stefan Schoenleitner <dev.c0debabe@gmail.com>
Subject: Re: ALSA application programming: route audio from one
 PCM to another
Date: Wed, 14 Apr 2010 10:44:50 +0200
Message-ID: <4BC58082.6090508@gmail.com>
References: <4BC48C74.5010102@gmail.com> <hq25p7$8kd$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from keymachine.tbmn.org (mail.tbmn.org [87.118.84.39])
	by alsa0.perex.cz (Postfix) with ESMTP id D6CC224483
	for <alsa-devel@alsa-project.org>;
	Wed, 14 Apr 2010 10:44:51 +0200 (CEST)
In-Reply-To: <hq25p7$8kd$1@dough.gmane.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Colin Guthrie <gmane@colin.guthr.ie>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Colin Guthrie wrote:
> 'Twas brillig, and Stefan Schoenleitner at 13/04/10 16:23 did gyre and
> gimble:
>> Hi,
>>
>> I finally managed to write an ALSA I/O plugin that does what I want.
>> The plugin supports both playback and capture.
>>
>> Now I would like to write a simple audio application that takes audio
>> samples
>>
>> 	* from the microphone and plays it back on my plugin
>> and
>> 	* from the plugin (capture) and plays it back on the speakers
>>
> 
> This sounds like something that would be more appropriate for jack
> http://jackaudio.org/

Thanks for your response, that really sounds like a job for JACK.

However, due to the nature of jack it seems that running the jack-daemon
is always necessary.
As my code is supposed to work on a very small scale embedded target, I
would prefer to have a small stand-alone application that does not
require a running jack-daemon.

* Do you know if it is possible to use the jack functionality without
having to run the jack-daemon ?

>> Hence as long as the application is running, it should do the above.
>>
>> * Is there a special ALSA way to route audio from one PCM to another ?
>>
>> * If not, I suppose it would just work if I open the plugin PCM and the
>> hw PCM at the same time and copy audio frames between them ?
> 
> Dealing with this can be quite complex, especially if the pcms are
> clocked of different sources, you have to deal with a degree of
> resampling to ensure that clock skew doesn't get out of control.

Both PCMs are on the same machine, hence they should be clocked from the
same source as well ?

cheers,
stefan
