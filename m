From: Shaw Terwilliger <sterwill@sourcegear.com>
Subject: Intel HDA on Mac Pro
Date: Mon, 04 Dec 2006 14:34:53 -0600
Message-ID: <4574866D.5070506@sourcegear.com>
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

I just got a new Mac Pro (not MacBook Pro) that appears to contain an
on-board Intel High Definition Audio interface (Realtek variation, as
far as I can tell via "detect" debug).  The ALSA drivers in 2.6.17
detect the card correctly and my mixer shows all the right channels, but
no sound comes out.  I compiled and installed the latest ALSA (1.0.13)
and have the same issue.  I have only found a few others running Linux
on the Mac Pro, and they seem to have the same issue.

Other people have reported the MacBook Pro had similar issues (no sound
out the line-out jack), and a patch was floating around that rewired
some of the mixing to make it work.  The MacBook Pro seems to use a
different HDA implementation (Sigmatel, I think) so I'm not sure if the
patch logic makes sense on the Mac Pro.

I figured this list was probably the best place to ask: has anyone
hacked on this driver before?  Where should I start digging?

-- 
Shaw Terwilliger <sterwill@sourcegear.com>
SourceGear LLC

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
