From: "Patrick Shirkey" <pshirkey@boosthardware.com>
Subject: Re: Testing/Debugging alc668 with ASUS N750JK
Date: Fri, 1 Aug 2014 20:33:44 +1000 (EST)
Message-ID: <61934.86.107.254.57.1406889224.squirrel@boosthardware.com>
References: <cover.1406259578.git.nicoleotsuka@gmail.com>
 <f4ff79269a1680f9ce128e0e98fea926d3a41834.1406259578.git.nicoleotsuka@gmail.com>
 <53D1DC0B.1000905@gmail.com>
 <63638.86.107.254.57.1406266836.squirrel@boosthardware.com>
 <CAN8cciboNrRRFBQjX66qud7KoTCqsDHxvFAws9-ywasjemtYbQ@mail.gmail.com>
 <59187.86.107.254.57.1406362728.squirrel@boosthardware.com>
 <CAN8cciax7RreogV0otMdLt0y-dOTrZD3D_ih0doAC9F_XkJ1ew@mail.gmail.com>
 <57315.86.107.254.57.1406609183.squirrel@boosthardware.com>
 <CAN8ccia3mi9G2oyaYyvJx14xu6F8dLhNZ6r0dpraO1F8qeLjBg@mail.gmail.com>
 <55293.86.107.254.57.1406791952.squirrel@boosthardware.com>
 <CAN8cciZ_KT9HG3K3xW-X-PFvWya1zW46JXccq-jd5v6uaeTjOA@mail.gmail.com>
 <59490.86.107.254.57.1406831144.squirrel@boosthardware.com>
 <CAN8cciYrj25NfmjD86ndzJd5r=D0bMNHE55JuEKichznAkAUHA@mail.gmail.com>
 <61402.86.107.254.57.1406884028.squirrel@boosthardware.com>
 <CAN8cciZfJftpbFmrREXgQ9F=tjV6MQ_72NLznjKv0g=L2vGeTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from boosthardware.localdomain (boosthardware.com [88.198.122.139])
 by alsa0.perex.cz (Postfix) with ESMTP id DEFE5265026
 for <alsa-devel@alsa-project.org>; Fri,  1 Aug 2014 12:33:45 +0200 (CEST)
In-Reply-To: <CAN8cciZfJftpbFmrREXgQ9F=tjV6MQ_72NLznjKv0g=L2vGeTQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


On Fri, August 1, 2014 8:04 pm, Raymond Yau wrote:
>>
>> alsa-info:
>>
>> retask and apply
>> http://boosthardware.com/alsa-info1.txt
>>
>> store and reboot
>> http://boosthardware.com/alsa-info2.txt
>>
>>
>
> Any reason to use asus-mode4 and hda-jack-retask at the same time ?
>

I had it in place because at one point it seemed to allow PA to have
addition profiles other than stereo. However the line below seems to be a
better combination.

> Try model=auto when you use patch=,hda-jack-retask.fw
>

That nugget of information seems to have enabled the bass speaker in alsa
after the last reboot.

/etc/modprobe.d/alsa-base.conf
options snd-hda-intel model=auto patch=,hda-jack-retask.fw


> Your alsa-info missing many important info , need all info from alsactl,
> amixer, sysfs about the driver init pins and user init pins, allay/arecord
> -l
>

http://boosthardware.com/alsa-info4.txt

> No information about which Jack have been retasked
>

For the info file above I have the following retask assignments:

0x14 Line out (front)
0x15 Line out (center/LFE)
0x16 Line Out (Back)
0x18 Internal Speaker
0x19 Internal Speaker(Back)
0x1a Internal mic

- With the following command I can hear "rear center" through the sonic
master speaker when channel 5 is testing.

speaker-test -D hw:1 -c 6 -t wav

- I do not hear any sound when rear left/right is testing.

- I do not hear any audio through the LFE with PA test on any of the audio
profiles.

- I will play around with the retask assignments now that something seems
to be working. Looks like I'm on the right track now.

Thanks for all your help so far.




--
Patrick Shirkey
Boost Hardware Ltd
