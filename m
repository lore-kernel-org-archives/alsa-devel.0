From: James Courtier-Dutton <James@superbug.co.uk>
Subject: TODO list
Date: Thu, 25 May 2006 19:10:30 +0100
Message-ID: <4475F316.5000908@superbug.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from anchor-post-35.mail.demon.net (anchor-post-35.mail.demon.net [194.217.242.85])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 1EB9817C
	for <alsa-devel@alsa-project.org>; Thu, 25 May 2006 20:10:32 +0200 (MEST)
Received: from superbug.demon.co.uk ([80.176.146.252] helo=[127.0.0.1])
	by anchor-post-35.mail.demon.net with esmtp (Exim 4.42)
	id 1FjKI3-000Jdn-GV
	for alsa-devel@alsa-project.org; Thu, 25 May 2006 18:10:31 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

I was wondering what the current TODO list is for ALSA. The current one 
in alsa-driver hg seems somewhat out of date.
My list has the following, in no particular order:
1) Finish reverse engineering some sound cards (e.g. Creative EMU1212M)
2) Implement needed features on some already reverse engineered cards. 
e.g. The Creative Audigy PCMCIA.
3) Add dB gain architecture.
4) Improve dmix, specifically for 44.1 kHz and games like Doom3. Perhaps 
using the system clock, adjusted to match the sound card hardware clock, 
to provide accurate sample timing, at multiple different sample rates, 
irrespective of the rate the sound card runs at.
5) Perhaps use the system clock to help resample so that user space sees 
a single sample rate clock, but let alsa-lib automatically adjust for 
the different clocks of different sound cards.
6) Think of some way to simplify the mixer interface for user space 
mixers. Surely, it does not have to be so complex as it currently is?
7) Provide better OSS emulation support. E.g. redirect all access to 
/dev/dsp into user space so it can use all the features of alsa-lib 
without needing aoss. (aoss does not work if the application uses 
dynamically linked audio driver plugins.






-------------------------------------------------------
All the advantages of Linux Managed Hosting--Without the Cost and Risk!
Fully trained technicians. The highest number of Red Hat certifications in
the hosting industry. Fanatical Support. Click to learn more
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=107521&bid=248729&dat=121642
