From: "Paul Kavan" <pkavan@gmail.com>
Subject: Re: at91 SoC Modifications
Date: Thu, 21 Jun 2007 15:32:24 -0500
Message-ID: <61c0054e0706211332k56d3b326y524189a498a613b0@mail.gmail.com>
References: <61c0054e0706201421x3725f809g80822d32d78d216e@mail.gmail.com>
	<61c0054e0706210747gc83f1dx2a6ee8bc5cf346f9@mail.gmail.com>
	<61c0054e0706211210s40158268oea170946cf62a9f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_154367_19235117.1182457944863"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.173])
	by alsa0.perex.cz (Postfix) with ESMTP id 1A9CA10380C
	for <alsa-devel@alsa-project.org>;
	Thu, 21 Jun 2007 22:32:26 +0200 (CEST)
Received: by ug-out-1314.google.com with SMTP id s2so647239uge
	for <alsa-devel@alsa-project.org>; Thu, 21 Jun 2007 13:32:25 -0700 (PDT)
In-Reply-To: <61c0054e0706211210s40158268oea170946cf62a9f@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Frank Mandarino <fmandarino@endrelia.com>, Liam Girdwood <lg@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

------=_Part_154367_19235117.1182457944863
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I have searched through at91-ssc.c and I cannot figure out why the record
makes the pcm behave as it does. I am using PCM A, which configures the SSC
as:

    case SND_SOC_DAIFMT_DSP_A | SND_SOC_DAIFMT_CBS_CFS:
        /*
         * DSP/PCM Mode A format, SSC provides BCLK and LRC clocks.
         *
         * The SSC transmit and receive clocks are generated from the
         * MCK divider, and the BCLK signal is output on the SSC TK line.
         */
        rcmr =      (( ssc_p->rcmr_period        << 24) & AT91_SSC_PERIOD)
            | (( 1                << 16) & AT91_SSC_STTDLY)
            | (( AT91_SSC_START_RISING_RF         ) & AT91_SSC_START)
            | (( AT91_SSC_CK_RISING             ) & AT91_SSC_CKI)
            | (( AT91_SSC_CKO_NONE             ) & AT91_SSC_CKO)
            | (( AT91_SSC_CKS_DIV             ) & AT91_SSC_CKS);

        rfmr =      (( AT91_SSC_FSEDGE_POSITIVE         ) & AT91_SSC_FSEDGE)
            | (( AT91_SSC_FSOS_POSITIVE         ) & AT91_SSC_FSOS)
            | (( 0                << 16) & AT91_SSC_FSLEN)
            | (((channels - 1)        <<  8) & AT91_SSC_DATNB)
            | (( 1                <<  7) & AT91_SSC_MSBF)
            | (( 0                <<  5) & AT91_SSC_LOOP)
            | (((bits - 1)            <<  0) & AT91_SSC_DATALEN);

        tcmr =      (( ssc_p->tcmr_period        << 24) & AT91_SSC_PERIOD)
            | (( 1                << 16) & AT91_SSC_STTDLY)
            | (( AT91_SSC_START_RISING_RF        ) & AT91_SSC_START)
            | (( AT91_SSC_CK_RISING             ) & AT91_SSC_CKI)
            | (( AT91_SSC_CKO_CONTINUOUS         ) & AT91_SSC_CKO)
            | (( AT91_SSC_CKS_DIV             ) & AT91_SSC_CKS);

        tfmr =      (( AT91_SSC_FSEDGE_POSITIVE         ) & AT91_SSC_FSEDGE)
            | (( 0                << 23) & AT91_SSC_FSDEN)
            | (( AT91_SSC_FSOS_POSITIVE         ) & AT91_SSC_FSOS)
            | (( 0                << 16) & AT91_SSC_FSLEN)
            | (((channels - 1)        <<  8) & AT91_SSC_DATNB)
            | (( 1                <<  7) & AT91_SSC_MSBF)
            | (( 0                <<  5) & AT91_SSC_DATDEF)
            | (((bits - 1)            <<  0) & AT91_SSC_DATALEN);



            break;

Which, while it puts my timing a little off, should allow a valid record if
one has TF0 and RF0 connected and TK0 and RK0 connected. Has anyone seen
this behavior before?

Looking at strace of arecord gives me a few lines I wonder about. I will
attach the entire strace dump as a text file. The lines that give me pause
are:

