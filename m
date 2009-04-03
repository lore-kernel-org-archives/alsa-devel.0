From: Daniel Mack <daniel@caiaq.de>
Subject: Re: Device creation order
Date: Fri, 3 Apr 2009 09:40:09 +0200
Message-ID: <20090403074009.GD15466@buzzloop.caiaq.de>
References: <20090403015429.GA702@tango.0pointer.de>
	<alpine.LNX.2.00.0904030904160.17368@eeebox2.perex-int.cz>
	<20090403072030.GB15466@buzzloop.caiaq.de>
	<alpine.LNX.2.00.0904030921280.17368@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 1965F10380A
	for <alsa-devel@alsa-project.org>;
	Fri,  3 Apr 2009 09:40:13 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.0904030921280.17368@eeebox2.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Lennart Poettering <mznyfn@0pointer.de>
List-Id: alsa-devel@alsa-project.org

On Fri, Apr 03, 2009 at 09:31:40AM +0200, Jaroslav Kysela wrote:
>>> Unfortunately, driver may use more complex scenarios like:
>>>
>>> - some hardware requires additional firmware - in this case devices
>>>    might be created, but they are not useable until firmware is loaded
>>> - dynamic device creation at runtime - for example we have an
>>>    experimental HDA driver configuration code which might change
>>>    the arrangement of PCM devices on request from the user space
>>>
>>> I would suggest to wait awhile with some small timeout (0.5 sec?) for all
>>> devices to get the usual static arrangement working and handle extra
>>> dynamic cases, too.
>>
>> Wouldn't the real fix be to make sure that the event from hal/udev
>> happens after all the initialization has finished, i.e. the device got
>> its firmware, all connected layers finished their work etc? Before all
>> that, the audio device is not really available, right?
>
> But even with this extension, the user space should handle dynamic device 
> reconfiguration (my second example case). The question is, if it makes  
> sense to handle group of devices per card basis or just take single  
> devices and dynamically handle device changes.

That's another issue IMO, which needs different attention. Signaling audio
devices being added (via udev) before it's actually usable is rather a bug
than a missing extension, wouldn't you say?

Daniel
