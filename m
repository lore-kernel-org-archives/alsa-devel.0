From: James Courtier-Dutton <james.dutton@gmail.com>
Subject: Re: [PATCH 1/1] Added functionality for E-mu
	0404USB/0202USB/TrackerPre
Date: Mon, 28 Dec 2009 21:47:06 +1100
Message-ID: <ad2655cb0912280247m48d69f8fva420f977c8e10468@mail.gmail.com>
References: <ad2655cb0912270404g56ecb3bfwc6fa91a6d02f639f@mail.gmail.com>
	<464603.71470.qm@web56101.mail.re3.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f212.google.com (mail-fx0-f212.google.com
	[209.85.220.212])
	by alsa0.perex.cz (Postfix) with ESMTP id 875F1103841
	for <alsa-devel@alsa-project.org>; Mon, 28 Dec 2009 11:47:06 +0100 (CET)
Received: by fxm4 with SMTP id 4so33004337fxm.32
	for <alsa-devel@alsa-project.org>; Mon, 28 Dec 2009 02:47:06 -0800 (PST)
In-Reply-To: <464603.71470.qm@web56101.mail.re3.yahoo.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sergiy Kovalchuk <cnb_zerg@yahoo.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

2009/12/28 Sergiy Kovalchuk <cnb_zerg@yahoo.com>:
>>
>> Further info for set_format_emu_quirk()
>>
>
> Thank you for valuable information, especially for digital-in/out control/status values.
> My first approach is to bring full functionality for analogue playback and capture, and current patch meets this demand, except capturing above 96kHz (I've got nothing, but white noise).
> I'll appreciate any information that relates to 174.6kHz and 192kHz capture for E-mu products (MacOS-X driver officially doesn't support it).
>
> Also there no way to obtain DigitalIO status without spawning separate thread, which periodically request the status from device and updates mixer info. My alsa-development skill is poor, so I prefer to avoid such dangerous improvements at the moment.
>
> With Best Regards, Sergiy.
>

I do not have the hardware with me at the moment, so I cannot test this.
The information I have does talk about the stream format changing
depending on whether one is in Full-Speed or High-Speed USB mode.
The reason given for not following the USB audio standard for HS mode
is that some USB controllers are buggy and this gets round the
problem.
Regarding the capture problems:
When the device is in HS mode and the 1/2 ms transfer alternative
setting is selected. The descriptor says that the samples are of
TYPE_I_PCM.
The actual format within the TYPE_I_PCM packet is:
offset 0: size=4, Length of this packet (dwLength)
offset 4: size=dwLength - 4, packet of interleaved audio data.
So, you will have to get the first 4 bytes of each packet dropped in
order for the stream to lock like real TYPE_I_PCM.
This is a work-around for an issue seen with some EHCI hosts which for
every other packet incorrectly report the received packet length as
zero bytes to the audio driver.
Also, the first two packets of any recording should be dropped as they
contain unwanted data.
When the clock rate it changed, the alsa driver will have to also
switch to the correct USB endpoint alternate setting to match it.


Use this vendor specific command to determine which mode the EMU is in.
Input values:
bmRequestType: 0xc0   (Get)
bRequest: 0x2a: (GET_CONNECTION_SPEED)
wValue: Not used.
wIndex: Not used.
wLength: 1
Returns:
at offset 0: Size 1, Type: Number, 0 = Full-Speed, 1 = High-Speed.

Another useful one could be:
Input values:
bmRequestType: 0xc0  (Get)
bRequest: 0x01: (GET_DEVICE_INFO)
wValue: Not used.
wIndex: Not used.
wLength: 32
Returns:
Offset 0: size=4, not used, set to 0
Offset 4: size=4, FirmwareVersion,
              D31-24: Major version number
              D23-16: Minor version number
              D15-09: Build Year
              D08-05: Build Month
              D04-00: Build day
Offset 8: size=4, Hardware version
              D31-09: Set to 0
              D08-00: Hardware version
Offset 12: size=4, not used, set to 0.

Regarding the Digital IO status, the emu 0202/0404 has an interrupt
endpoint the function as per USB Audio 1.0 specification, section
3.7.1.2.
The problem being, only the 0404 uses it.

I hope this info helps.

Kind Regards

James