~ $ strace arecord -r8000 -traw -fS8 -d3 test.raw
execve("/usr/bin/arecord", ["arecord", "-r8000", "-traw", "-fS8", "-d3", "
test.raw"], [/* 7 vars */0
.
.
.
.snip.
stat("/usr/share/alsa/alsa.conf", {st_mode=S_IFREG|0644, st_size=8611, ...})
= 0
open("/usr/share/alsa/alsa.conf", O_RDONLY) = 3
ioctl(3, SNDCTL_TMR_TIMEBASE or TCGETS, 0xbea17b04) = -1 ENOTTY
(Inappropriate ioctl for device)
brk(0x1e000)                            = 0x1e000
read(3, "#\n#  ALSA library configuration "..., 4096) = 4096
brk(0x1f000)                            = 0x1f000
brk(0x20000)                            = 0x20000
brk(0x21000)                            = 0x21000
read(3, "r\n\t\t\t\tname defaults.pcm.device\n\t"..., 4096) = 4096
brk(0x22000)                            = 0x22000
brk(0x23000)                            = 0x23000
brk(0x24000)                            = 0x24000
brk(0x25000)                            = 0x25000
read(3, "{\n\t\t\t@func refer\n\t\t\tname default"..., 4096) = 419
read(3, "", 4096)                       = 0
close(3)
.snip.

Not sure if the ioctl error on my alsa.conf is a big deal or not.


.snip.
access("/etc/asound.conf", R_OK)        = -1 ENOENT (No such file or
directory)
access("~/.asoundrc", R_OK)             = -1 ENOENT (No such file or
directory)
.snip.

I thought I had read these files were not necessary for ALSA to work. Do I
need one?


.snip.
open("/usr/share/alsa/cards/aliases.conf", O_RDONLY) = 3
ioctl(3, SNDCTL_TMR_TIMEBASE or TCGETS, 0xbea17a34) = -1 ENOTTY
(Inappropriate ioctl for device)
brk(0x26000)                            = 0x26000
read(3, "#\n#  Define aliases for various "..., 4096) = 1273
open("/usr/share/alsa/pcm/default.conf", O_RDONLY) = 4
ioctl(4, SNDCTL_TMR_TIMEBASE or TCGETS, 0xbea1799c) = -1 ENOTTY
(Inappropriate ioctl for device)
brk(0x27000)                            = 0x27000
read(4, "#\n# Default output\n#\n\npcm.!defau"..., 4096) = 762
brk(0x28000)                            = 0x28000
read(4, "", 4096)                       = 0
close(4)                                = 0
open("/usr/share/alsa/pcm/dmix.conf", O_RDONLY) = 4
ioctl(4, SNDCTL_TMR_TIMEBASE or TCGETS, 0xbea1799c) = -1 ENOTTY
(Inappropriate ioctl for device)
brk(0x29000)                            = 0x29000
read(4, "#\n# dmix output\n#\n\npcm.!dmix {\n\t"..., 4096) = 1521
read(4, "", 4096)                       = 0
close(4)                                = 0
open("/usr/share/alsa/pcm/dsnoop.conf", O_RDONLY) = 4
ioctl(4, SNDCTL_TMR_TIMEBASE or TCGETS, 0xbea1799c) = -1 ENOTTY
(Inappropriate ioctl for device)
brk(0x2a000)                            = 0x2a000
read(4, "#\n# dsnoop\n#\n\npcm.!dsnoop {\n\t@ar"..., 4096) = 1533
brk(0x2b000)                            = 0x2b000
read(4, "", 4096)                       = 0
close(4)                                = 0
read(3, "", 4096)                       = 0
close(3)
.snip.

A lot of ioctl error messages. Again, not sure if they are a concern.


.snip.
open("/dev/snd/controlC1", O_RDONLY)    = -1 ENOENT (No such file or
directory)
open("/dev/aloadC1", O_RDONLY)          = -1 ENOENT (No such file or
directory)
open("/dev/snd/controlC2", O_RDONLY)    = -1 ENOENT (No such file or
directory)
open("/dev/aloadC2", O_RDONLY)          = -1 ENOENT (No such file or
directory)
open("/dev/snd/controlC3", O_RDONLY)    = -1 ENOENT (No such file or
directory)
open("/dev/aloadC3", O_RDONLY)          = -1 ENOENT (No such file or
directory)
open("/dev/snd/controlC4", O_RDONLY)    = -1 ENOENT (No such file or
directory)
open("/dev/aloadC4", O_RDONLY)          = -1 ENOENT (No such file or
directory)
open("/dev/snd/controlC5", O_RDONLY)    = -1 ENOENT (No such file or
directory)
open("/dev/aloadC5", O_RDONLY)          = -1 ENOENT (No such file or
directory)
open("/dev/snd/controlC6", O_RDONLY)    = -1 ENOENT (No such file or
directory)
open("/dev/aloadC6", O_RDONLY)          = -1 ENOENT (No such file or
directory)
open("/dev/snd/controlC7", O_RDONLY)    = -1 ENOENT (No such file or
directory)
open("/dev/aloadC7", O_RDONLY)          = -1 ENOENT (No such file or
directory)
open("/dev/snd/controlC8", O_RDONLY)    = -1 ENOENT (No such file or
directory)
open("/dev/aloadC8", O_RDONLY)          = -1 ENOENT (No such file or
directory)
open("/dev/snd/controlC9", O_RDONLY)    = -1 ENOENT (No such file or
directory)
open("/dev/aloadC9", O_RDONLY)          = -1 ENOENT (No such file or
directory)
open("/dev/snd/controlC10", O_RDONLY)   = -1 ENOENT (No such file or
directory)
open("/dev/aloadC10", O_RDONLY)         = -1 ENOENT (No such file or
directory)
open("/dev/snd/controlC11", O_RDONLY)   = -1 ENOENT (No such file or
directory)
open("/dev/aloadC11", O_RDONLY)         = -1 ENOENT (No such file or
directory)
open("/dev/snd/controlC12", O_RDONLY)   = -1 ENOENT (No such file or
directory)
open("/dev/aloadC12", O_RDONLY)         = -1 ENOENT (No such file or
directory)
open("/dev/snd/controlC13", O_RDONLY)   = -1 ENOENT (No such file or
directory)
open("/dev/aloadC13", O_RDONLY)         = -1 ENOENT (No such file or
directory)
open("/dev/snd/controlC14", O_RDONLY)   = -1 ENOENT (No such file or
directory)
open("/dev/aloadC14", O_RDONLY)         = -1 ENOENT (No such file or
directory)
open("/dev/snd/controlC15", O_RDONLY)   = -1 ENOENT (No such file or
directory)
open("/dev/aloadC15", O_RDONLY)         = -1 ENOENT (No such file or
directory)
open("/dev/snd/controlC16", O_RDONLY)   = -1 ENOENT (No such file or
directory)
open("/dev/aloadC16", O_RDONLY)         = -1 ENOENT (No such file or
directory)
open("/dev/snd/controlC17", O_RDONLY)   = -1 ENOENT (No such file or
directory)
open("/dev/aloadC17", O_RDONLY)         = -1 ENOENT (No such file or
directory)
open("/dev/snd/controlC18", O_RDONLY)   = -1 ENOENT (No such file or
directory)
open("/dev/aloadC18", O_RDONLY)         = -1 ENOENT (No such file or
directory)
open("/dev/snd/controlC19", O_RDONLY)   = -1 ENOENT (No such file or
directory)
open("/dev/aloadC19", O_RDONLY)         = -1 ENOENT (No such file or
directory)
open("/dev/snd/controlC20", O_RDONLY)   = -1 ENOENT (No such file or
directory)
open("/dev/aloadC20", O_RDONLY)         = -1 ENOENT (No such file or
directory)
open("/dev/snd/controlC21", O_RDONLY)   = -1 ENOENT (No such file or
directory)
open("/dev/aloadC21", O_RDONLY)         = -1 ENOENT (No such file or
directory)
open("/dev/snd/controlC22", O_RDONLY)   = -1 ENOENT (No such file or
directory)
open("/dev/aloadC22", O_RDONLY)         = -1 ENOENT (No such file or
directory)
open("/dev/snd/controlC23", O_RDONLY)   = -1 ENOENT (No such file or
directory)
open("/dev/aloadC23", O_RDONLY)         = -1 ENOENT (No such file or
directory)
open("/dev/snd/controlC24", O_RDONLY)   = -1 ENOENT (No such file or
directory)
open("/dev/aloadC24", O_RDONLY)         = -1 ENOENT (No such file or
directory)
open("/dev/snd/controlC25", O_RDONLY)   = -1 ENOENT (No such file or
directory)
open("/dev/aloadC25", O_RDONLY)         = -1 ENOENT (No such file or
directory)
open("/dev/snd/controlC26", O_RDONLY)   = -1 ENOENT (No such file or
directory)
open("/dev/aloadC26", O_RDONLY)         = -1 ENOENT (No such file or
directory)
open("/dev/snd/controlC27", O_RDONLY)   = -1 ENOENT (No such file or
directory)
open("/dev/aloadC27", O_RDONLY)         = -1 ENOENT (No such file or
directory)
open("/dev/snd/controlC28", O_RDONLY)   = -1 ENOENT (No such file or
directory)
open("/dev/aloadC28", O_RDONLY)         = -1 ENOENT (No such file or
directory)
open("/dev/snd/controlC29", O_RDONLY)   = -1 ENOENT (No such file or
directory)
open("/dev/aloadC29", O_RDONLY)         = -1 ENOENT (No such file or
directory)
open("/dev/snd/controlC30", O_RDONLY)   = -1 ENOENT (No such file or
directory)
open("/dev/aloadC30", O_RDONLY)         = -1 ENOENT (No such file or
directory)
open("/dev/snd/controlC31", O_RDONLY)   = -1 ENOENT (No such file or
directory)
open("/dev/aloadC31", O_RDONLY)         = -1 ENOENT (No such file or
directory)
.snip.

Not sure why it is trying to open a bunch of interfaces I do not have.


.snip.
open("/dev/snd/controlC0", O_RDONLY)    = 3
close(3)                                = 0
open("/dev/snd/controlC0", O_RDWR)      = 3
ioctl(3, USBDEVFS_CONTROL, 0xbecba7d8)  = 0
ioctl(3, 0x40045532, 0xbecba7e4)        = 0
open("/dev/snd/pcmC0D0c", O_RDWR|O_NONBLOCK) = 4
close(3)                                = 0
ioctl(4, AGPIOC_ACQUIRE or APM_IOC_STANDBY, 0xbecba628) = 0
fcntl(4, F_GETFL)                       = 0x802 (flags O_RDWR|O_NONBLOCK)
ioctl(4, AGPIOC_INFO, 0xbecba7d4)       = 0
ioctl(4, AGPIOC_RELEASE or APM_IOC_SUSPEND, 0xbecba7cc) = 0
mmap2(NULL, 4096, PROT_READ, MAP_SHARED, 4, 0xfff80000) = -1 ENXIO (No such
device or address)
ioctl(4, 0xc0844123, 0xbecba748)        = 0
fcntl(4, F_GETFL)                       = 0x802 (flags O_RDWR|O_NONBLOCK)
fcntl(4, F_SETFL, O_RDWR)               = 0
ioctl(4, AGPIOC_ACQUIRE or APM_IOC_STANDBY, 0xbecbacbc) = 0
rt_sigaction(SIGINT, {0x11530, [INT], SA_RESTART|0x4000000}, {SIG_DFL}, 8) =
0
rt_sigaction(SIGTERM, {0x11530, [TERM], SA_RESTART|0x4000000}, {SIG_DFL}, 8)
= 0
rt_sigaction(SIGABRT, {0x11530, [ABRT], SA_RESTART|0x4000000}, {SIG_DFL}, 8)
= 0
write(2, "Recording", 9Recording)                = 9
write(2, " ", 1 )                        = 1
write(2, "raw data", 8raw data)                 = 8
write(2, " \'", 2 ')                      = 2
write(2, "test.raw", 8test.raw)                 = 8
write(2, "\' : ", 4' : )                    = 4
write(2, "Signed 8 bit", 12Signed 8 bit)            = 12
write(2, ", ", 2, )                       = 2
write(2, "Rate ", 5Rate )                    = 5
write(2, "8000", 48000)                     = 4
write(2, " Hz, ", 5 Hz, )                    = 5
write(2, "Mono", 4Mono)                     = 4
write(2, "\n", 1
)                       = 1
ioctl(4, 0xc25c4110, 0xbecb8674)        = 0
ioctl(4, 0xc25c4110, 0xbecb8674)        = 0
ioctl(4, 0xc25c4110, 0xbecb8674)        = 0
ioctl(4, 0xc25c4110, 0xbecb83e8)        = 0
ioctl(4, 0xc25c4110, 0xbecb83e8)        = 0
ioctl(4, 0xc25c4110, 0xbecb83e8)        = 0
ioctl(4, 0xc25c4110, 0xbecb83e8)        = 0
ioctl(4, 0xc25c4110, 0xbecb83e8)        = 0
ioctl(4, 0xc25c4110, 0xbecb83e8)        = 0
ioctl(4, 0xc25c4110, 0xbecb83e8)        = 0
ioctl(4, 0xc25c4110, 0xbecb83e8)        = 0
ioctl(4, 0xc25c4110, 0xbecb7eec)        = 0
ioctl(4, 0xc25c4110, 0xbecb7eec)        = 0
ioctl(4, 0xc25c4110, 0xbecb7eec)        = 0
ioctl(4, 0xc25c4110, 0xbecb814c)        = 0
ioctl(4, 0xc25c4110, 0xbecb814c)        = 0
ioctl(4, 0xc25c4110, 0xbecb814c)        = 0
ioctl(4, 0xc25c4110, 0xbecb7eec)        = 0
ioctl(4, 0xc25c4110, 0xbecb7eec)        = 0
ioctl(4, 0xc25c4110, 0xbecb7eec)        = 0
ioctl(4, 0xc25c4110, 0xbecb814c)        = 0
ioctl(4, 0xc25c4110, 0xbecb814c)        = 0
ioctl(4, 0xc25c4110, 0xbecb814c)        = 0
ioctl(4, 0xc25c4110, 0xbecb7eec)        = 0
ioctl(4, 0xc25c4110, 0xbecb7eec)        = 0
ioctl(4, 0xc25c4110, 0xbecb7eec)        = 0
ioctl(4, 0xc25c4110, 0xbecb814c)        = 0
ioctl(4, 0xc25c4110, 0xbecb814c)        = 0
ioctl(4, 0xc25c4110, 0xbecb814c)        = 0
ioctl(4, 0xc25c4110, 0xbecb85e4)        = 0
ioctl(4, 0xc25c4110, 0xbecb85e4)        = 0
ioctl(4, 0xc25c4110, 0xbecb85d8)        = 0
ioctl(4, 0xc25c4110, 0xbecb898c)        = 0
ioctl(4, 0xc25c4111, 0xbecb898c)        = 0
ioctl(4, 0xc0844123, 0x24f58)           = 0
ioctl(4, 0xc0684113, 0xbecb8554)        = 0
ioctl(4, 0xc0844123, 0x24f58)           = 0
ioctl(4, 0x4140, 0x400ba1a8)            = 0
ioctl(4, 0xc0844123, 0x24f58)           = 0
ioctl(4, 0xc0844123, 0x24f58)           = 0
rmdir("test.raw")                       = -1 ENOTDIR (Not a directory)
unlink("test.raw")                      = 0
open("test.raw", O_WRONLY|O_CREAT|O_LARGEFILE, 0644) = 3
ioctl(4, 0x800c4151, 0xbecb8c34)        = -1 EIO (Input/output error)
write(2, "arecord", 7arecord)                  = 7
write(2, ": ", 2: )                       = 2
write(2, "pcm_read", 8pcm_read)                 = 8
write(2, ":", 1:)                        = 1
write(2, "1346", 41346)                     = 4
write(2, ": ", 2: )                       = 2
write(2, "read error: ", 12read error: )            = 12
write(2, "Input/output error", 18Input/output error)      = 18
write(2, "\n", 1
)                       = 1
exit(1)                                 = ?
Process 754 detached
.snip.

The final sequence here. Seems that when it tried some kind of ioctl on
pcmC0D0c, it received an error. Perhaps this control signal is what is
causing the HW problems with RF0.

Again, the full strace is attached. Not sure if this helps, I am trying my
best to figure out what is wrong with RF0. I know it works as my polling ssc
driver works just fine with both capture and playback.

If anyone has any clue to what I can try, look at, etc. please feel free to
let me know.


Paul

***************************************
Paul David Kavan
Project Engineer
GRH Electronics, Inc.
402-734-4900
pkavan@gmail.com
***************************************

------=_Part_154367_19235117.1182457944863
Content-Type: text/plain; name=strace_arecord.txt; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_f37ov8g1
Content-Disposition: attachment; filename="strace_arecord.txt"

fiAkIHN0cmFjZSBhcmVjb3JkIC1yODAwMCAtdHJhdyAtZlM4IC1kMyB0ZXN0LnJhdyAKZXhlY3Zl
KCIvdXNyL2Jpbi9hcmVjb3JkIiwgWyJhcmVjb3JkIiwgIi1yODAwMCIsICItdHJhdyIsICItZlM4
IiwgIi1kMyIsICJ0ZXN0LnJhdyJdLCBbLyogNyB2YXJzICovMAptbWFwMihOVUxMLCAyMCwgUFJP
VF9SRUFEfFBST1RfV1JJVEUsIE1BUF9QUklWQVRFfE1BUF9BTk9OWU1PVVMsIC0xLCAwKSA9IDB4
NDAwMDUwMDAKc3RhdCgiL2V0Yy9sZC5zby5jYWNoZSIsIHtzdF9tb2RlPVNfSUZSRUd8MDY0NCwg
c3Rfc2l6ZT0xMTUwLCAuLi59KSA9IDAKb3BlbigiL2V0Yy9sZC5zby5jYWNoZSIsIE9fUkRPTkxZ
KSAgICAgID0gMwptbWFwMihOVUxMLCAxMTUwLCBQUk9UX1JFQUQsIE1BUF9TSEFSRUQsIDMsIDAp
ID0gMHg0MDAwNjAwMApjbG9zZSgzKSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPSAw
Cm9wZW4oIi91c3IvbGliL2xpYmFzb3VuZC5zby4yIiwgT19SRE9OTFkpID0gMwpmc3RhdCgzLCB7
c3RfbW9kZT1TX0lGUkVHfDA3NTUsIHN0X3NpemU9NzYyMDcyLCAuLi59KSA9IDAKbW1hcDIoTlVM
TCwgNDA5NiwgUFJPVF9SRUFEfFBST1RfV1JJVEUsIE1BUF9QUklWQVRFfE1BUF9BTk9OWU1PVVMs
IC0xLCAwKSA9IDB4NDAwMDcwMDAKcmVhZCgzLCAiXDE3N0VMRlwxXDFcMWFcMFwwXDBcMFwwXDBc
MFwwXDNcMChcMFwxXDBcMFwweFwzNjdcMVwwMDAiLi4uLCA0MDk2KSA9IDQwOTYKbW1hcDIoTlVM
TCwgNzk0NjI0LCBQUk9UX05PTkUsIE1BUF9QUklWQVRFfE1BUF9BTk9OWU1PVVMsIC0xLCAwKSA9
IDB4NDAwMGUwMDAKbW1hcDIoMHg0MDAwZTAwMCwgNzQ1NTY0LCBQUk9UX1JFQUR8UFJPVF9FWEVD
LCBNQVBfUFJJVkFURXxNQVBfRklYRUQsIDMsIDApID0gMHg0MDAwZTAwMAptbWFwMigweDQwMGNj
MDAwLCAxNTUwOCwgUFJPVF9SRUFEfFBST1RfV1JJVEUsIE1BUF9QUklWQVRFfE1BUF9GSVhFRCwg
MywgMHhiNikgPSAweDQwMGNjMDAwCmNsb3NlKDMpICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICA9IDAKbXVubWFwKDB4NDAwMDcwMDAsIDQwOTYpICAgICAgICAgICAgICAgID0gMApvcGVu
KCIvbGliL2xpYm0uc28uMCIsIE9fUkRPTkxZKSAgICAgICAgPSAzCmZzdGF0KDMsIHtzdF9tb2Rl
PVNfSUZSRUd8MDY0NCwgc3Rfc2l6ZT00NTgxMiwgLi4ufSkgPSAwCm1tYXAyKE5VTEwsIDQwOTYs
IFBST1RfUkVBRHxQUk9UX1dSSVRFLCBNQVBfUFJJVkFURXxNQVBfQU5PTllNT1VTLCAtMSwgMCkg
PSAweDQwMDA3MDAwCnJlYWQoMywgIlwxNzdFTEZcMVwxXDFhXDBcMFwwXDBcMFwwXDBcMFwzXDAo
XDBcMVwwXDBcMHRcMjJcMFwwMDAiLi4uLCA0MDk2KSA9IDQwOTYKbW1hcDIoTlVMTCwgODE5MjAs
IFBST1RfTk9ORSwgTUFQX1BSSVZBVEV8TUFQX0FOT05ZTU9VUywgLTEsIDApID0gMHg0MDBkMDAw
MAptbWFwMigweDQwMGQwMDAwLCA0MTQyOCwgUFJPVF9SRUFEfFBST1RfRVhFQywgTUFQX1BSSVZB
VEV8TUFQX0ZJWEVELCAzLCAwKSA9IDB4NDAwZDAwMDAKbW1hcDIoMHg0MDBlMjAwMCwgNDEwMCwg
UFJPVF9SRUFEfFBST1RfV1JJVEUsIE1BUF9QUklWQVRFfE1BUF9GSVhFRCwgMywgMHhhKSA9IDB4
NDAwZTIwMDAKY2xvc2UoMykgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgID0gMAptdW5t
YXAoMHg0MDAwNzAwMCwgNDA5NikgICAgICAgICAgICAgICAgPSAwCm9wZW4oIi9saWIvbGliZGwu
c28uMCIsIE9fUkRPTkxZKSAgICAgICA9IDMKZnN0YXQoMywge3N0X21vZGU9U19JRlJFR3wwNjQ0
LCBzdF9zaXplPTg5MDAsIC4uLn0pID0gMAptbWFwMihOVUxMLCA0MDk2LCBQUk9UX1JFQUR8UFJP
VF9XUklURSwgTUFQX1BSSVZBVEV8TUFQX0FOT05ZTU9VUywgLTEsIDApID0gMHg0MDAwNzAwMApy
ZWFkKDMsICJcMTc3RUxGXDFcMVwxYVwwXDBcMFwwXDBcMFwwXDBcM1wwKFwwXDFcMFwwXDAoXDEw
XDBcMDAwIi4uLiwgNDA5NikgPSA0MDk2Cm1tYXAyKE5VTEwsIDQwOTYwLCBQUk9UX05PTkUsIE1B
UF9QUklWQVRFfE1BUF9BTk9OWU1PVVMsIC0xLCAwKSA9IDB4NDAwZTQwMDAKbW1hcDIoMHg0MDBl
NDAwMCwgNTc2MCwgUFJPVF9SRUFEfFBST1RfRVhFQywgTUFQX1BSSVZBVEV8TUFQX0ZJWEVELCAz
LCAwKSA9IDB4NDAwZTQwMDAKbW1hcDIoMHg0MDBlZDAwMCwgNDA5NiwgUFJPVF9SRUFEfFBST1Rf
V1JJVEUsIE1BUF9QUklWQVRFfE1BUF9GSVhFRCwgMywgMHgxKSA9IDB4NDAwZWQwMDAKY2xvc2Uo
MykgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgID0gMAptdW5tYXAoMHg0MDAwNzAwMCwg
NDA5NikgICAgICAgICAgICAgICAgPSAwCm9wZW4oIi9saWIvbGlicHRocmVhZC5zby4wIiwgT19S
RE9OTFkpICA9IDMKZnN0YXQoMywge3N0X21vZGU9U19JRlJFR3wwNjQ0LCBzdF9zaXplPTYzODUy
LCAuLi59KSA9IDAKbW1hcDIoTlVMTCwgNDA5NiwgUFJPVF9SRUFEfFBST1RfV1JJVEUsIE1BUF9Q
UklWQVRFfE1BUF9BTk9OWU1PVVMsIC0xLCAwKSA9IDB4NDAwMDcwMDAKcmVhZCgzLCAiXDE3N0VM
RlwxXDFcMWFcMFwwXDBcMFwwXDBcMFwwXDNcMChcMFwxXDBcMFwwRDxcMFwwMDA0Ii4uLiwgNDA5
NikgPSA0MDk2Cm1tYXAyKE5VTEwsIDEwNjQ5NiwgUFJPVF9OT05FLCBNQVBfUFJJVkFURXxNQVBf
QU5PTllNT1VTLCAtMSwgMCkgPSAweDQwMGVlMDAwCm1tYXAyKDB4NDAwZWUwMDAsIDQwOTUyLCBQ
Uk9UX1JFQUR8UFJPVF9FWEVDLCBNQVBfUFJJVkFURXxNQVBfRklYRUQsIDMsIDApID0gMHg0MDBl
ZTAwMAptbWFwMigweDQwMTAwMDAwLCAyMTczMiwgUFJPVF9SRUFEfFBST1RfV1JJVEUsIE1BUF9Q
UklWQVRFfE1BUF9GSVhFRCwgMywgMHhhKSA9IDB4NDAxMDAwMDAKbW1hcDIoMHg0MDEwNjAwMCwg
NTc4OCwgUFJPVF9SRUFEfFBST1RfV1JJVEUsIE1BUF9QUklWQVRFfE1BUF9GSVhFRHxNQVBfQU5P
TllNT1VTLCAtMSwgMCkgPSAweDQwMTA2MApjbG9zZSgzKSAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgPSAwCm11bm1hcCgweDQwMDA3MDAwLCA0MDk2KSAgICAgICAgICAgICAgICA9IDAK
b3BlbigiL2xpYi9saWJnY2Nfcy5zby4xIiwgT19SRE9OTFkpICAgID0gMwpmc3RhdCgzLCB7c3Rf
bW9kZT1TX0lGUkVHfDA2NDQsIHN0X3NpemU9NDQxNjcsIC4uLn0pID0gMAptbWFwMihOVUxMLCA0
MDk2LCBQUk9UX1JFQUR8UFJPVF9XUklURSwgTUFQX1BSSVZBVEV8TUFQX0FOT05ZTU9VUywgLTEs
IDApID0gMHg0MDAwNzAwMApyZWFkKDMsICJcMTc3RUxGXDFcMVwxYVwwXDBcMFwwXDBcMFwwXDBc
M1wwKFwwXDFcMFwwXDBYXDI1XDBcMDAwIi4uLiwgNDA5NikgPSA0MDk2Cm1tYXAyKE5VTEwsIDY1
NTM2LCBQUk9UX05PTkUsIE1BUF9QUklWQVRFfE1BUF9BTk9OWU1PVVMsIC0xLCAwKSA9IDB4NDAx
MDgwMDAKbW1hcDIoMHg0MDEwODAwMCwgMjg4MDAsIFBST1RfUkVBRHxQUk9UX0VYRUMsIE1BUF9Q
UklWQVRFfE1BUF9GSVhFRCwgMywgMCkgPSAweDQwMTA4MDAwCm1tYXAyKDB4NDAxMTcwMDAsIDU0
OCwgUFJPVF9SRUFEfFBST1RfV1JJVEUsIE1BUF9QUklWQVRFfE1BUF9GSVhFRCwgMywgMHg3KSA9
IDB4NDAxMTcwMDAKY2xvc2UoMykgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgID0gMApt
dW5tYXAoMHg0MDAwNzAwMCwgNDA5NikgICAgICAgICAgICAgICAgPSAwCm9wZW4oIi9saWIvbGli
Yy5zby4wIiwgT19SRE9OTFkpICAgICAgICA9IDMKZnN0YXQoMywge3N0X21vZGU9U19JRlJFR3ww
NjQ0LCBzdF9zaXplPTMwOTg0MCwgLi4ufSkgPSAwCm1tYXAyKE5VTEwsIDQwOTYsIFBST1RfUkVB
RHxQUk9UX1dSSVRFLCBNQVBfUFJJVkFURXxNQVBfQU5PTllNT1VTLCAtMSwgMCkgPSAweDQwMDA3
MDAwCnJlYWQoMywgIlwxNzdFTEZcMVwxXDFhXDBcMFwwXDBcMFwwXDBcMFwzXDAoXDBcMVwwXDBc
MDAwMFwyNTNcMCIuLi4sIDQwOTYpID0gNDA5NgptbWFwMihOVUxMLCAzNjA0NDgsIFBST1RfTk9O
RSwgTUFQX1BSSVZBVEV8TUFQX0FOT05ZTU9VUywgLTEsIDApID0gMHg0MDExODAwMAptbWFwMigw
eDQwMTE4MDAwLCAzMDIzODAsIFBST1RfUkVBRHxQUk9UX0VYRUMsIE1BUF9QUklWQVRFfE1BUF9G
SVhFRCwgMywgMCkgPSAweDQwMTE4MDAwCm1tYXAyKDB4NDAxNmEwMDAsIDUxNzIsIFBST1RfUkVB
RHxQUk9UX1dSSVRFLCBNQVBfUFJJVkFURXxNQVBfRklYRUQsIDMsIDB4NGEpID0gMHg0MDE2YTAw
MAptbWFwMigweDQwMTZjMDAwLCAxNjAyMCwgUFJPVF9SRUFEfFBST1RfV1JJVEUsIE1BUF9QUklW
QVRFfE1BUF9GSVhFRHxNQVBfQU5PTllNT1VTLCAtMSwgMCkgPSAweDQwMTYwCmNsb3NlKDMpICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICA9IDAKbXVubWFwKDB4NDAwMDcwMDAsIDQwOTYp
ICAgICAgICAgICAgICAgID0gMApvcGVuKCIvbGliL2xpYm0uc28uMCIsIE9fUkRPTkxZKSAgICAg
ICAgPSAzCmZzdGF0KDMsIHtzdF9tb2RlPVNfSUZSRUd8MDY0NCwgc3Rfc2l6ZT00NTgxMiwgLi4u
fSkgPSAwCmNsb3NlKDMpICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA9IDAKb3Blbigi
L2xpYi9saWJkbC5zby4wIiwgT19SRE9OTFkpICAgICAgID0gMwpmc3RhdCgzLCB7c3RfbW9kZT1T
X0lGUkVHfDA2NDQsIHN0X3NpemU9ODkwMCwgLi4ufSkgPSAwCmNsb3NlKDMpICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICA9IDAKb3BlbigiL2xpYi9saWJwdGhyZWFkLnNvLjAiLCBPX1JE
T05MWSkgID0gMwpmc3RhdCgzLCB7c3RfbW9kZT1TX0lGUkVHfDA2NDQsIHN0X3NpemU9NjM4NTIs
IC4uLn0pID0gMApjbG9zZSgzKSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPSAwCm9w
ZW4oIi9saWIvbGliZ2NjX3Muc28uMSIsIE9fUkRPTkxZKSAgICA9IDMKZnN0YXQoMywge3N0X21v
ZGU9U19JRlJFR3wwNjQ0LCBzdF9zaXplPTQ0MTY3LCAuLi59KSA9IDAKY2xvc2UoMykgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgID0gMApvcGVuKCIvbGliL2xpYmMuc28uMCIsIE9fUkRP
TkxZKSAgICAgICAgPSAzCmZzdGF0KDMsIHtzdF9tb2RlPVNfSUZSRUd8MDY0NCwgc3Rfc2l6ZT0z
MDk4NDAsIC4uLn0pID0gMApjbG9zZSgzKSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
PSAwCm9wZW4oIi9saWIvbGliYy5zby4wIiwgT19SRE9OTFkpICAgICAgICA9IDMKZnN0YXQoMywg
e3N0X21vZGU9U19JRlJFR3wwNjQ0LCBzdF9zaXplPTMwOTg0MCwgLi4ufSkgPSAwCmNsb3NlKDMp
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA9IDAKb3BlbigiL2xpYi9saWJjLnNvLjAi
LCBPX1JET05MWSkgICAgICAgID0gMwpmc3RhdCgzLCB7c3RfbW9kZT1TX0lGUkVHfDA2NDQsIHN0
X3NpemU9MzA5ODQwLCAuLi59KSA9IDAKY2xvc2UoMykgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgID0gMApvcGVuKCIvbGliL2xpYmMuc28uMCIsIE9fUkRPTkxZKSAgICAgICAgPSAzCmZz
dGF0KDMsIHtzdF9tb2RlPVNfSUZSRUd8MDY0NCwgc3Rfc2l6ZT0zMDk4NDAsIC4uLn0pID0gMApj
bG9zZSgzKSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPSAwCm9wZW4oIi9saWIvbGli
Yy5zby4wIiwgT19SRE9OTFkpICAgICAgICA9IDMKZnN0YXQoMywge3N0X21vZGU9U19JRlJFR3ww
NjQ0LCBzdF9zaXplPTMwOTg0MCwgLi4ufSkgPSAwCmNsb3NlKDMpICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICA9IDAKbXVubWFwKDB4NDAwMDYwMDAsIDExNTApICAgICAgICAgICAgICAg
ID0gMApzdGF0KCIvbGliL2xkLXVDbGliYy5zby4wIiwge3N0X21vZGU9U19JRlJFR3wwNzU1LCBz
dF9zaXplPTIxMDk2LCAuLi59KSA9IDAKbXByb3RlY3QoMHg0MDBlMjAwMCwgNDA5NiwgUFJPVF9S
RUFEKSAgID0gMAptcHJvdGVjdCgweDQwMGVkMDAwLCA0MDk2LCBQUk9UX1JFQUQpICAgPSAwCm1w
cm90ZWN0KDB4NDAxMDAwMDAsIDQwOTYsIFBST1RfUkVBRCkgICA9IDAKbXByb3RlY3QoMHg0MDE2
YTAwMCwgNDA5NiwgUFJPVF9SRUFEKSAgID0gMAptcHJvdGVjdCgweDQwMDBjMDAwLCA0MDk2LCBQ
Uk9UX1JFQUQpICAgPSAwCmlvY3RsKDAsIFNORENUTF9UTVJfVElNRUJBU0Ugb3IgVENHRVRTLCB7
QjExNTIwMCBvcG9zdCBpc2lnIGljYW5vbiBlY2hvIC4uLn0pID0gMAppb2N0bCgxLCBTTkRDVExf
VE1SX1RJTUVCQVNFIG9yIFRDR0VUUywge0IxMTUyMDAgb3Bvc3QgaXNpZyBpY2Fub24gZWNobyAu
Li59KSA9IDAKZ2V0cGlkKCkgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgID0gNzU0Cmdl
dHJsaW1pdChSTElNSVRfU1RBQ0ssIHtybGltX2N1cj04MTkyKjEwMjQsIHJsaW1fbWF4PVJMSU1f
SU5GSU5JVFl9KSA9IDAKc2V0cmxpbWl0KFJMSU1JVF9TVEFDSywge3JsaW1fY3VyPTIwNDAqMTAy
NCwgcmxpbV9tYXg9UkxJTV9JTkZJTklUWX0pID0gMApydF9zaWdhY3Rpb24oU0lHUlRNSU4sIHsw
eDQwMGY3ZDcwLCBbXSwgMHg0MDAwMDAwIC8qIFNBXz8/PyAqL30sIE5VTEwsIDgpID0gMApydF9z
aWdhY3Rpb24oU0lHUlRfMSwgezB4NDAwZjdjOTgsIFtSVE1JTl0sIDB4NDAwMDAwMCAvKiBTQV8/
Pz8gKi99LCBOVUxMLCA4KSA9IDAKcnRfc2lnYWN0aW9uKFNJR1JUXzIsIHsweDQwMGY3MmQwLCBb
XSwgMHg0MDAwMDAwIC8qIFNBXz8/PyAqL30sIE5VTEwsIDgpID0gMApydF9zaWdwcm9jbWFzayhT
SUdfQkxPQ0ssIFtSVE1JTl0sIE5VTEwsIDgpID0gMApydF9zaWdwcm9jbWFzayhTSUdfVU5CTE9D
SywgW1JUXzFdLCBOVUxMLCA4KSA9IDAKYnJrKDApICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgID0gMHgxYzAwMApicmsoMHgxZDAwMCkgICAgICAgICAgICAgICAgICAgICAgICAgICAg
PSAweDFkMDAwCnN0YXQoIi91c3Ivc2hhcmUvYWxzYS9hbHNhLmNvbmYiLCB7c3RfbW9kZT1TX0lG
UkVHfDA2NDQsIHN0X3NpemU9ODYxMSwgLi4ufSkgPSAwCm9wZW4oIi91c3Ivc2hhcmUvYWxzYS9h
bHNhLmNvbmYiLCBPX1JET05MWSkgPSAzCmlvY3RsKDMsIFNORENUTF9UTVJfVElNRUJBU0Ugb3Ig
VENHRVRTLCAweGJlY2JhYjA0KSA9IC0xIEVOT1RUWSAoSW5hcHByb3ByaWF0ZSBpb2N0bCBmb3Ig
ZGV2aWNlKQpicmsoMHgxZTAwMCkgICAgICAgICAgICAgICAgICAgICAgICAgICAgPSAweDFlMDAw
CnJlYWQoMywgIiNcbiMgIEFMU0EgbGlicmFyeSBjb25maWd1cmF0aW9uICIuLi4sIDQwOTYpID0g
NDA5NgpicmsoMHgxZjAwMCkgICAgICAgICAgICAgICAgICAgICAgICAgICAgPSAweDFmMDAwCmJy
aygweDIwMDAwKSAgICAgICAgICAgICAgICAgICAgICAgICAgICA9IDB4MjAwMDAKYnJrKDB4MjEw
MDApICAgICAgICAgICAgICAgICAgICAgICAgICAgID0gMHgyMTAwMApyZWFkKDMsICJyXG5cdFx0
XHRcdG5hbWUgZGVmYXVsdHMucGNtLmRldmljZVxuXHQiLi4uLCA0MDk2KSA9IDQwOTYKYnJrKDB4
MjIwMDApICAgICAgICAgICAgICAgICAgICAgICAgICAgID0gMHgyMjAwMApicmsoMHgyMzAwMCkg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgPSAweDIzMDAwCmJyaygweDI0MDAwKSAgICAgICAg
ICAgICAgICAgICAgICAgICAgICA9IDB4MjQwMDAKYnJrKDB4MjUwMDApICAgICAgICAgICAgICAg
ICAgICAgICAgICAgID0gMHgyNTAwMApyZWFkKDMsICJ7XG5cdFx0XHRAZnVuYyByZWZlclxuXHRc
dFx0bmFtZSBkZWZhdWx0Ii4uLiwgNDA5NikgPSA0MTkKcmVhZCgzLCAiIiwgNDA5NikgICAgICAg
ICAgICAgICAgICAgICAgID0gMApjbG9zZSgzKSAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgPSAwCnN0YXQoIi9ldGMvbGQuc28uY2FjaGUiLCB7c3RfbW9kZT1TX0lGUkVHfDA2NDQsIHN0
X3NpemU9MTE1MCwgLi4ufSkgPSAwCm9wZW4oIi9ldGMvbGQuc28uY2FjaGUiLCBPX1JET05MWSkg
ICAgICA9IDMKbW1hcDIoTlVMTCwgMTE1MCwgUFJPVF9SRUFELCBNQVBfU0hBUkVELCAzLCAwKSA9
IDB4NDAwMDYwMDAKY2xvc2UoMykgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgID0gMApv
cGVuKCIvdXNyL2xpYi9saWJhc291bmQuc28uMiIsIE9fUkRPTkxZKSA9IDMKZnN0YXQoMywge3N0
X21vZGU9U19JRlJFR3wwNzU1LCBzdF9zaXplPTc2MjA3MiwgLi4ufSkgPSAwCmNsb3NlKDMpICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICA9IDAKYWNjZXNzKCIvZXRjL2Fzb3VuZC5jb25m
IiwgUl9PSykgICAgICAgID0gLTEgRU5PRU5UIChObyBzdWNoIGZpbGUgb3IgZGlyZWN0b3J5KQph
Y2Nlc3MoIn4vLmFzb3VuZHJjIiwgUl9PSykgICAgICAgICAgICAgPSAtMSBFTk9FTlQgKE5vIHN1
Y2ggZmlsZSBvciBkaXJlY3RvcnkpCm9wZW4oIi91c3IvbGliL2xpYmFzb3VuZC5zby4yIiwgT19S
RE9OTFkpID0gMwpmc3RhdCgzLCB7c3RfbW9kZT1TX0lGUkVHfDA3NTUsIHN0X3NpemU9NzYyMDcy
LCAuLi59KSA9IDAKY2xvc2UoMykgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgID0gMApv
cGVuKCIvdXNyL2xpYi9saWJhc291bmQuc28uMiIsIE9fUkRPTkxZKSA9IDMKZnN0YXQoMywge3N0
X21vZGU9U19JRlJFR3wwNzU1LCBzdF9zaXplPTc2MjA3MiwgLi4ufSkgPSAwCmNsb3NlKDMpICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICA9IDAKb3BlbigiL3Vzci9saWIvbGliYXNvdW5k
LnNvLjIiLCBPX1JET05MWSkgPSAzCmZzdGF0KDMsIHtzdF9tb2RlPVNfSUZSRUd8MDc1NSwgc3Rf
c2l6ZT03NjIwNzIsIC4uLn0pID0gMApjbG9zZSgzKSAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgPSAwCm9wZW4oIi91c3Ivc2hhcmUvYWxzYS9jYXJkcy9hbGlhc2VzLmNvbmYiLCBPX1JE
T05MWSkgPSAzCmlvY3RsKDMsIFNORENUTF9UTVJfVElNRUJBU0Ugb3IgVENHRVRTLCAweGJlY2Jh
YTM0KSA9IC0xIEVOT1RUWSAoSW5hcHByb3ByaWF0ZSBpb2N0bCBmb3IgZGV2aWNlKQpicmsoMHgy
NjAwMCkgICAgICAgICAgICAgICAgICAgICAgICAgICAgPSAweDI2MDAwCnJlYWQoMywgIiNcbiMg
IERlZmluZSBhbGlhc2VzIGZvciB2YXJpb3VzICIuLi4sIDQwOTYpID0gMTI3MwpvcGVuKCIvdXNy
L3NoYXJlL2Fsc2EvcGNtL2RlZmF1bHQuY29uZiIsIE9fUkRPTkxZKSA9IDQKaW9jdGwoNCwgU05E
Q1RMX1RNUl9USU1FQkFTRSBvciBUQ0dFVFMsIDB4YmVjYmE5OWMpID0gLTEgRU5PVFRZIChJbmFw
cHJvcHJpYXRlIGlvY3RsIGZvciBkZXZpY2UpCmJyaygweDI3MDAwKSAgICAgICAgICAgICAgICAg
ICAgICAgICAgICA9IDB4MjcwMDAKcmVhZCg0LCAiI1xuIyBEZWZhdWx0IG91dHB1dFxuI1xuXG5w
Y20uIWRlZmF1Ii4uLiwgNDA5NikgPSA3NjIKYnJrKDB4MjgwMDApICAgICAgICAgICAgICAgICAg
ICAgICAgICAgID0gMHgyODAwMApyZWFkKDQsICIiLCA0MDk2KSAgICAgICAgICAgICAgICAgICAg
ICAgPSAwCmNsb3NlKDQpICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA9IDAKb3Blbigi
L3Vzci9zaGFyZS9hbHNhL3BjbS9kbWl4LmNvbmYiLCBPX1JET05MWSkgPSA0CmlvY3RsKDQsIFNO
RENUTF9UTVJfVElNRUJBU0Ugb3IgVENHRVRTLCAweGJlY2JhOTljKSA9IC0xIEVOT1RUWSAoSW5h
cHByb3ByaWF0ZSBpb2N0bCBmb3IgZGV2aWNlKQpicmsoMHgyOTAwMCkgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgPSAweDI5MDAwCnJlYWQoNCwgIiNcbiMgZG1peCBvdXRwdXRcbiNcblxucGNt
LiFkbWl4IHtcblx0Ii4uLiwgNDA5NikgPSAxNTIxCnJlYWQoNCwgIiIsIDQwOTYpICAgICAgICAg
ICAgICAgICAgICAgICA9IDAKY2xvc2UoNCkgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ID0gMApvcGVuKCIvdXNyL3NoYXJlL2Fsc2EvcGNtL2Rzbm9vcC5jb25mIiwgT19SRE9OTFkpID0g
NAppb2N0bCg0LCBTTkRDVExfVE1SX1RJTUVCQVNFIG9yIFRDR0VUUywgMHhiZWNiYTk5YykgPSAt
MSBFTk9UVFkgKEluYXBwcm9wcmlhdGUgaW9jdGwgZm9yIGRldmljZSkKYnJrKDB4MmEwMDApICAg
ICAgICAgICAgICAgICAgICAgICAgICAgID0gMHgyYTAwMApyZWFkKDQsICIjXG4jIGRzbm9vcFxu
I1xuXG5wY20uIWRzbm9vcCB7XG5cdEBhciIuLi4sIDQwOTYpID0gMTUzMwpicmsoMHgyYjAwMCkg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgPSAweDJiMDAwCnJlYWQoNCwgIiIsIDQwOTYpICAg
ICAgICAgICAgICAgICAgICAgICA9IDAKY2xvc2UoNCkgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgID0gMApyZWFkKDMsICIiLCA0MDk2KSAgICAgICAgICAgICAgICAgICAgICAgPSAwCmNs
b3NlKDMpICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA9IDAKb3BlbigiL3Vzci9saWIv
bGliYXNvdW5kLnNvLjIiLCBPX1JET05MWSkgPSAzCmZzdGF0KDMsIHtzdF9tb2RlPVNfSUZSRUd8
MDc1NSwgc3Rfc2l6ZT03NjIwNzIsIC4uLn0pID0gMApjbG9zZSgzKSAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgPSAwCm9wZW4oIi9kZXYvc25kL2NvbnRyb2xDMCIsIE9fUkRPTkxZKSAg
ICA9IDMKY2xvc2UoMykgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgID0gMApzdGF0KCIv
dXNyL3NoYXJlL2Fsc2EvYWxzYS5jb25mIiwge3N0X21vZGU9U19JRlJFR3wwNjQ0LCBzdF9zaXpl
PTg2MTEsIC4uLn0pID0gMApvcGVuKCIvdXNyL2xpYi9saWJhc291bmQuc28uMiIsIE9fUkRPTkxZ
KSA9IDMKZnN0YXQoMywge3N0X21vZGU9U19JRlJFR3wwNzU1LCBzdF9zaXplPTc2MjA3MiwgLi4u
fSkgPSAwCmNsb3NlKDMpICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA9IDAKb3Blbigi
L2Rldi9zbmQvY29udHJvbEMwIiwgT19SRE9OTFkpICAgID0gMwpjbG9zZSgzKSAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgPSAwCm9wZW4oIi9kZXYvc25kL2NvbnRyb2xDMCIsIE9fUkRX
UikgICAgICA9IDMKaW9jdGwoMywgVVNCREVWRlNfQ09OVFJPTCwgMHhiZWNiYTlmOCkgID0gMApp
b2N0bCgzLCBVSV9ERVZfQ1JFQVRFLCAweGJlY2JhOTcwKSAgICAgPSAwCmNsb3NlKDMpICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICA9IDAKb3BlbigiL3Vzci9saWIvbGliYXNvdW5kLnNv
LjIiLCBPX1JET05MWSkgPSAzCmZzdGF0KDMsIHtzdF9tb2RlPVNfSUZSRUd8MDc1NSwgc3Rfc2l6
ZT03NjIwNzIsIC4uLn0pID0gMApjbG9zZSgzKSAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgPSAwCm9wZW4oIi91c3IvbGliL2xpYmFzb3VuZC5zby4yIiwgT19SRE9OTFkpID0gMwpmc3Rh
dCgzLCB7c3RfbW9kZT1TX0lGUkVHfDA3NTUsIHN0X3NpemU9NzYyMDcyLCAuLi59KSA9IDAKY2xv
c2UoMykgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgID0gMApvcGVuKCIvdXNyL2xpYi9s
aWJhc291bmQuc28uMiIsIE9fUkRPTkxZKSA9IDMKZnN0YXQoMywge3N0X21vZGU9U19JRlJFR3ww
NzU1LCBzdF9zaXplPTc2MjA3MiwgLi4ufSkgPSAwCmNsb3NlKDMpICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICA9IDAKYWNjZXNzKCIvdXNyL3NoYXJlL2Fsc2EvY2FyZHMvVzY4MTEuY29u
ZiIsIFJfT0spID0gLTEgRU5PRU5UIChObyBzdWNoIGZpbGUgb3IgZGlyZWN0b3J5KQpvcGVuKCIv
ZGV2L3NuZC9jb250cm9sQzEiLCBPX1JET05MWSkgICAgPSAtMSBFTk9FTlQgKE5vIHN1Y2ggZmls
ZSBvciBkaXJlY3RvcnkpCm9wZW4oIi9kZXYvYWxvYWRDMSIsIE9fUkRPTkxZKSAgICAgICAgICA9
IC0xIEVOT0VOVCAoTm8gc3VjaCBmaWxlIG9yIGRpcmVjdG9yeSkKb3BlbigiL2Rldi9zbmQvY29u
dHJvbEMyIiwgT19SRE9OTFkpICAgID0gLTEgRU5PRU5UIChObyBzdWNoIGZpbGUgb3IgZGlyZWN0
b3J5KQpvcGVuKCIvZGV2L2Fsb2FkQzIiLCBPX1JET05MWSkgICAgICAgICAgPSAtMSBFTk9FTlQg
KE5vIHN1Y2ggZmlsZSBvciBkaXJlY3RvcnkpCm9wZW4oIi9kZXYvc25kL2NvbnRyb2xDMyIsIE9f
UkRPTkxZKSAgICA9IC0xIEVOT0VOVCAoTm8gc3VjaCBmaWxlIG9yIGRpcmVjdG9yeSkKb3Blbigi
L2Rldi9hbG9hZEMzIiwgT19SRE9OTFkpICAgICAgICAgID0gLTEgRU5PRU5UIChObyBzdWNoIGZp
bGUgb3IgZGlyZWN0b3J5KQpvcGVuKCIvZGV2L3NuZC9jb250cm9sQzQiLCBPX1JET05MWSkgICAg
PSAtMSBFTk9FTlQgKE5vIHN1Y2ggZmlsZSBvciBkaXJlY3RvcnkpCm9wZW4oIi9kZXYvYWxvYWRD
NCIsIE9fUkRPTkxZKSAgICAgICAgICA9IC0xIEVOT0VOVCAoTm8gc3VjaCBmaWxlIG9yIGRpcmVj
dG9yeSkKb3BlbigiL2Rldi9zbmQvY29udHJvbEM1IiwgT19SRE9OTFkpICAgID0gLTEgRU5PRU5U
IChObyBzdWNoIGZpbGUgb3IgZGlyZWN0b3J5KQpvcGVuKCIvZGV2L2Fsb2FkQzUiLCBPX1JET05M
WSkgICAgICAgICAgPSAtMSBFTk9FTlQgKE5vIHN1Y2ggZmlsZSBvciBkaXJlY3RvcnkpCm9wZW4o
Ii9kZXYvc25kL2NvbnRyb2xDNiIsIE9fUkRPTkxZKSAgICA9IC0xIEVOT0VOVCAoTm8gc3VjaCBm
aWxlIG9yIGRpcmVjdG9yeSkKb3BlbigiL2Rldi9hbG9hZEM2IiwgT19SRE9OTFkpICAgICAgICAg
ID0gLTEgRU5PRU5UIChObyBzdWNoIGZpbGUgb3IgZGlyZWN0b3J5KQpvcGVuKCIvZGV2L3NuZC9j
b250cm9sQzciLCBPX1JET05MWSkgICAgPSAtMSBFTk9FTlQgKE5vIHN1Y2ggZmlsZSBvciBkaXJl
Y3RvcnkpCm9wZW4oIi9kZXYvYWxvYWRDNyIsIE9fUkRPTkxZKSAgICAgICAgICA9IC0xIEVOT0VO
VCAoTm8gc3VjaCBmaWxlIG9yIGRpcmVjdG9yeSkKb3BlbigiL2Rldi9zbmQvY29udHJvbEM4Iiwg
T19SRE9OTFkpICAgID0gLTEgRU5PRU5UIChObyBzdWNoIGZpbGUgb3IgZGlyZWN0b3J5KQpvcGVu
KCIvZGV2L2Fsb2FkQzgiLCBPX1JET05MWSkgICAgICAgICAgPSAtMSBFTk9FTlQgKE5vIHN1Y2gg
ZmlsZSBvciBkaXJlY3RvcnkpCm9wZW4oIi9kZXYvc25kL2NvbnRyb2xDOSIsIE9fUkRPTkxZKSAg
ICA9IC0xIEVOT0VOVCAoTm8gc3VjaCBmaWxlIG9yIGRpcmVjdG9yeSkKb3BlbigiL2Rldi9hbG9h
ZEM5IiwgT19SRE9OTFkpICAgICAgICAgID0gLTEgRU5PRU5UIChObyBzdWNoIGZpbGUgb3IgZGly
ZWN0b3J5KQpvcGVuKCIvZGV2L3NuZC9jb250cm9sQzEwIiwgT19SRE9OTFkpICAgPSAtMSBFTk9F
TlQgKE5vIHN1Y2ggZmlsZSBvciBkaXJlY3RvcnkpCm9wZW4oIi9kZXYvYWxvYWRDMTAiLCBPX1JE
T05MWSkgICAgICAgICA9IC0xIEVOT0VOVCAoTm8gc3VjaCBmaWxlIG9yIGRpcmVjdG9yeSkKb3Bl
bigiL2Rldi9zbmQvY29udHJvbEMxMSIsIE9fUkRPTkxZKSAgID0gLTEgRU5PRU5UIChObyBzdWNo
IGZpbGUgb3IgZGlyZWN0b3J5KQpvcGVuKCIvZGV2L2Fsb2FkQzExIiwgT19SRE9OTFkpICAgICAg
ICAgPSAtMSBFTk9FTlQgKE5vIHN1Y2ggZmlsZSBvciBkaXJlY3RvcnkpCm9wZW4oIi9kZXYvc25k
L2NvbnRyb2xDMTIiLCBPX1JET05MWSkgICA9IC0xIEVOT0VOVCAoTm8gc3VjaCBmaWxlIG9yIGRp
cmVjdG9yeSkKb3BlbigiL2Rldi9hbG9hZEMxMiIsIE9fUkRPTkxZKSAgICAgICAgID0gLTEgRU5P
RU5UIChObyBzdWNoIGZpbGUgb3IgZGlyZWN0b3J5KQpvcGVuKCIvZGV2L3NuZC9jb250cm9sQzEz
IiwgT19SRE9OTFkpICAgPSAtMSBFTk9FTlQgKE5vIHN1Y2ggZmlsZSBvciBkaXJlY3RvcnkpCm9w
ZW4oIi9kZXYvYWxvYWRDMTMiLCBPX1JET05MWSkgICAgICAgICA9IC0xIEVOT0VOVCAoTm8gc3Vj
aCBmaWxlIG9yIGRpcmVjdG9yeSkKb3BlbigiL2Rldi9zbmQvY29udHJvbEMxNCIsIE9fUkRPTkxZ
KSAgID0gLTEgRU5PRU5UIChObyBzdWNoIGZpbGUgb3IgZGlyZWN0b3J5KQpvcGVuKCIvZGV2L2Fs
b2FkQzE0IiwgT19SRE9OTFkpICAgICAgICAgPSAtMSBFTk9FTlQgKE5vIHN1Y2ggZmlsZSBvciBk
aXJlY3RvcnkpCm9wZW4oIi9kZXYvc25kL2NvbnRyb2xDMTUiLCBPX1JET05MWSkgICA9IC0xIEVO
T0VOVCAoTm8gc3VjaCBmaWxlIG9yIGRpcmVjdG9yeSkKb3BlbigiL2Rldi9hbG9hZEMxNSIsIE9f
UkRPTkxZKSAgICAgICAgID0gLTEgRU5PRU5UIChObyBzdWNoIGZpbGUgb3IgZGlyZWN0b3J5KQpv
cGVuKCIvZGV2L3NuZC9jb250cm9sQzE2IiwgT19SRE9OTFkpICAgPSAtMSBFTk9FTlQgKE5vIHN1
Y2ggZmlsZSBvciBkaXJlY3RvcnkpCm9wZW4oIi9kZXYvYWxvYWRDMTYiLCBPX1JET05MWSkgICAg
ICAgICA9IC0xIEVOT0VOVCAoTm8gc3VjaCBmaWxlIG9yIGRpcmVjdG9yeSkKb3BlbigiL2Rldi9z
bmQvY29udHJvbEMxNyIsIE9fUkRPTkxZKSAgID0gLTEgRU5PRU5UIChObyBzdWNoIGZpbGUgb3Ig
ZGlyZWN0b3J5KQpvcGVuKCIvZGV2L2Fsb2FkQzE3IiwgT19SRE9OTFkpICAgICAgICAgPSAtMSBF
Tk9FTlQgKE5vIHN1Y2ggZmlsZSBvciBkaXJlY3RvcnkpCm9wZW4oIi9kZXYvc25kL2NvbnRyb2xD
MTgiLCBPX1JET05MWSkgICA9IC0xIEVOT0VOVCAoTm8gc3VjaCBmaWxlIG9yIGRpcmVjdG9yeSkK
b3BlbigiL2Rldi9hbG9hZEMxOCIsIE9fUkRPTkxZKSAgICAgICAgID0gLTEgRU5PRU5UIChObyBz
dWNoIGZpbGUgb3IgZGlyZWN0b3J5KQpvcGVuKCIvZGV2L3NuZC9jb250cm9sQzE5IiwgT19SRE9O
TFkpICAgPSAtMSBFTk9FTlQgKE5vIHN1Y2ggZmlsZSBvciBkaXJlY3RvcnkpCm9wZW4oIi9kZXYv
YWxvYWRDMTkiLCBPX1JET05MWSkgICAgICAgICA9IC0xIEVOT0VOVCAoTm8gc3VjaCBmaWxlIG9y
IGRpcmVjdG9yeSkKb3BlbigiL2Rldi9zbmQvY29udHJvbEMyMCIsIE9fUkRPTkxZKSAgID0gLTEg
RU5PRU5UIChObyBzdWNoIGZpbGUgb3IgZGlyZWN0b3J5KQpvcGVuKCIvZGV2L2Fsb2FkQzIwIiwg
T19SRE9OTFkpICAgICAgICAgPSAtMSBFTk9FTlQgKE5vIHN1Y2ggZmlsZSBvciBkaXJlY3Rvcnkp
Cm9wZW4oIi9kZXYvc25kL2NvbnRyb2xDMjEiLCBPX1JET05MWSkgICA9IC0xIEVOT0VOVCAoTm8g
c3VjaCBmaWxlIG9yIGRpcmVjdG9yeSkKb3BlbigiL2Rldi9hbG9hZEMyMSIsIE9fUkRPTkxZKSAg
ICAgICAgID0gLTEgRU5PRU5UIChObyBzdWNoIGZpbGUgb3IgZGlyZWN0b3J5KQpvcGVuKCIvZGV2
L3NuZC9jb250cm9sQzIyIiwgT19SRE9OTFkpICAgPSAtMSBFTk9FTlQgKE5vIHN1Y2ggZmlsZSBv
ciBkaXJlY3RvcnkpCm9wZW4oIi9kZXYvYWxvYWRDMjIiLCBPX1JET05MWSkgICAgICAgICA9IC0x
IEVOT0VOVCAoTm8gc3VjaCBmaWxlIG9yIGRpcmVjdG9yeSkKb3BlbigiL2Rldi9zbmQvY29udHJv
bEMyMyIsIE9fUkRPTkxZKSAgID0gLTEgRU5PRU5UIChObyBzdWNoIGZpbGUgb3IgZGlyZWN0b3J5
KQpvcGVuKCIvZGV2L2Fsb2FkQzIzIiwgT19SRE9OTFkpICAgICAgICAgPSAtMSBFTk9FTlQgKE5v
IHN1Y2ggZmlsZSBvciBkaXJlY3RvcnkpCm9wZW4oIi9kZXYvc25kL2NvbnRyb2xDMjQiLCBPX1JE
T05MWSkgICA9IC0xIEVOT0VOVCAoTm8gc3VjaCBmaWxlIG9yIGRpcmVjdG9yeSkKb3BlbigiL2Rl
di9hbG9hZEMyNCIsIE9fUkRPTkxZKSAgICAgICAgID0gLTEgRU5PRU5UIChObyBzdWNoIGZpbGUg
b3IgZGlyZWN0b3J5KQpvcGVuKCIvZGV2L3NuZC9jb250cm9sQzI1IiwgT19SRE9OTFkpICAgPSAt
MSBFTk9FTlQgKE5vIHN1Y2ggZmlsZSBvciBkaXJlY3RvcnkpCm9wZW4oIi9kZXYvYWxvYWRDMjUi
LCBPX1JET05MWSkgICAgICAgICA9IC0xIEVOT0VOVCAoTm8gc3VjaCBmaWxlIG9yIGRpcmVjdG9y
eSkKb3BlbigiL2Rldi9zbmQvY29udHJvbEMyNiIsIE9fUkRPTkxZKSAgID0gLTEgRU5PRU5UIChO
byBzdWNoIGZpbGUgb3IgZGlyZWN0b3J5KQpvcGVuKCIvZGV2L2Fsb2FkQzI2IiwgT19SRE9OTFkp
ICAgICAgICAgPSAtMSBFTk9FTlQgKE5vIHN1Y2ggZmlsZSBvciBkaXJlY3RvcnkpCm9wZW4oIi9k
ZXYvc25kL2NvbnRyb2xDMjciLCBPX1JET05MWSkgICA9IC0xIEVOT0VOVCAoTm8gc3VjaCBmaWxl
IG9yIGRpcmVjdG9yeSkKb3BlbigiL2Rldi9hbG9hZEMyNyIsIE9fUkRPTkxZKSAgICAgICAgID0g
LTEgRU5PRU5UIChObyBzdWNoIGZpbGUgb3IgZGlyZWN0b3J5KQpvcGVuKCIvZGV2L3NuZC9jb250
cm9sQzI4IiwgT19SRE9OTFkpICAgPSAtMSBFTk9FTlQgKE5vIHN1Y2ggZmlsZSBvciBkaXJlY3Rv
cnkpCm9wZW4oIi9kZXYvYWxvYWRDMjgiLCBPX1JET05MWSkgICAgICAgICA9IC0xIEVOT0VOVCAo
Tm8gc3VjaCBmaWxlIG9yIGRpcmVjdG9yeSkKb3BlbigiL2Rldi9zbmQvY29udHJvbEMyOSIsIE9f
UkRPTkxZKSAgID0gLTEgRU5PRU5UIChObyBzdWNoIGZpbGUgb3IgZGlyZWN0b3J5KQpvcGVuKCIv
ZGV2L2Fsb2FkQzI5IiwgT19SRE9OTFkpICAgICAgICAgPSAtMSBFTk9FTlQgKE5vIHN1Y2ggZmls
ZSBvciBkaXJlY3RvcnkpCm9wZW4oIi9kZXYvc25kL2NvbnRyb2xDMzAiLCBPX1JET05MWSkgICA9
IC0xIEVOT0VOVCAoTm8gc3VjaCBmaWxlIG9yIGRpcmVjdG9yeSkKb3BlbigiL2Rldi9hbG9hZEMz
MCIsIE9fUkRPTkxZKSAgICAgICAgID0gLTEgRU5PRU5UIChObyBzdWNoIGZpbGUgb3IgZGlyZWN0
b3J5KQpvcGVuKCIvZGV2L3NuZC9jb250cm9sQzMxIiwgT19SRE9OTFkpICAgPSAtMSBFTk9FTlQg
KE5vIHN1Y2ggZmlsZSBvciBkaXJlY3RvcnkpCm9wZW4oIi9kZXYvYWxvYWRDMzEiLCBPX1JET05M
WSkgICAgICAgICA9IC0xIEVOT0VOVCAoTm8gc3VjaCBmaWxlIG9yIGRpcmVjdG9yeSkKb3Blbigi
L3Vzci9saWIvbGliYXNvdW5kLnNvLjIiLCBPX1JET05MWSkgPSAzCmZzdGF0KDMsIHtzdF9tb2Rl
PVNfSUZSRUd8MDc1NSwgc3Rfc2l6ZT03NjIwNzIsIC4uLn0pID0gMApjbG9zZSgzKSAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgPSAwCm9wZW4oIi91c3IvbGliL2xpYmFzb3VuZC5zby4y
IiwgT19SRE9OTFkpID0gMwpmc3RhdCgzLCB7c3RfbW9kZT1TX0lGUkVHfDA3NTUsIHN0X3NpemU9
NzYyMDcyLCAuLi59KSA9IDAKY2xvc2UoMykgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ID0gMApvcGVuKCIvdXNyL2xpYi9saWJhc291bmQuc28uMiIsIE9fUkRPTkxZKSA9IDMKZnN0YXQo
Mywge3N0X21vZGU9U19JRlJFR3wwNzU1LCBzdF9zaXplPTc2MjA3MiwgLi4ufSkgPSAwCmNsb3Nl
KDMpICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA9IDAKb3BlbigiL3Vzci9saWIvbGli
YXNvdW5kLnNvLjIiLCBPX1JET05MWSkgPSAzCmZzdGF0KDMsIHtzdF9tb2RlPVNfSUZSRUd8MDc1
NSwgc3Rfc2l6ZT03NjIwNzIsIC4uLn0pID0gMApjbG9zZSgzKSAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgPSAwCm9wZW4oIi91c3IvbGliL2xpYmFzb3VuZC5zby4yIiwgT19SRE9OTFkp
ID0gMwpmc3RhdCgzLCB7c3RfbW9kZT1TX0lGUkVHfDA3NTUsIHN0X3NpemU9NzYyMDcyLCAuLi59
KSA9IDAKY2xvc2UoMykgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgID0gMApvcGVuKCIv
ZGV2L3NuZC9jb250cm9sQzAiLCBPX1JET05MWSkgICAgPSAzCmNsb3NlKDMpICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICA9IDAKc3RhdCgiL3Vzci9zaGFyZS9hbHNhL2Fsc2EuY29uZiIs
IHtzdF9tb2RlPVNfSUZSRUd8MDY0NCwgc3Rfc2l6ZT04NjExLCAuLi59KSA9IDAKb3BlbigiL2Rl
di9zbmQvY29udHJvbEMwIiwgT19SRE9OTFkpICAgID0gMwpjbG9zZSgzKSAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgPSAwCm9wZW4oIi9kZXYvc25kL2NvbnRyb2xDMCIsIE9fUkRXUikg
ICAgICA9IDMKaW9jdGwoMywgVVNCREVWRlNfQ09OVFJPTCwgMHhiZWNiYTYzNCkgID0gMAppb2N0
bCgzLCBVSV9ERVZfQ1JFQVRFLCAweGJlY2JhNWFjKSAgICAgPSAwCmNsb3NlKDMpICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICA9IDAKb3BlbigiL3Vzci9saWIvbGliYXNvdW5kLnNvLjIi
LCBPX1JET05MWSkgPSAzCmZzdGF0KDMsIHtzdF9tb2RlPVNfSUZSRUd8MDc1NSwgc3Rfc2l6ZT03
NjIwNzIsIC4uLn0pID0gMApjbG9zZSgzKSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
PSAwCm9wZW4oIi91c3IvbGliL2xpYmFzb3VuZC5zby4yIiwgT19SRE9OTFkpID0gMwpmc3RhdCgz
LCB7c3RfbW9kZT1TX0lGUkVHfDA3NTUsIHN0X3NpemU9NzYyMDcyLCAuLi59KSA9IDAKY2xvc2Uo
MykgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgID0gMApvcGVuKCIvdXNyL2xpYi9saWJh
c291bmQuc28uMiIsIE9fUkRPTkxZKSA9IDMKZnN0YXQoMywge3N0X21vZGU9U19JRlJFR3wwNzU1
LCBzdF9zaXplPTc2MjA3MiwgLi4ufSkgPSAwCmNsb3NlKDMpICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICA9IDAKb3BlbigiL3Vzci9saWIvbGliYXNvdW5kLnNvLjIiLCBPX1JET05MWSkg
PSAzCmZzdGF0KDMsIHtzdF9tb2RlPVNfSUZSRUd8MDc1NSwgc3Rfc2l6ZT03NjIwNzIsIC4uLn0p
ID0gMApjbG9zZSgzKSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPSAwCm9wZW4oIi91
c3IvbGliL2xpYmFzb3VuZC5zby4yIiwgT19SRE9OTFkpID0gMwpmc3RhdCgzLCB7c3RfbW9kZT1T
X0lGUkVHfDA3NTUsIHN0X3NpemU9NzYyMDcyLCAuLi59KSA9IDAKY2xvc2UoMykgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgID0gMApvcGVuKCIvZGV2L3NuZC9jb250cm9sQzAiLCBPX1JE
T05MWSkgICAgPSAzCmNsb3NlKDMpICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA9IDAK
b3BlbigiL2Rldi9zbmQvY29udHJvbEMwIiwgT19SRFdSKSAgICAgID0gMwppb2N0bCgzLCBVU0JE
RVZGU19DT05UUk9MLCAweGJlY2JhN2Q4KSAgPSAwCmlvY3RsKDMsIDB4NDAwNDU1MzIsIDB4YmVj
YmE3ZTQpICAgICAgICA9IDAKb3BlbigiL2Rldi9zbmQvcGNtQzBEMGMiLCBPX1JEV1J8T19OT05C
TE9DSykgPSA0CmNsb3NlKDMpICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA9IDAKaW9j
dGwoNCwgQUdQSU9DX0FDUVVJUkUgb3IgQVBNX0lPQ19TVEFOREJZLCAweGJlY2JhNjI4KSA9IDAK
ZmNudGwoNCwgRl9HRVRGTCkgICAgICAgICAgICAgICAgICAgICAgID0gMHg4MDIgKGZsYWdzIE9f
UkRXUnxPX05PTkJMT0NLKQppb2N0bCg0LCBBR1BJT0NfSU5GTywgMHhiZWNiYTdkNCkgICAgICAg
PSAwCmlvY3RsKDQsIEFHUElPQ19SRUxFQVNFIG9yIEFQTV9JT0NfU1VTUEVORCwgMHhiZWNiYTdj
YykgPSAwCm1tYXAyKE5VTEwsIDQwOTYsIFBST1RfUkVBRCwgTUFQX1NIQVJFRCwgNCwgMHhmZmY4
MDAwMCkgPSAtMSBFTlhJTyAoTm8gc3VjaCBkZXZpY2Ugb3IgYWRkcmVzcykKaW9jdGwoNCwgMHhj
MDg0NDEyMywgMHhiZWNiYTc0OCkgICAgICAgID0gMApmY250bCg0LCBGX0dFVEZMKSAgICAgICAg
ICAgICAgICAgICAgICAgPSAweDgwMiAoZmxhZ3MgT19SRFdSfE9fTk9OQkxPQ0spCmZjbnRsKDQs
IEZfU0VURkwsIE9fUkRXUikgICAgICAgICAgICAgICA9IDAKaW9jdGwoNCwgQUdQSU9DX0FDUVVJ
UkUgb3IgQVBNX0lPQ19TVEFOREJZLCAweGJlY2JhY2JjKSA9IDAKcnRfc2lnYWN0aW9uKFNJR0lO
VCwgezB4MTE1MzAsIFtJTlRdLCBTQV9SRVNUQVJUfDB4NDAwMDAwMH0sIHtTSUdfREZMfSwgOCkg
PSAwCnJ0X3NpZ2FjdGlvbihTSUdURVJNLCB7MHgxMTUzMCwgW1RFUk1dLCBTQV9SRVNUQVJUfDB4
NDAwMDAwMH0sIHtTSUdfREZMfSwgOCkgPSAwCnJ0X3NpZ2FjdGlvbihTSUdBQlJULCB7MHgxMTUz
MCwgW0FCUlRdLCBTQV9SRVNUQVJUfDB4NDAwMDAwMH0sIHtTSUdfREZMfSwgOCkgPSAwCndyaXRl
KDIsICJSZWNvcmRpbmciLCA5UmVjb3JkaW5nKSAgICAgICAgICAgICAgICA9IDkKd3JpdGUoMiwg
IiAiLCAxICkgICAgICAgICAgICAgICAgICAgICAgICA9IDEKd3JpdGUoMiwgInJhdyBkYXRhIiwg
OHJhdyBkYXRhKSAgICAgICAgICAgICAgICAgPSA4CndyaXRlKDIsICIgXCciLCAyICcpICAgICAg
ICAgICAgICAgICAgICAgID0gMgp3cml0ZSgyLCAidGVzdC5yYXciLCA4dGVzdC5yYXcpICAgICAg
ICAgICAgICAgICA9IDgKd3JpdGUoMiwgIlwnIDogIiwgNCcgOiApICAgICAgICAgICAgICAgICAg
ICA9IDQKd3JpdGUoMiwgIlNpZ25lZCA4IGJpdCIsIDEyU2lnbmVkIDggYml0KSAgICAgICAgICAg
ID0gMTIKd3JpdGUoMiwgIiwgIiwgMiwgKSAgICAgICAgICAgICAgICAgICAgICAgPSAyCndyaXRl
KDIsICJSYXRlICIsIDVSYXRlICkgICAgICAgICAgICAgICAgICAgID0gNQp3cml0ZSgyLCAiODAw
MCIsIDQ4MDAwKSAgICAgICAgICAgICAgICAgICAgID0gNAp3cml0ZSgyLCAiIEh6LCAiLCA1IEh6
LCApICAgICAgICAgICAgICAgICAgICA9IDUKd3JpdGUoMiwgIk1vbm8iLCA0TW9ubykgICAgICAg
ICAgICAgICAgICAgICA9IDQKd3JpdGUoMiwgIlxuIiwgMQopICAgICAgICAgICAgICAgICAgICAg
ICA9IDEKaW9jdGwoNCwgMHhjMjVjNDExMCwgMHhiZWNiODY3NCkgICAgICAgID0gMAppb2N0bCg0
LCAweGMyNWM0MTEwLCAweGJlY2I4Njc0KSAgICAgICAgPSAwCmlvY3RsKDQsIDB4YzI1YzQxMTAs
IDB4YmVjYjg2NzQpICAgICAgICA9IDAKaW9jdGwoNCwgMHhjMjVjNDExMCwgMHhiZWNiODNlOCkg
ICAgICAgID0gMAppb2N0bCg0LCAweGMyNWM0MTEwLCAweGJlY2I4M2U4KSAgICAgICAgPSAwCmlv
Y3RsKDQsIDB4YzI1YzQxMTAsIDB4YmVjYjgzZTgpICAgICAgICA9IDAKaW9jdGwoNCwgMHhjMjVj
NDExMCwgMHhiZWNiODNlOCkgICAgICAgID0gMAppb2N0bCg0LCAweGMyNWM0MTEwLCAweGJlY2I4
M2U4KSAgICAgICAgPSAwCmlvY3RsKDQsIDB4YzI1YzQxMTAsIDB4YmVjYjgzZTgpICAgICAgICA9
IDAKaW9jdGwoNCwgMHhjMjVjNDExMCwgMHhiZWNiODNlOCkgICAgICAgID0gMAppb2N0bCg0LCAw
eGMyNWM0MTEwLCAweGJlY2I4M2U4KSAgICAgICAgPSAwCmlvY3RsKDQsIDB4YzI1YzQxMTAsIDB4
YmVjYjdlZWMpICAgICAgICA9IDAKaW9jdGwoNCwgMHhjMjVjNDExMCwgMHhiZWNiN2VlYykgICAg
ICAgID0gMAppb2N0bCg0LCAweGMyNWM0MTEwLCAweGJlY2I3ZWVjKSAgICAgICAgPSAwCmlvY3Rs
KDQsIDB4YzI1YzQxMTAsIDB4YmVjYjgxNGMpICAgICAgICA9IDAKaW9jdGwoNCwgMHhjMjVjNDEx
MCwgMHhiZWNiODE0YykgICAgICAgID0gMAppb2N0bCg0LCAweGMyNWM0MTEwLCAweGJlY2I4MTRj
KSAgICAgICAgPSAwCmlvY3RsKDQsIDB4YzI1YzQxMTAsIDB4YmVjYjdlZWMpICAgICAgICA9IDAK
aW9jdGwoNCwgMHhjMjVjNDExMCwgMHhiZWNiN2VlYykgICAgICAgID0gMAppb2N0bCg0LCAweGMy
NWM0MTEwLCAweGJlY2I3ZWVjKSAgICAgICAgPSAwCmlvY3RsKDQsIDB4YzI1YzQxMTAsIDB4YmVj
YjgxNGMpICAgICAgICA9IDAKaW9jdGwoNCwgMHhjMjVjNDExMCwgMHhiZWNiODE0YykgICAgICAg
ID0gMAppb2N0bCg0LCAweGMyNWM0MTEwLCAweGJlY2I4MTRjKSAgICAgICAgPSAwCmlvY3RsKDQs
IDB4YzI1YzQxMTAsIDB4YmVjYjdlZWMpICAgICAgICA9IDAKaW9jdGwoNCwgMHhjMjVjNDExMCwg
MHhiZWNiN2VlYykgICAgICAgID0gMAppb2N0bCg0LCAweGMyNWM0MTEwLCAweGJlY2I3ZWVjKSAg
ICAgICAgPSAwCmlvY3RsKDQsIDB4YzI1YzQxMTAsIDB4YmVjYjgxNGMpICAgICAgICA9IDAKaW9j
dGwoNCwgMHhjMjVjNDExMCwgMHhiZWNiODE0YykgICAgICAgID0gMAppb2N0bCg0LCAweGMyNWM0
MTEwLCAweGJlY2I4MTRjKSAgICAgICAgPSAwCmlvY3RsKDQsIDB4YzI1YzQxMTAsIDB4YmVjYjg1
ZTQpICAgICAgICA9IDAKaW9jdGwoNCwgMHhjMjVjNDExMCwgMHhiZWNiODVlNCkgICAgICAgID0g
MAppb2N0bCg0LCAweGMyNWM0MTEwLCAweGJlY2I4NWQ4KSAgICAgICAgPSAwCmlvY3RsKDQsIDB4
YzI1YzQxMTAsIDB4YmVjYjg5OGMpICAgICAgICA9IDAKaW9jdGwoNCwgMHhjMjVjNDExMSwgMHhi
ZWNiODk4YykgICAgICAgID0gMAppb2N0bCg0LCAweGMwODQ0MTIzLCAweDI0ZjU4KSAgICAgICAg
ICAgPSAwCmlvY3RsKDQsIDB4YzA2ODQxMTMsIDB4YmVjYjg1NTQpICAgICAgICA9IDAKaW9jdGwo
NCwgMHhjMDg0NDEyMywgMHgyNGY1OCkgICAgICAgICAgID0gMAppb2N0bCg0LCAweDQxNDAsIDB4
NDAwYmExYTgpICAgICAgICAgICAgPSAwCmlvY3RsKDQsIDB4YzA4NDQxMjMsIDB4MjRmNTgpICAg
ICAgICAgICA9IDAKaW9jdGwoNCwgMHhjMDg0NDEyMywgMHgyNGY1OCkgICAgICAgICAgID0gMApy
bWRpcigidGVzdC5yYXciKSAgICAgICAgICAgICAgICAgICAgICAgPSAtMSBFTk9URElSIChOb3Qg
YSBkaXJlY3RvcnkpCnVubGluaygidGVzdC5yYXciKSAgICAgICAgICAgICAgICAgICAgICA9IDAK
b3BlbigidGVzdC5yYXciLCBPX1dST05MWXxPX0NSRUFUfE9fTEFSR0VGSUxFLCAwNjQ0KSA9IDMK
aW9jdGwoNCwgMHg4MDBjNDE1MSwgMHhiZWNiOGMzNCkgICAgICAgID0gLTEgRUlPIChJbnB1dC9v
dXRwdXQgZXJyb3IpCndyaXRlKDIsICJhcmVjb3JkIiwgN2FyZWNvcmQpICAgICAgICAgICAgICAg
ICAgPSA3CndyaXRlKDIsICI6ICIsIDI6ICkgICAgICAgICAgICAgICAgICAgICAgID0gMgp3cml0
ZSgyLCAicGNtX3JlYWQiLCA4cGNtX3JlYWQpICAgICAgICAgICAgICAgICA9IDgKd3JpdGUoMiwg
IjoiLCAxOikgICAgICAgICAgICAgICAgICAgICAgICA9IDEKd3JpdGUoMiwgIjEzNDYiLCA0MTM0
NikgICAgICAgICAgICAgICAgICAgICA9IDQKd3JpdGUoMiwgIjogIiwgMjogKSAgICAgICAgICAg
ICAgICAgICAgICAgPSAyCndyaXRlKDIsICJyZWFkIGVycm9yOiAiLCAxMnJlYWQgZXJyb3I6ICkg
ICAgICAgICAgICA9IDEyCndyaXRlKDIsICJJbnB1dC9vdXRwdXQgZXJyb3IiLCAxOElucHV0L291
dHB1dCBlcnJvcikgICAgICA9IDE4CndyaXRlKDIsICJcbiIsIDEKKSAgICAgICAgICAgICAgICAg
ICAgICAgPSAxCmV4aXQoMSkgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA9ID8KUHJv
Y2VzcyA3NTQgZGV0YWNoZWQKCg==
------=_Part_154367_19235117.1182457944863
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

------=_Part_154367_19235117.1182457944863--
