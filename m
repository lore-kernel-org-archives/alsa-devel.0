From: Angel Tsankov <fn42551@fmi.uni-sofia.bg>
Subject: Re: alsactl restore: unknown hardware: ymf724f
Date: Fri, 26 Feb 2010 13:57:32 +0200
Message-ID: <hm8cus$56i$1@dough.gmane.org>
References: <hm5aba$p65$1@dough.gmane.org>	<alpine.LNX.2.00.1002250915480.28127@eeebox2.perex-int.cz>	<hm5u2i$2h7$1@dough.gmane.org>	<alpine.LNX.2.00.1002251502380.28127@eeebox2.perex-int.cz>
	<4f3252891002251511p4605f104jdac236e589d01149@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 42A27103805
	for <alsa-devel@alsa-project.org>; Fri, 26 Feb 2010 12:57:33 +0100 (CET)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1Nkyp0-0007dM-CR
	for alsa-devel@alsa-project.org; Fri, 26 Feb 2010 12:57:30 +0100
Received: from client-144-140.speedy-net.bg ([78.159.144.140])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Fri, 26 Feb 2010 12:57:30 +0100
Received: from fn42551 by client-144-140.speedy-net.bg with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Fri, 26 Feb 2010 12:57:30 +0100
In-Reply-To: <4f3252891002251511p4605f104jdac236e589d01149@mail.gmail.com>
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

Raymond Yau wrote:
> 2010/2/25 Jaroslav Kysela <perex@perex.cz>
> 
>> On Thu, 25 Feb 2010, Angel Tsankov wrote:
>>
>>> Jaroslav Kysela wrote:
>>>> On Thu, 25 Feb 2010, Angel Tsankov wrote:
>>>>
>>>>> Hello,
>>>>>
>>>>> I run 'alsactl restore' on a machine with 2 sound cards -- a built-in
>>>>> Intel Corporation 82801EB/ER (ICH5/ICH5R) AC'97 Audio Controller (rev
>>>>> 02) and a non-built-in Yamaha Corporation YMF-724F [DS-1 Audio
>>>>> Controller] (rev 03) -- and get the following message:
>>>>>
>>>>> Unknown hardware: "YMF724F" "SigmaTel STAC9700,83,84" "AC97a:83847600"
>>>>> "0x1073" "0x000d"
>>>>> Hardware is initialized using a guess method
>>>>>
>>>>> As a consequence the volume levels of the Yamaha card do not get
>>>>> restored to the levels stored in /etc/asound.state.  The volume levels
>>>>> of the built-in card however are properly restored.  The asound.state
>>>>> file has been created by executing 'alsactl store'.
>>>>>
>>>>> The kernel has been built with support for ALSA.  I've built and
>>>>> installed the kernel modules for both cards (not the ones in the
>>>>> alsa-driver package but those that come with kernel version 2.6.30.2).
>>>>> Any ideas why alsactl cannot find the hardware it has previously
>>>>> identified as "YMF724F", "SigmaTel STAC9700,83,84", and so on?
>>>> The logic of alsactl is to restore the state from /etc/asound.state if
>> it
>>>> is valid. It seems like the set_controls() function in alsactl/state.c
>>>> returns an error code for a reason.
>>>>
>>>> Could you try to compile the latest alsa-utils snapshot
>>>> (http://www.alsa-project.org/snapshot/) and run './alsactl -d restore'
>> in
>>>> alsa-utils/alsactl directory? A warning (fail reason) should be printed.
>>> I've attached a bash shell script that I used to download, configure,
>>> compile, and run alsactl.  I've also attached a .log file with stdout and
>>> stderr that I got while executing the script.
>> Thanks. I've added more debug print lines to state.c. Could you rerun your
>> script and append also '/etc/asound.state' file and output from
>> 'alsa-info.sh --no-upload' to your output tarballs? Send me this tarball
>> privately or just an URL to this list.
>>
>>                                        Thanks,
>>                                                 Jaroslav
>>
>>
> did alsactl restore those IFACE_PCM volume since they are supposed at 0dB by
> default whenever the subdevice is open ?
> 
> store the values in asound.state seem to be for debugging only
> 
>     control.61 {
>         comment.access 'read write inactive'
>         comment.type INTEGER
>         comment.count 2
>         comment.range '0 - 32768'
>         iface PCM
>         subdevice 1
>         name 'PCM Playback Volume'
>         value.0 26214
>         value.1 26214
>     }

In fact, alsactl seems to restore the volume levels (despite the 
"Unknown hardware" message) when the system is up and running, but it 
does not restore the PCM and master levels at boot time. This should be 
done when the hardware is detected by udev, as I have the following udev 
rule:

KERNEL=="controlC[0-9]*", ACTION=="add", RUN+="/usr/sbin/alsactl restore %n"


Angel Tsankov
