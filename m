From: David Alexander <lidxv0n@gmail.com>
Subject: Re: trying to get an eleven rack to work
Date: Thu, 29 Mar 2012 10:02:44 -0400
Message-ID: <CAOyn=DGYAr5kCPTRcf=QN8ypMZy3SWpN--zvKBevWcr4Tnqr_w@mail.gmail.com>
References: <CAOyn=DH_BCQh-DksiLGQnQw1kq0eNNH+Zi7KdRdX5=uot9x2Eg@mail.gmail.com>
	<4F6883F9.4010405@ladisch.de>
	<CACckToUeX7oJmQ9NeRLGecxOxWaLpxbZDnNWA0+t5+XxFvf+FQ@mail.gmail.com>
	<4F718114.5020602@ladisch.de>
	<CAOyn=DFig0m1zFRWyTE6Neimrcy12PPAoNL8BdFVaAUrYEYbGw@mail.gmail.com>
	<4F740A6A.3030608@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179])
	by alsa0.perex.cz (Postfix) with ESMTP id AF2FE104447
	for <alsa-devel@alsa-project.org>;
	Thu, 29 Mar 2012 16:02:47 +0200 (CEST)
Received: by iakh37 with SMTP id h37so3199372iak.38
	for <alsa-devel@alsa-project.org>; Thu, 29 Mar 2012 07:02:44 -0700 (PDT)
In-Reply-To: <4F740A6A.3030608@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org, Daniel Mack <daniel@zonque.org>
List-Id: alsa-devel@alsa-project.org

Here is what I am getting after having changed the line in mixer.c:

[   92.284035] usb 2-4: new high speed USB device number 2 using ehci_hcd
[   92.815354] ALSA mixer.c:1938 usbaudio: unit 32: unexpected type 0x09
[   92.815382] snd-usb-audio: probe of 2-4:1.0 failed with error -5
[   92.816352] ALSA mixer.c:1938 usbaudio: unit 32: unexpected type 0x09
[   92.816372] snd-usb-audio: probe of 2-4:1.1 failed with error -5
[   92.816966] ALSA mixer.c:1938 usbaudio: unit 32: unexpected type 0x09
[   92.816980] snd-usb-audio: probe of 2-4:1.2 failed with error -5
[   92.817960] ALSA mixer.c:1938 usbaudio: unit 32: unexpected type 0x09
[   92.817972] snd-usb-audio: probe of 2-4:1.3 failed with error -5
[   92.818587] ALSA mixer.c:1938 usbaudio: unit 32: unexpected type 0x09
[   92.818598] snd-usb-audio: probe of 2-4:1.4 failed with error -5
[   92.818638] usbcore: registered new interface driver snd-usb-audio


I noticed that I am not getting an entry under /proc/asound that I had
before.  Before I got an entry called "Rack" with a sym link to card1:

/proc/asound$ ls -l
total 0
dr-xr-xr-x 5 root root 0 2012-03-29 09:52 card0
-r--r--r-- 1 root root 0 2012-03-29 10:01 cards
-r--r--r-- 1 root root 0 2012-03-29 10:01 devices
-r--r--r-- 1 root root 0 2012-03-29 10:01 hwdep
lrwxrwxrwx 1 root root 5 2012-03-29 10:01 Intel -> card0
-r--r--r-- 1 root root 0 2012-03-29 10:01 modules
-r--r--r-- 1 root root 0 2012-03-29 10:01 pcm
dr-xr-xr-x 2 root root 0 2012-03-29 10:01 seq
-r--r--r-- 1 root root 0 2012-03-29 10:01 timers
-r--r--r-- 1 root root 0 2012-03-29 10:01 version


Thank you,
David

On Thu, Mar 29, 2012 at 3:08 AM, Clemens Ladisch <clemens@ladisch.de> wrote:
> David Alexander wrote:
>> kernel: [ =A0 74.128035] usb 2-4: new high speed USB device number 2
>> kernel: [ =A0 74.634592] ALSA mixer.c:1938 usbaudio: unit 32: unexpected=
 type 0x09
>> kernel: [ =A0 74.634606] snd-usb-audio: probe of 2-4:1.0 failed with err=
or -5
>
> 0x09 is UAC2's EXTENSION_UNIT, which should not be a reason for failing.
> Please try the patch below.
>
>
> Regards,
> Clemens
>
>
> --- a/sound/usb/mixer.c
> +++ b/sound/usb/mixer.c
> @@ -1926,7 +1926,7 @@ static int parse_audio_unit(struct mixer_build *sta=
te, int unitid)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return parse_audio_process=
ing_unit(state, unitid, p1);
> =A0 =A0 =A0 =A0default:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0snd_printk(KERN_ERR "usbaudio: unit %u: un=
expected type 0x%02x\n", unitid, p1[2]);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> =A0 =A0 =A0 =A0}
> =A0}
>
