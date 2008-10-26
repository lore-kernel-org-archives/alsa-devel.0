From: Jason Harvey <softdevice@jasonline.co.uk>
Subject: Re: Backported sbxfi driver. Pulse works!
Date: Sun, 26 Oct 2008 08:45:15 +0000
Message-ID: <49042E1B.8080304@jasonline.co.uk>
References: <4900A4FA.7020300@jasonline.co.uk>	<s5h63njw2c0.wl%tiwai@suse.de>	<4900B523.3020801@jasonline.co.uk>	<s5h8wsf3spl.wl%tiwai@suse.de>	<4900DBBD.2020806@jasonline.co.uk>	<s5hljwee68t.wl%tiwai@suse.de>	<49017FBF.4030005@jasonline.co.uk>	<s5hfxmm47kb.wl%tiwai@suse.de>	<20081025130652.GA27621@rzle423.uni-duisburg.de>	<s5hej24psn6.wl%tiwai@suse.de>	<20081025194255.GA27872@rzle423.uni-duisburg.de>	<s5hod18fntg.wl%tiwai@suse.de>	<49038448.3090704@jasonline.co.uk>
	<s5h8wsb22le.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from homer.jasonline.co.uk (78-86-168-217.zone2.bethere.co.uk
	[78.86.168.217]) by alsa0.perex.cz (Postfix) with ESMTP id 3AAF8244B2
	for <alsa-devel@alsa-project.org>; Sun, 26 Oct 2008 09:45:27 +0100 (CET)
In-Reply-To: <s5h8wsb22le.wl%tiwai@suse.de>
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
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Sat, 25 Oct 2008 21:40:40 +0100,
> Jason Harvey wrote:
>   
>> Latest unstable (25Oct 19:57) works from command line with mplayer, 
>> without the proc oss fix.
>> aplay still works but only with dmix.
>>     
>
> Do you have no sound quality problem with dmix like other people?
>   
No dmix trouble when I run "aplay -Dplug:dmix:0 wn.wav" produces perfect 
sound. Wav is three minutes long and it was 100% ok throughout.

>   
>> Now also almost working in gnome with pulse, sound is recognisable but 
>> with lots of interference/corruption.
>>     
>
> What about base_rate=48000 option?
>   
Genius! It is now working through pulse PERFECTLY.
Have two instances of mplayer playing right this second.
Can hear both tracks playing without any trouble.

I just edited one line in /etc/pulse/daemon.conf not sure it is the 
option you were talking about above but it works for me!

Will put the card into my 64bit main machine in a minute and try it there :)

Jason
