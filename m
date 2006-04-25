From: Allan Klinbail <allan_k@dodo.com.au>
Subject: tip for MOTU  MIDI users  - 64bit lockups workaround/fix
Date: Tue, 25 Apr 2006 18:25:59 +1000
Message-ID: <1145953559.9892.7.camel@daw.littlewolf>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-user-admin@lists.sourceforge.net>
Sender: alsa-user-admin@lists.sourceforge.net
Errors-To: alsa-user-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-user>
To: alsa-user@lists.sourceforge.net
Cc: Alsa-dev <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi All 

I don't know why this works but I thought I better share it. 
Up until today I haven't been able to get my MOTU MTP-AV to work
correctly in 64-bit linux. The entire PC would lock up as soon as it was
accessed... .

In the driver options instead of pointing it to IRQ 5, as that is how my
motherboard is set, I pointed it to IRQ 3.This was done out of confusion
between DMA and IRQ number, not deliberately.  Ironically, it now works.

I haven't completely tested the timing but the  MIDI messages are being
sent to the right port at what seems to be the right time.. 

cheers 	
 
-- 
Allan Klinbail <allan_k@dodo.com.au>



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
