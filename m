From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Info needed for creative SB 0220 with STAC9758 codec, to get the
 REAR channels working.
Date: Sun, 02 May 2004 18:00:55 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <40953757.2080800@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from anchor-post-35.mail.demon.net (anchor-post-35.mail.demon.net [194.217.242.85])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id UAA30001
	for <alsa-devel@alsa-project.org>; Sun, 2 May 2004 20:02:33 +0200
Received: from superbug.demon.co.uk ([80.176.146.252])
	by anchor-post-35.mail.demon.net with esmtp (Exim 3.35 #1)
	id 1BKLIN-0004hG-0Z
	for alsa-devel@alsa-project.org; Sun, 02 May 2004 19:02:31 +0100
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Just for everyone's information.
I now have all the info I need to get the Rear channel working.
I thank Voluspa for giving me ssh root access so that I could find out 
the details via trial and error.

But the summary is: -
This tells the emu10k1 chip which slots to fill on the AC-LINK between 
the emu10k1 and the stac9758.
snd_emu10k1_ptr_write(emu, AC97SLOT, 0, XXX);

Where XXX is:
/* bit 0 is AC97SLOT_REAR_LEFT
  * bit 1 is AC97SLOT_REAR_RIGHT
  * bit 2 is Unknown, Maybe spdif. Not tested.
  * bit 3 is Unknown, Maybe spdif. Not tested.
  * bit 4 is AC97SLOT_CNTR
  * bit 5 is AC97SLOT_LFE
  */
So, for the stac9758, we would set XXX to  0x33

DSP code: -
OP(icode, &ptr, iACC3, EXTOUT(13)...   <- Rear Left
OP(icode, &ptr, iACC3, EXTOUT(14)...   <- Rear Right

Cheers
James


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
