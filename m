From: Pavel Polischouk <pavelvp@inbox.ru>
Subject: snd-usb-audio and M-Audio Quattro problems.
Date: Tue, 21 Nov 2006 14:53:37 -0500
Message-ID: <45635941.70406@inbox.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi!

I'm trying to make my Quattro work with ALSA 1.0.13. While this seems 
possible with some hacks, it's not a straightforward and hassle-free 
experience.

I submitted a bug report on the matter some time ago 
(https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2607), see there 
for detailed description. Short description: Quattro initializes itself 
to an unusable (or semi-usable) state and refuses to change its mode 
afterwards.

After seeing no activity on the bug for some time I decided to 
investigate the problem further. First I tried to extend the Audiophile 
hack to Quattro (that disables all altsettings on driver init except the 
one desired). Surprisingly it worked - almost. It only works the first 
time after Quattro has been powered up, after that, re-loading the 
driver doesn't help - the device sticks to the old state.

My temporary patch is available here:
https://bugtrack.alsa-project.org/alsa-bug/file_download.php?file_id=1630&type=bug

Are there any suggestions on how to make the device accept the changing 
settings? Perhaps there's a need for hardware reset or something similar 
between mode changes? Any suggestions/patches are appreciated.

Thanks,
Pavel

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
