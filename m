From: Nitin Mahajan <nitinm76@yahoo.com>
Subject: WM9712 Not Giving output
Date: Fri, 1 Aug 2008 08:31:03 -0700 (PDT)
Message-ID: <859267.14717.qm@web50109.mail.re2.yahoo.com>
Reply-To: nitinm76@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from web50109.mail.re2.yahoo.com (web50109.mail.re2.yahoo.com
	[206.190.38.37]) by alsa0.perex.cz (Postfix) with SMTP id 3DF95243F5
	for <alsa-devel@alsa-project.org>;
	Fri,  1 Aug 2008 17:31:05 +0200 (CEST)
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
Cc: Manuel <mano@roarinelk.homelinux.net>
List-Id: alsa-devel@alsa-project.org

Hello!

I am using a WM9712 codec chip with the AC97 controller on AMD AU1250. Linux kernel version 2.6.24.2.

I have used the WM9712 codec driver from sound/soc/codecs. This I got after applying some patch available at wolfson website.

The driver comes up, Identifies the codec chip etc. While I do a playback using aplay I cannot hear anything. I probed the pin 39 of the codec chip , but nothing is coming there, how ever on the SDATAOUT of the code chip I can see the signals while I do a playback.

On AC97 controller's side, I can see the DMA happening on the host processor, interrupts also coming.

On the mixer front, I did unmute and set the vol to max for PCM and Headphone. I did not find any Master control with this chip. Isn't there any master control with this chip?
Can some one please throw more light on the Mixer part, specific to this chip. 
What Mixer controls do I need to set with what values for playback and capture respectively with this chip? 

Thanks in advance regards

-Nitin Mahajan

Send instant messages to your online friends http://uk.messenger.yahoo.com 
