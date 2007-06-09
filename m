From: LCID Fire <lcid-fire@gmx.net>
Subject: Re: Quirks device not showing up
Date: Sat, 09 Jun 2007 10:32:07 +0200
Message-ID: <466A6587.1070001@gmx.net>
References: <46506D9D.4000701@gmx.net>	<75b66ecd0705201225w5e6a7e28t7a61f000cd5e2352@mail.gmail.com>	<s5hk5v2p4az.wl%tiwai@suse.de>
	<46520655.7000402@gmx.net>	<4668715B.1020208@gmx.net>	<1181284042.2424.1194097060@webmail.messagingengine.com>	<466964F7.6040809@gmx.net>
	<75b66ecd0706081417r6a1b0ba3s879aaa9178a547e8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa0.perex.cz (Postfix) with SMTP id 9B1C224528
	for <alsa-devel@alsa-project.org>;
	Sat,  9 Jun 2007 10:32:10 +0200 (CEST)
In-Reply-To: <75b66ecd0706081417r6a1b0ba3s879aaa9178a547e8@mail.gmail.com>
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

Lee Revell wrote:
> On 6/8/07, LCID Fire <lcid-fire@gmx.net> wrote:
>> Clemens Ladisch wrote:
>>> I'd tell you what the actual problem with your quirk is, but my crystal
>>> ball is under repair just now.  Please show your code and the output of
>>> "lsusb -v" for your device.
>> It's the following:
> 
> Where's the code?
Oh, it's

{
	USB_DEVICE(0x13e5, 0x0001),
	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk)
	{
		.ifnum = QUIRK_ANY_INTERFACE,
		.type = QUIRK_AUDIO_STANDARD_INTERFACE
	}
}

added to usbquirks.h
