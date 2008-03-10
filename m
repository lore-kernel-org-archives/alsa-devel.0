From: James Courtier-Dutton <James@superbug.co.uk>
Subject: X-Fi support in ALSA.
Date: Mon, 10 Mar 2008 20:20:48 +0000
Message-ID: <47D59820.9020106@superbug.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from anchor-post-35.mail.demon.net (anchor-post-35.mail.demon.net
	[194.217.242.85])
	by alsa0.perex.cz (Postfix) with ESMTP id C793A10381E
	for <alsa-devel@alsa-project.org>; Mon, 10 Mar 2008 21:20:52 +0100 (CET)
Received: from superbug.demon.co.uk ([80.176.146.252] helo=[192.168.0.10])
	by anchor-post-35.mail.demon.net with esmtp (Exim 4.67)
	id 1JYoUO-000Dwg-H1
	for alsa-devel@alsa-project.org; Mon, 10 Mar 2008 20:20:52 +0000
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

Hi,

I have now had a chance to read some of the specs of the X-Fi cards. 
aka. emu20k1.
It turns out that some of the X-Fi cards have a compatibility mode.
By default, they boot up in compatibility mode.
The interesting point is that this "compatibility mode" is in fact the 
intel-HD standard so could use the intel-hda driver.
For one X-Fi card with IDs:
Device 1102:0009 Subsystem: 1102:0010
works a bit with the ALSA hda-intel driver.
So far, the off the shelf hda-intel driver, with simple PCIs adjustment, 
works for the above card, but only sound capture works so far, so 
probably some quirk would be needed.
This compatibility mode works with the Windows Vista UAA drivers.

Not all X-Fi cards support with compatibility mode. For example, any 
card with (after a cold boot into Linux)
Device 1102:0005 Subsystem: xxxx:xxxx
will be X-Fi only.

With regard to actual full X-Fi support, I am still in the progress of 
creating a GPL emu20k1.h file, that is the first step towards an 
snd-emu20k1 native ALSA driver.

James
