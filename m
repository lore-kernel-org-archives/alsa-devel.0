From: "Dustin Kerstein" <dustobub@gmail.com>
Subject: Re: HDMI Multichannel LPCM/RAW Support/Status
Date: Wed, 27 Feb 2008 12:13:45 -0500
Message-ID: <001701c87964$1ee14770$5ca3d650$@com>
References: <001201c878e6$0a8245a0$1f86d0e0$@com>
	<s5hwsoqs79i.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.169])
	by alsa0.perex.cz (Postfix) with ESMTP id 75A482415D
	for <alsa-devel@alsa-project.org>; Wed, 27 Feb 2008 18:13:52 +0100 (CET)
Received: by wf-out-1314.google.com with SMTP id 25so3123071wfa.23
	for <alsa-devel@alsa-project.org>; Wed, 27 Feb 2008 09:13:50 -0800 (PST)
In-Reply-To: <s5hwsoqs79i.wl%tiwai@suse.de>
Content-Language: en-us
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

I'd possibly be willing to temporarily donate hardware for you to play with.
If I sent you a Asus P5E-VM that has the G35 chipset would you have the
other necessary hardware to test it with, ie. receiver with HDMI audio
input, cpu, ram, etc? Otherwise, what kind of technical details would you be
looking for, I could help test, but I am not a programmer. Thanks.

-----Original Message-----
From: Takashi Iwai [mailto:tiwai@suse.de] 
Sent: Wednesday, February 27, 2008 11:18 AM
To: Dustin Kerstein
Cc: alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] HDMI Multichannel LPCM/RAW Support/Status

At Tue, 26 Feb 2008 21:11:17 -0500,
Dustin Kerstein wrote:
>
> I was just curious if there is any planned support for multichannel
LPCM/Raw
> audio for newer HDMI based chipsets. There are several matx boards with
HDMI
> 1.1 and above compliance, which means they should be able to pass
8-channel
> LPCM audio. Also, in HDMI 1.3 and above, Bit Stream passing is supported,
> which actually should be easier, bandwidth wise, than LPCM. Multichannel
PCM
> (above 2 channels) was never an issue because SPDIF lacked the bandwidth.
> After talking with some people in irc it seems as though the # of channels
> setting in Alsa is only one bit. Thanks.

Well, I have no plan yet because I have no such a hardware...

I'm willing to help implementation if you can give any pointers for
technical details.


Takashi
