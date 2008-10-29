From: Jason Harvey <softdevice@jasonline.co.uk>
Subject: Re: sbxfi - What works/doesn't summary
Date: Wed, 29 Oct 2008 17:01:29 +0000
Message-ID: <490896E9.9@jasonline.co.uk>
References: <4906FA8C.4030501@jasonline.co.uk>	<490709EF.7090803@gmail.com>	<49074E98.7070506@jasonline.co.uk>	<s5h3aigilum.wl%tiwai@suse.de>	<490768FF.3020807@jasonline.co.uk>	<s5hy708h5r1.wl%tiwai@suse.de>	<490772FA.9060508@jasonline.co.uk>	<4907EA7F.4090402@gmail.com>	<4907EEBE.5090604@gmail.com>	<49088718.8000308@jasonline.co.uk>
	<s5hr65z1jgy.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from homer.jasonline.co.uk (78-86-168-217.zone2.bethere.co.uk
	[78.86.168.217]) by alsa0.perex.cz (Postfix) with ESMTP id DB645244AD
	for <alsa-devel@alsa-project.org>; Wed, 29 Oct 2008 18:01:25 +0100 (CET)
In-Reply-To: <s5hr65z1jgy.wl%tiwai@suse.de>
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
Cc: Takashi Iwai <tiwai@suse.de>, The Source <thesourcehim@gmail.com>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> The last change was:
>    commit 941ec54e47f635f63621d3852253d9ef9b11132f
>    Author: Takashi Iwai <tiwai@suse.de>
>    Date:   Tue Oct 28 08:00:24 2008 +0100
>
>       sbxfi - Use 48kHz as default
>
> Though, I'm glad to hear that it's working, of course :)
>
> Or, did you apply my last patch I posted?
>   
> Hmm... I haven't changed sbxfi code since yesterday.
Ah... a little version confusion here...

This morning I downloaded unstable again and tried the patch.
It wasn't working, garbled sound through pulseaudio as previously mentioned.
I worked out my pulse installation was missing a few packages (Fedora 
folk why aren't all pulse related packages named pulse-* ?)
Not sure what changed but once all the pulse pieces were in place and I 
had locked the default device to the sbxfi it all sounded great.
That was without the patch.

Just applied the patch again and everything still works.

>   
>> Can't get mplayer to play at the same time as flash in firefox but I 
>> don't really know if I've ever managed to do that under pulse...
>>     
>
> The flash with PA can work with libflashsupport.
> It'd be better to use it with flash-10, though.
Thank you, I had grabbed flash 10 a couple of days ago as I tried to get 
it all going.
Although it was making nice sounds it turns out it was not using pulse.
Now I have the volume control installed I can see what is going on...
Cured flash by installing libflashsupport.i386
libflashsupport.x86_64 package doesn't really help with adobe's i386 
flash. Doh.

Jason
