From: Rolf Theunissen <rolf.theunissen@gmail.com>
Subject: Re: Hardware events
Date: Tue, 30 Nov 2010 12:48:27 +0100
Message-ID: <4CF4E48B.3030600@gmail.com>
References: <4CF39483.4050704@gmail.com> <4CF4B112.3070705@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 43BA01037F3
	for <alsa-devel@alsa-project.org>; Tue, 30 Nov 2010 12:48:31 +0100 (CET)
Received: by ewy19 with SMTP id 19so2592785ewy.38
	for <alsa-devel@alsa-project.org>; Tue, 30 Nov 2010 03:48:31 -0800 (PST)
In-Reply-To: <4CF4B112.3070705@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Clemens Ladisch wrote:
> Rolf Theunissen wrote:
>    
>> For some hardware devices (for instance the ThinkPad EC) the volume can
>> be changed by (only) hardware buttons.
>> ...
>> This raises the following question: is it possible to detect the events
>> originating from the hardware in the functions that handle the callbacks
>> (set via snd_mixer_elem_set_callback/snd_hctl_elem_set_callback)? This
>> would allow to implement an OSD that only responds to the hardware
>> buttons and that would ignore events originating from "software".
>>      
> The control notifications are for all changes of the control.
>
> If it is not possible to change the volume in software, then the driver
> must not set the control to be writable.
>
>
> Regards,
> Clemens
>    

The issue is not that the driver should be writable or not. Even, if the 
volume is read only, an OSD can be shown for any event. However when the 
volume can be set both in hardware and in software, the end-user will 
expect different behavior.
For instance, if the user changes the volume in a music player 
application, no OSD should be shown as this clutters the interface. But 
if the volume is changed from the hardware a OSD should be shown.

I don't know if a ticket should be opened for this issue.

Regards,
Rolf
