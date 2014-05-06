From: "Sathish Kumar Balasubramaniam -ERS, HCL Tech" <b-sathishkumar@hcl.com>
Subject: Opening (even read-only) of /dev/snd/pcmC0D0p says
 Operation not permitted
Date: Tue, 6 May 2014 16:40:59 +0000
Message-ID: <5D833673AB94D9489A7F7F73E9E611C814AD4480@chn-hclt-mbs08.HCLT.CORP.HCL.IN>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from GWS07.hcl.com (gws07.hcl.com [192.8.186.130])
 by alsa0.perex.cz (Postfix) with ESMTP id 0AA2F26179C
 for <alsa-devel@alsa-project.org>; Tue,  6 May 2014 18:41:02 +0200 (CEST)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

Please can anyone let me know how to debug more or fix the following issue

I tried to play a wav file using aplay. Its giving the following error

root@host# strace aplay a2002011001-e02.wav
execve("/usr/bin/aplay", ["aplay", "a2002011001-e02.wav"], [/* 15 vars */]) = 0
...
...
open("/dev/snd/pcmC0D0p", O_RDWR|O_NONBLOCK|O_CLOEXEC) = -1 EPERM (Operation not permitted)
close(3)                                = 0
write(2, "aplay: main:722: ", 17aplay: main:722: )       = 17
write(2, "audio open error: Operation not "..., 41audio open error: Operation not permitted) = 41
write(2, "\n", 1
)                       = 1


I tried to write a small program like the following

err = open("/dev/snd/pcmC0D0p", O_RDONLY);                              (I tried O_RDWR|O_NONBLOCK|O_CLOEXEC also)
printf("err = %d, errno = %s.\n", err, strerror(errno));

Even the above failed saying "err = -1, errno = Operation not permitted."

I am running these as user "root".

The following are my snd devices

root@host:~# ls -l /dev/snd/
total 0
drwxr-xr-x 2 root root       60 Jan  1  1970 by-path
crw-rw---- 1 root audio 116,  0 Jan  1  1970 controlC0
crw-rw---- 1 root audio 116, 24 Jan  1  1970 pcmC0D0c
crw-rw---- 1 root audio 116, 16 Jan  1  1970 pcmC0D0p
crw-rw---- 1 root audio 116, 33 Jan  1  1970 timer
root@host:~#

There is nothing present in my /etc/asound.conf
The following are few parameters in /usr/share/alsa/alsa.conf

defaults.ctl.card 0
defaults.pcm.card 0
defaults.pcm.device 0
defaults.pcm.subdevice -1
defaults.pcm.nonblock 1
defaults.pcm.compat 0
defaults.pcm.minperiodtime 5000         # in us
defaults.pcm.ipc_key 5678293
defaults.pcm.ipc_gid audio
defaults.pcm.ipc_perm 0660
...
...


Regards,
B.Sathish Kumar


::DISCLAIMER::
----------------------------------------------------------------------------------------------------------------------------------------------------

The contents of this e-mail and any attachment(s) are confidential and intended for the named recipient(s) only.
E-mail transmission is not guaranteed to be secure or error-free as information could be intercepted, corrupted,
lost, destroyed, arrive late or incomplete, or may contain viruses in transmission. The e mail and its contents
(with or without referred errors) shall therefore not attach any liability on the originator or HCL or its affiliates.
Views or opinions, if any, presented in this email are solely those of the author and may not necessarily reflect the
views or opinions of HCL or its affiliates. Any form of reproduction, dissemination, copying, disclosure, modification,
distribution and / or publication of this message without the prior written consent of authorized representative of
HCL is strictly prohibited. If you have received this email in error please delete it and notify the sender immediately.
Before opening any email and/or attachments, please check them for viruses and other defects.

----------------------------------------------------------------------------------------------------------------------------------------------------
