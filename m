From: David van Hoose <davidvh@cox.net>
Subject: ALSA 0.9.3+ is not working
Date: Mon, 02 Jun 2003 02:37:05 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3EDAF091.1080105@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello.

Sound card is onboard SiS7012 AC'97 (CMI9739A)
Running kernel 2.4.21-rc6 and 2.5.70-bk6.

ALSA History for 2.4.x:
0.9.2 works perfectly.
0.9.3 locks up. Unusable.
0.9.3a Sound through CD-ROM (Plays CDs) No sound through OSS apps. 
0.9.3b Sound through CD-ROM (Plays CDs) No sound through OSS apps.
0.9.3c Sound through CD-ROM (Plays CDs) No sound through OSS apps.
0.9.4 Sound through CD-ROM (Plays CDs) No sound through OSS apps.

I have had the same problem with no sound in OSS apps under the last few 
2.5.x kernels as well.

I've configured '--with-debug=full', but the only line I ever get is the 
load line for the intel8x0 clocking at 48000.
Can someone please work with me here to figure out why this problem is 
occuring? As I have 0.9.2 working under 2.4.21-rc6, I'm assuming I have 
something set up right. If the setup has changed, then tell me what I 
need to do to fix this. I've seen no documentation changes.

Thank you,
David



-------------------------------------------------------
This SF.net email is sponsored by: eBay
Get office equipment for less on eBay!
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
