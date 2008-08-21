From: Dmitry Butskoy <buc@odusz.so-cdu.ru>
Subject: Re: [snd-bt87x]: seems cannot powerup after
	powerdown...
Date: Thu, 21 Aug 2008 18:39:34 +0400
Message-ID: <48AD7E26.5060009@odu.neva.ru>
References: <48A993AC.2010900@odu.neva.ru> <s5hzln9wa0t.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail2.odu.neva.ru (mail2.odu.neva.ru [194.85.100.6])
	by alsa0.perex.cz (Postfix) with ESMTP id C5E92244F3
	for <alsa-devel@alsa-project.org>;
	Thu, 21 Aug 2008 16:39:35 +0200 (CEST)
In-Reply-To: <s5hzln9wa0t.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>, Trent Piepho <xyzzy@speakeasy.org>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> Added Clemens and alsa-devel to Cc.
>
> At Mon, 18 Aug 2008 19:22:20 +0400,
> Dmitry Butskoy wrote:
>   
>> Hi,
>>
>> Recently snd-bt87x driver has started to use CTL_A_PWRDN bit, see
>> http://git.kernel.org/?p=linux/kernel/git/stable/linux-2.6.26.y.git;a=commitdiff;h=950fb626dc28e17ae4ad01dba07957bdc6e0b997
>>
>> Unfortunately, it produces a regression, at least in my case.
>>
>> I have "AVerMedia TVPhone 98" card, lspci is:
>>     
>>> 03:05.0 Multimedia video controller: Brooktree Corporation Bt878 Video 
>>> Capture (rev 11)
>>> 03:05.1 Multimedia controller: Brooktree Corporation Bt878 Audio 
>>> Capture (rev 11)
>>>       
>> My card has no additional chip for digital sound, hence only analog is 
>> available.
>>
>> After upgrading from 2.6.23 to 2.6.25, I have discovered no more sound 
>> from my snd-bt87x device. Considering the code changes in the dirver, 
>> I've guessed that it could be some power issues.
>>
>> Compiling the newest driver without CTL_A_PWRDN (ie. with that changes 
>> reverted back) I got the sound back again.
>>
>> Note, that it is not enough to rmmod the old module and insmod the new. 
>> I have to reboot computer completely with the new driver to take changes 
>> in effect.
>>     

It seems that the issue depends on an environment...

I have two similar v4l-cards (as described before), one in a desktop and 
one in IBM x345 server (catch TV and stream it on LAN).

The same card on IBM x345 works fine with new driver!

The issue affects only my desktop system.

There are some strange side effects on my desktop as well. Normally I 
hear sound by the patch cable, connecting audio output from v4l card 
with Line input of the desktop's primary sound. When I try to do, fe.:

arecord -D hw:1,1 -f S16_LE -r 120000 - | od -x

the right stereo channel on the primary sound disappears (and comes back 
after some time after Ctrl-C). It seems that the opening of hw:1,1 cause 
the right stereo to mute from the v4l card external output...


~buc
