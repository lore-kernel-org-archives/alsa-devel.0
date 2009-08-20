From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Nvidia MSI Geforce 9500
Date: Thu, 20 Aug 2009 08:53:47 +0200
Message-ID: <4A8CF2FB.1030200@ladisch.de>
References: <20090819200036.GA12401@csy.ca> <20090819212902.GA5748@csy.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 990FA243D4
	for <alsa-devel@alsa-project.org>;
	Thu, 20 Aug 2009 08:53:31 +0200 (CEST)
In-Reply-To: <20090819212902.GA5748@csy.ca>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Shane W <shane-alsa@csy.ca>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Shane W wrote:
> think this might belong on the devel list. After some
> searching, looks like my Geforce 9500 card is not
> recognized by the hda_intel driver. I tried adding:
> { PCI_DEVICE(0x10de, 0x0640), .driver_data = AZX_DRIVER_NVIDIA },
> 
>> lspci -vvv:
>> 01:00.0 VGA compatible controller: nVidia Corporation G96 [GeForce 9500 GT]
>> (rev a1) (prog-if 00 [VGA controller])

This PCI ID is for the video part; the HDMI interface should have a
second entry in the lspci output.


HTH
Clemens
