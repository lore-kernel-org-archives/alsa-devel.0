From: Robert Hardy <rhardy@webcon.ca>
Subject: Re: Re: [ALSA - driver 0001938]: EPIPE on Audigy with
 surround sound when seeking in 6 channel sound file
Date: Thu, 30 Mar 2006 11:25:08 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0603301053330.11382@thor.webcon.net>
References: <Pine.LNX.4.64.0603291645290.6977@thor.webcon.net>
 <s5h3bh0l10a.wl%tiwai@suse.de> <s5hzmj8jlpx.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hzmj8jlpx.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, 30 Mar 2006, Takashi Iwai wrote:
> At Thu, 30 Mar 2006 11:45:09 +0200,
>> At Wed, 29 Mar 2006 17:18:59 -0500 (EST),
>> Robert Hardy wrote:
>>> Basically I was trying to point out I am also affected by this bug:
>>> https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1938
>>>
>>> This unfortunately made no difference here. I'm running 2.6.16-rh3 which is 2.6.16.1 with
>>> custom patches including the recent git commit for [ALSA] version 1.0.11rc4 from here:
>>> http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=1c2e02750b992703a8a18634e08b04353face243
>>>
>>> My sound card:
>>> 02:07.0 Multimedia audio controller: Creative Labs SB0400 Audigy2 Value
>>>          Subsystem: Creative Labs: Unknown device 1001
>>>
>>> This card once worked fine unfortunately I'm not sure with what
>>> mplayer/alsa-lib/alsa-driver/kernel....
>>>
>>> I'm running a i686/32bit mplayer in a 64 bit environment.

>> Strange.  It works fine on my test syetm now with 32bit mplayer on
>> 64bit kernel.
>
> Maybe a dumb question: Did you properly install 32bit library?
>
> I often compile/install 64bit lib for debugging 32bit problems, and
> throw precious hours aways...

I rolled those patches into my alsa-lib rpm before I tested them. Both my
i686 and x86_64 rpms have the patches. My currrent system has:

> rpm -qa --qf='%{name}-%{version}-%{release}-%{arch}\n' | grep alsa
alsa-lib-devel-1.0.11-3.rc4.2.el4-x86_64
alsa-utils-1.0.11-2.rc4.1.el4-x86_64
alsa-lib-1.0.11-3.rc4.2.el4-i686
alsa-lib-devel-1.0.11-3.rc4.2.el4-i686
alsa-lib-1.0.11-3.rc4.2.el4-x86_64

Wanting to make sure it wasn't some how getting confused by the x86_64
libraries, I just now tested only the i686 rpms in my chrooted el4 i386
environment and the same problem happened.

In Chroot> rpm -qa --qf='%{name}-%{version}-%{release}-%{arch}\n' | grep alsa
alsa-utils-1.0.11-2.rc4.1.el4-i686
alsa-lib-devel-1.0.11-3.rc4.2.el4-i686
alsa-lib-1.0.11-3.rc4.2.el4-i686

Regards,
Rob

-- 
---------------------"Happiness is understanding."----------------------
Robert Hardy, B.Eng Computer Systems                  C.E.O. Webcon Inc.
rhardy <at> webcon <dot> ca    GPG Key available          (613) 276-7327


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
