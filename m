From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: No mixers on ATI RS780 Azalia
Date: Thu, 27 May 2010 16:55:34 +0200
Message-ID: <4BFE87E6.7080701@ladisch.de>
References: <alpine.LSU.2.01.1005261303170.19406@obet.zrqbmnf.qr>	<s5hmxvmzwwd.wl%tiwai@suse.de>	<alpine.LSU.2.01.1005261413040.23865@obet.zrqbmnf.qr>	<4BFD2901.20800@ladisch.de>	<alpine.LSU.2.01.1005271230340.18087@obet.zrqbmnf.qr>	<4BFE5AA1.7070103@ladisch.de>
	<alpine.LSU.2.01.1005271420320.29122@obet.zrqbmnf.qr>
	<4BFE8404.2000005@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 3C395103A63
	for <alsa-devel@alsa-project.org>;
	Thu, 27 May 2010 16:55:38 +0200 (CEST)
In-Reply-To: <4BFE8404.2000005@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jan Engelhardt <jengelh@medozas.de>
List-Id: alsa-devel@alsa-project.org

Robert Hancock wrote:
> On 05/27/2010 06:34 AM, Jan Engelhardt wrote:
>> On Thursday 2010-05-27 13:42, Clemens Ladisch wrote:
>>> It is possible that an embedded device like this requires some custom
>>> initialization.  Can you find out if the Windows driver is the standard
>>> Microsoft driver or Samsung's?
>>
>> Looks like the Microsoft one:
> 
> Well, not Samsung, but it's not the Microsoft HDA driver either, it's 
> using a Realtek driver.
> 
>> == "ATI HDMI Audio" ==
>> ...
>> C:\WINDOWS\system32\drivers\RtHDMI.sys
>> 	Realtek, 5.10.0.5602 built by WinDDK

Googling shows that this is the driver that AMD ships for its "ATI HDMI"
devices.

>> == "Realtek High Definition Audio" ==
>> ...

This also looks like the standard driver.


Apparently, this computer uses standard audio hardware; the culprit is
probably the Linux radeon driver.


Regards,
Clemens
