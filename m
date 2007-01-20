From: Sami Farin <safari-alsa@safari.iki.fi>
Subject: xmms and ALSA + snd_pcm_status
Date: Sun, 21 Jan 2007 00:04:00 +0200
Message-ID: <20070120220400.GA19215@m.safari.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
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

Little problem with xmms and the ALSA output plugin...
every now and then xmms hangs in snd_pcm_status().
I added g_warning before and after snd_pcm_status() and
when xmms hangs, snd_pcm_status() does not finish.
When I cause xrun by e.g. pressing ^C, xmms recovers
from it, at least for most of the time.

Extra tricks I could try?
I have tried with and without mmap, with alsa-lib
1.0.13, 1.0.14rc1 and 1.0.14rc2.
Redhat Fedora and glibc-2.5-8.fc6... what else do you need to know?

-- 
Do what you love because life is too short for anything else.


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
