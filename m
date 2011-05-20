From: Grant Diffey <gdiffey@gmail.com>
Subject: Re: A plea for help on mixer support for Fast Track
 Ultra (8R)
Date: Sat, 21 May 2011 01:43:43 +1000
Message-ID: <BANLkTimS+VrNTsicpJQ30En7cH68VTFOXQ@mail.gmail.com>
References: <4DD3E39D.30100@showlabor.de>
	<BANLkTinCn2Q+asKhGAoq+3S+AtqyHrg2wg@mail.gmail.com>
	<4DD413FC.2090808@showlabor.de>
	<BANLkTi=2NeMGL6n7B0n-2p9La=45pM7ZHg@mail.gmail.com>
	<s5hhb8r1c20.wl%tiwai@suse.de> <4DD4BC97.5090702@showlabor.de>
	<s5h39kb17bv.wl%tiwai@suse.de> <4DD4D162.20608@showlabor.de>
	<BANLkTi=6CHJyFxvk9eVA430uhiwJ7f86vA@mail.gmail.com>
	<BANLkTi=OsrZKq3ZmC5cdFfuWb7qSOkPitw@mail.gmail.com>
	<4DD51E38.7090406@showlabor.de>
	<BANLkTiksJbpMr61QOfJ26iVhETDhSBDRFA@mail.gmail.com>
	<4DD63E8F.2030306@showlabor.de> <4DD64D13.9070200@showlabor.de>
	<BANLkTik-_m-Anr2s5=+G7ksyCHdOEGfN2w@mail.gmail.com>
	<BANLkTik9LLnvZRXE=8LW2UOrOOVCjp+kDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id DB99B243EB
	for <alsa-devel@alsa-project.org>;
	Fri, 20 May 2011 17:43:46 +0200 (CEST)
Received: by eyg5 with SMTP id 5so1331561eyg.38
	for <alsa-devel@alsa-project.org>; Fri, 20 May 2011 08:43:43 -0700 (PDT)
In-Reply-To: <BANLkTik9LLnvZRXE=8LW2UOrOOVCjp+kDg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Felix Homann <linuxaudio@showlabor.de>
List-Id: alsa-devel@alsa-project.org

So something is very whacky with the control map. not sure how to debug
this.

The original patch felix posted works as I expect this one doesn't where
should I start debugging this?

Grant.


On Sat, May 21, 2011 at 1:08 AM, Grant Diffey <gdiffey@gmail.com> wrote:

> so this works.. (ie compiles and I get controls that do change volumes of
> things )
>
> I think there's something whacky with the control map. (I can't seem to
> send Ain5 to out 1 and 2 successfully. but I'll test this with felix's
> original code.
>
> The Ain's are not capture volumes for this device.
>
> There's 8 "analog ins" and 8 "software returns" (pcm channels) that are
> mixed to 8 outputs. all the input gain controls are physical or line +4db
> level balanced
>
> Grant.
>
>
>
> On Fri, May 20, 2011 at 9:37 PM, Daniel Mack <zonque@gmail.com> wrote:
>
>> On Fri, May 20, 2011 at 1:14 PM, Felix Homann <linuxaudio@showlabor.de>
>> wrote:
>> > Sorry, here are the first lines:
>> >
>> > [ 4104.510080] usb 1-3: new high speed USB device using ehci_hcd and
>> address
>> > 2
>> > [ 4104.661745] usb 1-3: config 1 interface 3 altsetting 0 bulk endpoint
>> 0x7
>> > has invalid maxpacket 8
>> > [ 4104.661750] usb 1-3: config 1 interface 3 altsetting 0 bulk endpoint
>> 0x87
>> > has invalid maxpacket 8
>> > [ 4104.824137] BUG: unable to handle kernel NULL pointer dereference at
>> > 0000000000000020
>> > [ 4104.824147] IP: [<ffffffffa04b0119>]
>> snd_usb_mixer_controls+0x49/0x1a0
>> > [snd_usb_audio]
>>
>> Ok, chip->ctrl_intf needs to be initialized. Next try ...
>>
>>
>> Daniel
>>
>
>
