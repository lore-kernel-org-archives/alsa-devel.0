From: pdq808@t-online.de (Reiner Klenk)
Subject: Delta 410 status
Date: Sun, 1 Dec 2002 17:58:47 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0212011741360.1314-100000@gin.nowhere.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Greetings,

I have been fiddling around with a Midiman Delta 410 over the weekend. I
get some sort of playback but is is severly clipped. I believe there is a
typo in ak4524.c in inits_ak4529[]. Register 0x00 should be initialized to
0x0c for i2s mode according to the data sheet (need to set DIF1 as well as
DIF0). I corrected this but that didn't help. My suspicion is that the
envy24 chip is not talking to the ak4529 at all (i.e. the control path via
the envy24 gpio is not working) since I also can't set or read the Volume
Controls with envy24control or amixer, however, the mixer elements that 
control the envy24 chip directly (routing, digital mix, meter readout) are 
all OK.

Is this what I should currently (0.9rc6) expect or is it just me? 

Thanks,
Reiner



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
