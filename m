From: Grant Diffey <gdiffey@gmail.com>
Subject: Re: [PATCH 0/6] snd-usb endpoint rework, version 6
Date: Sat, 31 Dec 2011 19:04:12 +1100
Message-ID: <CACckToXw=J6cW_fSPq_7HEKAQBTd4ki_ao+92_2s1dFyMX=aUw@mail.gmail.com>
References: <1324656947-23169-1-git-send-email-zonque@gmail.com>
	<4EFDC32B.10808@gmail.com>
	<CAFz=ag6XNJSXvYQnAEbx=M+zXVH7sEw=_CJQKx63MmdQBWFuwA@mail.gmail.com>
	<4EFDD7A7.3010706@gmail.com>
	<CACckToWP-C5H2xhvdJ5ykNf4BcuNCa4cMyFh2hppcwW0u33fQQ@mail.gmail.com>
	<4EFE6E52.4050503@gmail.com>
	<CACckToW62HfbWeg0zXAaAmVPksWGZXzg1nWvSWoWav6CSwLO0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ee0-f51.google.com (mail-ee0-f51.google.com [74.125.83.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 8E033103807
	for <alsa-devel@alsa-project.org>; Sat, 31 Dec 2011 09:04:12 +0100 (CET)
Received: by eekb57 with SMTP id b57so13364016eek.38
	for <alsa-devel@alsa-project.org>; Sat, 31 Dec 2011 00:04:12 -0800 (PST)
In-Reply-To: <CACckToW62HfbWeg0zXAaAmVPksWGZXzg1nWvSWoWav6CSwLO0w@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sat, Dec 31, 2011 at 3:35 PM, Grant Diffey <gdiffey@gmail.com> wrote:

>
> Yes, any kind of USB audio device is good.
>>
>> Thanks for heling test! :)
>>
>>
>>
> So sadly not all is well in my world the logitech is only registering as a
> mono device for some reason.
>
> nevyn@cetacea:~$ speaker-test -c 2 -D hw:Headset
>
> speaker-test 1.0.24.2
>
> Playback device is hw:Headset
> Stream parameters are 48000Hz, S16_LE, 2 channels
> Using 16 octaves of pink noise
> Channels count (2) not available for playbacks: Invalid argument
> Setting of hwparams failed: Invalid argument
>
>
> it's clearly stereo. lsusb -vv attached for reference
>


This also affects the 3.2-rc2 version I compiled a few weeks ago

3.0.0-rc5 correctly registers the device as stereo.
