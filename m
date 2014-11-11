From: Bogdan Veringioiu <bogdan.veringioiu@amano.eu>
Subject: Problems with usb soundcard in kernels > 3.3
Date: Tue, 11 Nov 2014 12:14:55 +0100
Message-ID: <5461EFAF.7040205@amano.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx.amano.be (84-199-99-210.ifiber.telenet-ops.be
 [84.199.99.210])
 by alsa0.perex.cz (Postfix) with ESMTP id 92F6C264F37
 for <alsa-devel@alsa-project.org>; Tue, 11 Nov 2014 12:14:57 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by axsguard.amano.be (Postfix) with ESMTP id C19112040FD
 for <alsa-devel@alsa-project.org>; Tue, 11 Nov 2014 12:14:56 +0100 (CET)
Received: from [10.130.0.110] (unknown [194.8.202.222])
 by axsguard.amano.be (Postfix) with ESMTPA id 7888A2040F7
 for <alsa-devel@alsa-project.org>; Tue, 11 Nov 2014 12:14:56 +0100 (CET)
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

Hello all,

After spending a couple of days searching the web for a solution, I 
write here to ask for help.
I am using an usb soundcard (Phoenix Audio Technologies Phnx MT201solo) 
on Debian Wheezy, and started to experience problems when using kernels 
 > 3.3.
The issue I am experiencing is a ~4 seconds delay in playing sound. I am 
reproducing the problem using aplay. The sound play is being delayed by 
more or less 4 seconds from the moment the file is sent to the card. I 
have tested with kernels 3.2 and 3.3, which work properly. I have 
noticed this delay/wait when using kernels 3.15, 3.16. Below are some 
details:

WORKING PROPERLY
# uname -rv
3.2.0-4-686-pae #1 SMP Debian 3.2.63-2
# dpkg -l | grep alsa
ii  alsa-base                            1.0.25+3~deb7u1 
all          ALSA driver configuration files
ii  alsa-utils                           1.0.25-4 
i386         Utilities for configuring and using ALSA
# dmesg
....
usb 3-1: New USB device found, idVendor=1de7, idProduct=0011
usb 3-1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
usb 3-1: Product: Phnx MT201solo
usb 3-1: Manufacturer: Phoenix Audio Technologies
....

# time aplay /usr/share/sounds/alsa/Rear_Left.wav
Playing WAVE '/usr/share/sounds/alsa/Rear_Left.wav' : Signed 16 bit 
Little Endian, Rate 48000 Hz, Mono

real	0m2.498s <--- this is OK
user	0m0.032s
sys	0m0.024s

DELAY INTRODUCED
# uname -rv
3.16-0.bpo.2-686-pae #1 SMP Debian 3.16.3-2~bpo70+1 (2014-09-21)
# dpkg -l | grep alsa
ii  alsa-base                          1.0.25+3~deb7u1               all 
          ALSA driver configuration files
ii  alsa-utils                         1.0.25-4 
i386         Utilities for configuring and using ALSA
# dmesg
....
usb 2-1: New USB device found, idVendor=1de7, idProduct=0011
usb 2-1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
usb 2-1: Product: Phnx MT201solo
usb 2-1: Manufacturer: Phoenix Audio Technologies
....
# time aplay /usr/share/sounds/alsa/Rear_Left.wav
Playing WAVE '/usr/share/sounds/alsa/Rear_Left.wav' : Signed 16 bit 
Little Endian, Rate 48000 Hz, Mono

real	0m6.387s <----4 more seconds delay, NOK
user	0m0.016s
sys	0m0.024s

I have done a strace, see below where the 4 seconds are lost, maybe it 
helps:

open("/dev/snd/pcmC0D0p", O_RDWR|O_NONBLOCK|O_CLOEXEC) = 4
fcntl64(4, F_SETFD, FD_CLOEXEC)         = 0
ioctl(4, AGPIOC_ACQUIRE or APM_IOC_STANDBY, 0xbf823f4c) = 0
close(3)                                = 0
ioctl(4, AGPIOC_ACQUIRE or APM_IOC_STANDBY, 0xbf823dac) = 0
fcntl64(4, F_GETFL)                     = 0x802 (flags O_RDWR|O_NONBLOCK)
ioctl(4, AGPIOC_INFO, 0xbf823d14)       = 0
clock_gettime(CLOCK_MONOTONIC, {5839, 700325532}) = 0
ioctl(4, AGPIOC_SETUP, 0xbf823d1c)      = 0
mmap2(NULL, 4096, PROT_READ, MAP_SHARED, 4, 0x80000) = 0xb72db000
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_SHARED, 4, 0x81000) = 0xb72da000
ioctl(4, 0xc25c4110, 0xbf823ee0)        = 0
ioctl(4, 0xc25c4110, 0xbf823ee0)        = 0
ioctl(4, 0xc25c4110, 0xbf823ee0)        = 0
ioctl(4, 0xc25c4110, 0xbf823ee0)        = 0
ioctl(4, 0xc25c4110, 0xbf823ee0)        = 0
ioctl(4, 0xc25c4110, 0xbf823ee0)        = 0
ioctl(4, 0xc25c4110, 0xbf823ee0)        = 0
ioctl(4, 0xc25c4110, 0xbf823ee0)        = 0
ioctl(4, 0xc25c4111, 0xbf823ee0)        = 0
ioctl(4, 0xc0684113, 0xbf823d94)        = 0
ioctl(4, 0x80104132, 0xbf823cd0)        = 0
ioctl(4, 0x80104132, 0xbf823cd0)        = 0
mmap2(NULL, 65536, PROT_READ|PROT_WRITE, MAP_SHARED, 4, 0) = 0xb7293000
----> ioctl(4, 0x4140, 0xb7718ff4)            = 0 <---- !!! Here is 
where the 4 seconds are lost !!!
ioctl(4, 0xc0684113, 0xbf823e60)        = 0
ioctl(4, 0x4142, 0xb7709c16)            = 0
ioctl(4, AGPIOC_INFO, 0xbf8241a0)       = 0
shmget(0x56a4d6, 131072, IPC_CREAT|0660) = 163841
shmctl(163841, IPC_64|IPC_STAT, 0xbf82415c) = 0
shmctl(163841, IPC_64|IPC_SET, 0xbf82415c) = 0
....

I think this is a problem in the snd-usb-audio module introduced in 
kernels > 3.3.
Can anyone help me with this issue?

Thanks,
Bogdan
