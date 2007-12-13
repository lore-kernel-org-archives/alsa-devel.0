From: "Salatiel Filho" <salatiel.filho@gmail.com>
Subject: function snd_mixer_load failed: Inappropriate ioctl
	for device
Date: Wed, 12 Dec 2007 21:45:26 -0300
Message-ID: <beb91d720712121645p62acfc10r99135a15dd5ee47e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.238])
	by alsa0.perex.cz (Postfix) with ESMTP id D7224103865
	for <alsa-devel@alsa-project.org>; Thu, 13 Dec 2007 01:45:28 +0100 (CET)
Received: by nz-out-0506.google.com with SMTP id m22so260249nzf.2
	for <alsa-devel@alsa-project.org>; Wed, 12 Dec 2007 16:45:27 -0800 (PST)
Content-Disposition: inline
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

***  please let me in the to or cc fields. I am not on the list ***

I am having a big trouble to make sound work on my ARM machine. I am
running debian 4.



#  uname -a
Linux LS-GL7D6 2.6.16.57-arm2 #7 Wed Dec 12 18:14:51 BRT 2007
armv5tejl GNU/Linux

# cat /proc/asound/version
Advanced Linux Sound Architecture Driver Version 1.0.15.
Compiled on Dec 12 2007 for kernel 2.6.16.57-arm2.


Modules load successfully

# lsmod
Module                  Size  Used by
snd_pcm_oss            47680  0
snd_mixer_oss          15040  1 snd_pcm_oss
snd_usb_audio          79904  0
snd_pcm                75877  2 snd_pcm_oss,snd_usb_audio
snd_timer              20164  1 snd_pcm
snd_page_alloc          8264  1 snd_pcm
snd_usb_lib            15808  1 snd_usb_audio
snd_rawmidi            21376  1 snd_usb_lib
snd_seq_device          7116  1 snd_rawmidi
snd_hwdep               7460  1 snd_usb_audio
snd                    54368  9
snd_pcm_oss,snd_mixer_oss,snd_usb_audio,snd_pcm,snd_timer,snd_usb_lib,snd_r=
awmidi,snd_seq_device,snd_hwdep
soundcore               7684  1 snd
nfs                   102044  0
lockd                  61780  1 nfs
sunrpc                142808  3 nfs,lockd
dm_mod                 48176  0
usbhid                 38628  0



# cat /proc/asound/cards
 0 [default        ]: USB-Audio - C-Media USB Headphone Set
                     C-Media USB Headphone Set   at
usb-ehci_platform.4523-1, full speed


# cat /proc/asound/version
Advanced Linux Sound Architecture Driver Version 1.0.15.
Compiled on Dec 12 2007 for kernel 2.6.16.57-arm2.

but everytime i try to use alsamixer i get:


# alsamixer
alsamixer: function snd_mixer_load failed: Inappropriate ioctl for device

# aplay test.wav
Playing WAVE 'test.wav' : Unsigned 8 bit, Rate 8000 Hz, Mono
aplay: xrun:1090: read/write error, state =3D PREPARED


# strace alsamixer
...
stat64("/usr//share/alsa/alsa.conf", {st_mode=3DS_IFREG|0644,
st_size=3D8611, ...}) =3D 0
open("/usr//share/alsa/alsa.conf", O_RDONLY) =3D 3
fstat64(3, {st_mode=3DS_IFREG|0644, st_size=3D8611, ...}) =3D 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) =3D 0x40017000
read(3, "#\n#  ALSA library configuration "..., 4096) =3D 4096
read(3, "r\n\t\t\t\tname defaults.pcm.device\n\t"..., 4096) =3D 4096
read(3, "{\n\t\t\t@func refer\n\t\t\tname default"..., 4096) =3D 419
read(3, "", 4096)                       =3D 0
read(3, "", 4096)                       =3D 0
close(3)                                =3D 0
munmap(0x40017000, 4096)                =3D 0
access("/etc/asound.conf", R_OK)        =3D -1 ENOENT (No such file or dire=
ctory)
access("/root/.asoundrc", R_OK)         =3D -1 ENOENT (No such file or dire=
ctory)
open("/dev/snd/controlC0", O_RDONLY)    =3D 3
close(3)                                =3D 0
open("/dev/snd/controlC0", O_RDWR)      =3D 3
ioctl(3, USBDEVFS_CONTROL, 0xbec2da64)  =3D 0
ioctl(3, UI_DEV_CREATE, 0xbec2db2c)     =3D 0
close(3)                                =3D 0
stat64("/usr//share/alsa/alsa.conf", {st_mode=3DS_IFREG|0644,
st_size=3D8611, ...}) =3D 0
open("/dev/snd/controlC0", O_RDONLY)    =3D 3
close(3)                                =3D 0
open("/dev/snd/controlC0", O_RDWR)      =3D 3
ioctl(3, USBDEVFS_CONTROL, 0xbec2da44)  =3D 0
fcntl64(3, F_GETFL)                     =3D 0x2 (flags O_RDWR)
fcntl64(3, F_SETFL, O_RDWR|O_NONBLOCK)  =3D 0
ioctl(3, USBDEVFS_RELEASEINTERFACE, 0xbec2dac0) =3D 0
ioctl(3, USBDEVFS_RELEASEINTERFACE, 0xbec2dac0) =3D 0
ioctl(3, USBDEVFS_CONNECTINFO, 0xbec2d86c) =3D 0
ioctl(3, USBDEVFS_IOCTL, 0xbec2d42c)    =3D -1 ENOTTY (Inappropriate
ioctl for device)
fstat64(1, {st_mode=3DS_IFCHR|0620, st_rdev=3Dmakedev(136, 2), ...}) =3D 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) =3D 0x40017000
write(1, "\n", 1
)                       =3D 1
write(2, "alsamixer: function snd_mixer_lo"..., 74alsamixer: function
snd_mixer_load failed: Inappropriate ioctl for device
) =3D 74
munmap(0x40017000, 4096)                =3D 0
io_submit(0x2, 0, 0x8 <unfinished ... exit status 2>


any help?



The same card works ok on my x86 machine using . So the problem is not
the card but something else.




-- =

[]'s
Salatiel

"O maior prazer do inteligente =E9 bancar o  idiota
   diante de um  idiota que banca o inteligente".
