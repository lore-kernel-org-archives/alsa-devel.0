From: Huw Hawkins <huwrh@yahoo.com.au>
Subject: HDA Intel - Activating S/PDIF output on an HP laptop
	(8510W).
Date: Sat, 15 May 2010 19:03:47 +1000
Message-ID: <201005151903.49953.huwrh@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.internode.on.net (bld-mail18.adl2.internode.on.net
	[150.101.137.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 45CBF245A5
	for <alsa-devel@alsa-project.org>;
	Sat, 15 May 2010 11:03:54 +0200 (CEST)
Received: from 8510w.localnet (unverified [118.209.145.20])
	by mail.internode.on.net (SurgeMail 3.8f2) with ESMTP id
	24286717-1927428
	for <alsa-devel@alsa-project.org>; Sat, 15 May 2010 18:33:51 +0930 (CST)
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

Hi all,
   I have been quite happily using the intel HDA drivers to get audio on my 
Compaq 8510W, everything works fine out of the box with the exception of the 
HDMI output.

After some poking around I see that this is because the digital output is 
disabled by the HP model specific code.

Setting the model as "basic" gives me perfect audio on the HDMI output, but 
jack sensing is completely messed up, the mute button status is inverted and 
it is not possible to get sound from the internal speakers. Setting the model 
as "HP" diables the digital audio on the HDMI port.

It seems from a google search that there are a few people around with the same 
issue on HP laptops with HDMI output. I don't really have the time to dig 
through and understand the spec/code for the driver to try to fix the problem 
myself. On the other hand I probably could spend an hour or two over the next 
couple of weeks testing or investigating the hardware if someone else wants to 
have a go. 

Any takers?

Huw
