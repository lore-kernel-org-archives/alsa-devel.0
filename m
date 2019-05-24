From: Aditya Paluri <Venkata.AdityaPaluri@synopsys.com>
Subject: arecord doesnt record into file
Date: Fri, 24 May 2019 13:54:39 +0000
Message-ID: <83B5A2EBEFF68E46AB106DA39CB25921010ED695@IN01WEMBXA.internal.synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtprelay-out1.synopsys.com (unknown [198.182.47.102])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 951ECF80C0F
 for <alsa-devel@alsa-project.org>; Fri, 24 May 2019 15:54:47 +0200 (CEST)
Received: from mailhost.synopsys.com (badc-mailhost2.synopsys.com
 [10.192.0.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 00AF8C0152
 for <alsa-devel@alsa-project.org>; Fri, 24 May 2019 13:54:52 +0000 (UTC)
Received: from US01WEHTC3.internal.synopsys.com
 (us01wehtc3.internal.synopsys.com [10.15.84.232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by mailhost.synopsys.com (Postfix) with ESMTPS id 998C5A0076
 for <alsa-devel@alsa-project.org>; Fri, 24 May 2019 13:54:43 +0000 (UTC)
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hello all,

I use the below command:

arecord --device plughw:0,2 -r 48000 -f S16_LE -c 2 recorded_sound.wav

And as I see the audio stream getting dumped onto the DRAM/memory, I donot see recorded_sound.wav contain any data on the file system.
I have tried to use strace and I could only see "write" system call happen on the file only for writing the wav format header.

ioctl(4, _IOC(_IOC_READ|_IOC_WRITE, 0x41, 0x23, 0x88), 0x1ec27190) = 0
newfstatat(AT_FDCWD, "/home/root/recorded_wave.wav", 0x7fe8bfeb50, AT_SYMLINK_NOFOLLOW) = -1 ENOENT (No such file or directory)
openat(AT_FDCWD, "/home/root/recorded_wave.wav", O_WRONLY|O_CREAT, 0644) = 3
write(3, "RIFF$\0\0\200WAVE", 12)       = 12
write(3, "fmt \20\0\0\0", 8)            = 8
write(3, "\1\0\2\0\200\273\0\0\0\356\2\0\4\0\20\0", 16) = 16
write(3, "data\0\0\0\200", 8)           = 8
ioctl(4, _IOC(_IOC_READ|_IOC_WRITE, 0x41, 0x23, 0x88), 0x1ec27190) = 0
ioctl(4, _IOC(_IOC_READ, 0x41, 0x51, 0x18)[   24.145583] [   24.587069]  [0


I also see EPIPE error due to overrun.

, 0x7fe8bfeaa8) = -1 EPIPE (Broken pipe)
ioctl(4, _IOC(_IOC_READ|_IOC_WRITE, 0x41, 0x24, 0x98), 0x7fe8bfe9b0) = 0
write(2, "overrun!!! (at least 0.717 ms lo"..., 36overrun!!! (at least 0.717 ms long)
) = 36

Could you please help me in understanding why the recorded_sound.wav doesn't contain any data ?

BR\Thanks.
Aditya Paluri.
