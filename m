From: Angel Tsankov <fn42551@fmi.uni-sofia.bg>
Subject: Re: alsactl restore: unknown hardware: ymf724f
Date: Sat, 27 Feb 2010 10:09:35 +0200
Message-ID: <hmajvg$6jp$1@dough.gmane.org>
References: <hm5aba$p65$1@dough.gmane.org>	<alpine.LNX.2.00.1002250915480.28127@eeebox2.perex-int.cz>	<hm5u2i$2h7$1@dough.gmane.org>	<alpine.LNX.2.00.1002251502380.28127@eeebox2.perex-int.cz>	<4f3252891002251511p4605f104jdac236e589d01149@mail.gmail.com>	<hm8cus$56i$1@dough.gmane.org>
	<4f3252891002261806i57ea7580rcd4da69cf67b8754@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030806080700030307020002"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 0D0C6103A5A
	for <alsa-devel@alsa-project.org>; Sat, 27 Feb 2010 09:09:33 +0100 (CET)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1NlHjw-0000mv-7E
	for alsa-devel@alsa-project.org; Sat, 27 Feb 2010 09:09:32 +0100
Received: from client-144-140.speedy-net.bg ([78.159.144.140])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Sat, 27 Feb 2010 09:09:32 +0100
Received: from fn42551 by client-144-140.speedy-net.bg with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Sat, 27 Feb 2010 09:09:32 +0100
In-Reply-To: <4f3252891002261806i57ea7580rcd4da69cf67b8754@mail.gmail.com>
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

This is a multi-part message in MIME format.
--------------030806080700030307020002
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Raymond Yau wrote:
> 2010/2/26 Angel Tsankov <fn42551@fmi.uni-sofia.bg>
> 
>> Raymond Yau wrote:
>>> 2010/2/25 Jaroslav Kysela <perex@perex.cz>
>>>
>>>> On Thu, 25 Feb 2010, Angel Tsankov wrote:
>>>>
>>>>> Jaroslav Kysela wrote:
>>>>>> On Thu, 25 Feb 2010, Angel Tsankov wrote:
>>>>>>
>>>>>>> Hello,
>>>>>>>
>>>>>>> I run 'alsactl restore' on a machine with 2 sound cards -- a built-in
>>>>>>> Intel Corporation 82801EB/ER (ICH5/ICH5R) AC'97 Audio Controller (rev
>>>>>>> 02) and a non-built-in Yamaha Corporation YMF-724F [DS-1 Audio
>>>>>>> Controller] (rev 03) -- and get the following message:
>>>>>>>
>>>>>>> Unknown hardware: "YMF724F" "SigmaTel STAC9700,83,84"
>> "AC97a:83847600"
>>>>>>> "0x1073" "0x000d"
>>>>>>> Hardware is initialized using a guess method
>>>>>>>
>>>>>>> As a consequence the volume levels of the Yamaha card do not get
>>>>>>> restored to the levels stored in /etc/asound.state.  The volume
>> levels
>>>>>>> of the built-in card however are properly restored.  The asound.state
>>>>>>> file has been created by executing 'alsactl store'.
>>>>>>>
>>>>>>> The kernel has been built with support for ALSA.  I've built and
>>>>>>> installed the kernel modules for both cards (not the ones in the
>>>>>>> alsa-driver package but those that come with kernel version
>> 2.6.30.2).
>>>>>>> Any ideas why alsactl cannot find the hardware it has previously
>>>>>>> identified as "YMF724F", "SigmaTel STAC9700,83,84", and so on?
>>>>>> The logic of alsactl is to restore the state from /etc/asound.state if
>>>> it
>>>>>> is valid. It seems like the set_controls() function in alsactl/state.c
>>>>>> returns an error code for a reason.
>>>>>>
>>>>>> Could you try to compile the latest alsa-utils snapshot
>>>>>> (http://www.alsa-project.org/snapshot/) and run './alsactl -d
>> restore'
>>>> in
>>>>>> alsa-utils/alsactl directory? A warning (fail reason) should be
>> printed.
>>>>> I've attached a bash shell script that I used to download, configure,
>>>>> compile, and run alsactl.  I've also attached a .log file with stdout
>> and
>>>>> stderr that I got while executing the script.
>>>> Thanks. I've added more debug print lines to state.c. Could you rerun
>> your
>>>> script and append also '/etc/asound.state' file and output from
>>>> 'alsa-info.sh --no-upload' to your output tarballs? Send me this tarball
>>>> privately or just an URL to this list.
>>>>
>>>>                                        Thanks,
>>>>                                                 Jaroslav
>>>>
>>>>
>>> did alsactl restore those IFACE_PCM volume since they are supposed at 0dB
>> by
>>> default whenever the subdevice is open ?
>>>
>>> store the values in asound.state seem to be for debugging only
>>>
>>>     control.61 {
>>>         comment.access 'read write inactive'
>>>         comment.type INTEGER
>>>         comment.count 2
>>>         comment.range '0 - 32768'
>>>         iface PCM
>>>         subdevice 1
>>>         name 'PCM Playback Volume'
>>>         value.0 26214
>>>         value.1 26214
>>>     }
>> In fact, alsactl seems to restore the volume levels (despite the
>> "Unknown hardware" message) when the system is up and running, but it
>> does not restore the PCM and master levels at boot time. This should be
>> done when the hardware is detected by udev, as I have the following udev
>> rule:
>>
>> KERNEL=="controlC[0-9]*", ACTION=="add", RUN+="/usr/sbin/alsactl restore
>> %n"
>>
>>
>> Angel Tsankov
>>
>>
> Can you store the iface PCM "PCM Playback Volume" in asound.state while you
> are playing audio ?
> 
> alsactl can store the value since the control is active when the subdevice
> is open
> 
> alsactl already skip restoring of those control when it is not active , so
> the problem seem not related to those controls
> 
> However via82xx also have those hardware specific controls

It seems that when I store the values while the sound card is playing I 
get one more control in asound.state (see attached archive).

Here's the test I did:

1. I removed /etc/asound.state (just in case);
2. I made sure the sound card is not playing, ran 'alsactl store', and 
renamed /etc/asound.state to /etc/asound.state.not-playing;
3. I started vlc, played some music, ran 'alsactl store' once again, and 
renamed /etc/asound.state to /etc/asound.state.playing;

Then I diff'ed the two files and found out that they are different. I'm 
sending them as alsactl created them.


Regards,
Angel Tsankov

--------------030806080700030307020002
Content-Type: application/octet-stream;
 name="asound.state.tar.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="asound.state.tar.bz2"

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
muinK2UkwwaA9Cf+LuSKcKEg7qowTg==
--------------030806080700030307020002
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------030806080700030307020002--
