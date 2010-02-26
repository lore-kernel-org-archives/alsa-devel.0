From: Angel Tsankov <fn42551@fmi.uni-sofia.bg>
Subject: Re: alsactl restore: unknown hardware: ymf724f
Date: Fri, 26 Feb 2010 18:36:03 +0200
Message-ID: <hm8t92$4kd$1@dough.gmane.org>
References: <hm5aba$p65$1@dough.gmane.org>	<alpine.LNX.2.00.1002250915480.28127@eeebox2.perex-int.cz>	<hm5u2i$2h7$1@dough.gmane.org>	<alpine.LNX.2.00.1002251502380.28127@eeebox2.perex-int.cz>	<4f3252891002251511p4605f104jdac236e589d01149@mail.gmail.com>	<hm8cus$56i$1@dough.gmane.org>
	<1267193154.29204.0.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 2CC9C103A1C
	for <alsa-devel@alsa-project.org>; Fri, 26 Feb 2010 17:36:03 +0100 (CET)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1Nl3AX-0007PA-PC
	for alsa-devel@alsa-project.org; Fri, 26 Feb 2010 17:36:01 +0100
Received: from client-144-140.speedy-net.bg ([78.159.144.140])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Fri, 26 Feb 2010 17:36:01 +0100
Received: from fn42551 by client-144-140.speedy-net.bg with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Fri, 26 Feb 2010 17:36:01 +0100
In-Reply-To: <1267193154.29204.0.camel@localhost.localdomain>
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

Pacho Ramos wrote:
> El vie, 26-02-2010 a las 13:57 +0200, Angel Tsankov escribi=F3:
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
>>>>>>> I run 'alsactl restore' on a machine with 2 sound cards -- a built-=
in
>>>>>>> Intel Corporation 82801EB/ER (ICH5/ICH5R) AC'97 Audio Controller (r=
ev
>>>>>>> 02) and a non-built-in Yamaha Corporation YMF-724F [DS-1 Audio
>>>>>>> Controller] (rev 03) -- and get the following message:
>>>>>>>
>>>>>>> Unknown hardware: "YMF724F" "SigmaTel STAC9700,83,84" "AC97a:838476=
00"
>>>>>>> "0x1073" "0x000d"
>>>>>>> Hardware is initialized using a guess method
>>>>>>>
>>>>>>> As a consequence the volume levels of the Yamaha card do not get
>>>>>>> restored to the levels stored in /etc/asound.state.  The volume lev=
els
>>>>>>> of the built-in card however are properly restored.  The asound.sta=
te
>>>>>>> file has been created by executing 'alsactl store'.
>>>>>>>
>>>>>>> The kernel has been built with support for ALSA.  I've built and
>>>>>>> installed the kernel modules for both cards (not the ones in the
>>>>>>> alsa-driver package but those that come with kernel version 2.6.30.=
2).
>>>>>>> Any ideas why alsactl cannot find the hardware it has previously
>>>>>>> identified as "YMF724F", "SigmaTel STAC9700,83,84", and so on?
>>>>>> The logic of alsactl is to restore the state from /etc/asound.state =
if
>>>> it
>>>>>> is valid. It seems like the set_controls() function in alsactl/state=
.c
>>>>>> returns an error code for a reason.
>>>>>>
>>>>>> Could you try to compile the latest alsa-utils snapshot
>>>>>> (http://www.alsa-project.org/snapshot/) and run './alsactl -d restor=
e'
>>>> in
>>>>>> alsa-utils/alsactl directory? A warning (fail reason) should be prin=
ted.
>>>>> I've attached a bash shell script that I used to download, configure,
>>>>> compile, and run alsactl.  I've also attached a .log file with stdout=
 and
>>>>> stderr that I got while executing the script.
>>>> Thanks. I've added more debug print lines to state.c. Could you rerun =
your
>>>> script and append also '/etc/asound.state' file and output from
>>>> 'alsa-info.sh --no-upload' to your output tarballs? Send me this tarba=
ll
>>>> privately or just an URL to this list.
> =

> =

> Looks similar to my problem:
> http://www.spinics.net/lists/alsa-devel/msg31422.html

Most interestingly, my exit status is the same -- 157.  I thought it was 99.


Regards,
Angel Tsankov
