From: Susan Cragin <susancragin@earthlink.net>
Subject: Re: 15 April unstable does not handle wave-in
Date: Wed, 15 Apr 2009 12:17:37 -0400 (GMT-04:00)
Message-ID: <12307879.1239812258033.JavaMail.root@elwamui-muscovy.atl.sa.earthlink.net>
Reply-To: Susan Cragin <susancragin@earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from elasmtp-scoter.atl.sa.earthlink.net
	(elasmtp-scoter.atl.sa.earthlink.net [209.86.89.67])
	by alsa0.perex.cz (Postfix) with ESMTP id 4BB23244DA
	for <alsa-devel@alsa-project.org>;
	Wed, 15 Apr 2009 18:17:39 +0200 (CEST)
Received: from [209.86.224.42] (helo=elwamui-muscovy.atl.sa.earthlink.net)
	by elasmtp-scoter.atl.sa.earthlink.net with esmtpa (Exim 4.67)
	(envelope-from <susancragin@earthlink.net>) id 1Lu7nu-0005I8-2Z
	for alsa-devel@alsa-project.org; Wed, 15 Apr 2009 12:17:38 -0400
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

PLEASE IGNORE THE ONE I JUST SENT OFF-LIST. THANKS. 

>> >At Wed, 15 Apr 2009 07:22:08 -0400 (GMT-04:00),
>> >Susan Cragin wrote:
>> >> 
>> >> I just downloaded and installed the unstable snapshot 15-April 9:55. 
>> >> Both my sound cards are shown by asoundconf, but neither works. The wave-in wave-out is still not recognized. 
>> >
>> >I suppose you are referring to CA0110?  Could you elaborate?
>> >
>> >The ca0110 codec support itself has no big change.  The last one was
>> >in Feb. 18.  The rest is either HD-audio core or PCM core.  But these
>> >have little to do with the probing...
>> >
>> >
>> >Takashi
>> 
>> Please excuse my technical ignorance. Here is everything I know. 
>> My hda-intel card is also not being recognized after installing alsa-driver-unstable. The only thing that works is my usb microphone. 
>> I think that the program is not giving the instruction to have
>> modules inserted on bootup.  
>> I have attached sample modprobe, aplay, asoundconf, modules,
>> alsa-base.conf 
>
>Check /proc/asound/version.  Is it the latest one?
>
>> $ modprobe snd-card-hda-intel
>
>modprobe snd-hda-intel
>
>
>Takashi

$ sudo cat /proc/asound/version
Advanced Linux Sound Architecture Driver Version 1.0.19.
Compiled on Apr 15 2009 for kernel 2.6.28-11-generic (SMP).
susan@ubuntu:~$ modprobe snd-hda-intel
WARNING: All config files need .conf: /etc/modprobe.d/oss-compat, it will be ignored in a future release.
susan@ubuntu:~$ 
