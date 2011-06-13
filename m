From: Adrien Plisson <aplisson+music@stochastique.net>
Subject: Re: icon utrack pro usb audio interface
Date: Mon, 13 Jun 2011 16:21:28 +0200
Message-ID: <4DF61CE8.9000202@stochastique.net>
References: <4DF356F0.6010701@stochastique.net>
Reply-To: aplisson+music@stochastique.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from 97.mail-out.ovh.net (13.97.mail-out.ovh.net [87.98.173.128])
	by alsa0.perex.cz (Postfix) with ESMTP id D6BDB10386E
	for <alsa-devel@alsa-project.org>;
	Mon, 13 Jun 2011 16:21:37 +0200 (CEST)
Received: from mail420.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by 97.mail-out.ovh.net (Postfix) with SMTP id 4C16C4C2FB9
	for <alsa-devel@alsa-project.org>;
	Mon, 13 Jun 2011 16:22:31 +0200 (CEST)
In-Reply-To: <4DF356F0.6010701@stochastique.net>
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

On 06/11/2011 01:52 PM, Adrien Plisson wrote:
>it seems that the
> firewire interface uses the bridgeco BeBoB chipset. given that some
> versions of BeBoB supports both firewire and usb, i suppose (but i may
> be wrong) that the "utrack pro" is also based on BeBoB.

upon further investigation (involving a screwdriver), the icon utrack 
pro usb audio interface does not use a bridgeco bebob chipset: it uses a 
xilinx spartan3 fpga and a cypress CY7C68013A-100AXC EZ-USB FX2LP usb 
microcontroller.

i fear that i need to write a specific module to support this 
hardware... any advice before i start ?

regards,

-- 
rien
