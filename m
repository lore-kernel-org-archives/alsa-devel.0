From: Pavel Hofman <pavel.hofman@ivitera.com>
Subject: Re: snd-usb-audio probe problem (Teac UD-H01)
Date: Mon, 02 Apr 2012 09:44:32 +0200
Message-ID: <4F7958E0.3010807@ivitera.com>
References: <4F774ABE.6070905@circa.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cable.insite.cz (static-84-242-75-189.net.upcbroadband.cz
	[84.242.75.189]) by alsa0.perex.cz (Postfix) with ESMTP id E4556243B5
	for <alsa-devel@alsa-project.org>;
	Mon,  2 Apr 2012 09:44:25 +0200 (CEST)
In-Reply-To: <4F774ABE.6070905@circa.be>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: bEN <ml_all@circa.be>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Dne 31.3.2012 20:19, bEN napsal(a):
> Hi all,
> 
> the new USB DAC from Teac seems detected as 'Human Interface Device'
> instead of 'Audio'. Despite the fact it is based on a standard USB Audio
> class v2 controller (Tenor 8802).
> 
> Below is dmesg and lsusb outputs.
> 

Hi, the lsusb shows both HID interface (button?) and audio interface
beneath.

Pavel.
