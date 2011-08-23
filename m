From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: How to add a new MIDI device to the usbaudio driver
Date: Tue, 23 Aug 2011 11:38:44 +0200
Message-ID: <4E537524.9010303@ladisch.de>
References: <4E5234F0.8000502@amlie.name>	<CACTFLAMA08qqaNALA1dksxVN_yAwXnONxXadeuUb1Owkz6VwsA@mail.gmail.com>
	<4E52401C.8030605@amlie.name>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 287601038FE
	for <alsa-devel@alsa-project.org>;
	Tue, 23 Aug 2011 11:38:44 +0200 (CEST)
In-Reply-To: <4E52401C.8030605@amlie.name>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kristian Amlie <kristian@amlie.name>
Cc: alsa-devel@alsa-project.org, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

Kristian Amlie wrote:
>   idVendor           0x0403 Future Technology Devices International, Ltd
>   idProduct          0xb8d8

There is a kernel driver for this chipset; try
"modprobe ftdi_sio product=0xb8d8".  This will give you a serial port
which you can try to configure for the correct baud rate and see whether
MIDI bytes come out.  (There is currently no mechanism to make a MIDI
device from such a serial port; this would require extending or creating
a driver.)


Regards,
Clemens
