From: <ico@fuse.net>
Subject: Takashi, the via82xx patch I gave you is wrong!
Date: Mon, 3 May 2004 4:49:46 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040503044946.PJKE5923.smtp2.fuse.net@smtp.fuse.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net, tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

Just realized that the dxs stuff needs to remain 3 (48k-only) after all for my notebook (m680x), otherwise I get evil xruns just using aplay -> soundcard setup. My testing was flawed due to use of the new modprobe.conf. Hence, the patch should use the same vendor id/device id, but the setup should be 3 (48k-only).

Sorry for the confusion!

P.S. Not sure whether I got the right e-mail address so I am also forwarding this to the alsa-devel list.

Best wishes,

Ico



-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
