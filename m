From: =?iso-8859-1?q?Chris=20Rankin?= <rankincj@yahoo.com>
Subject: snd-pcm-oss.o needs snd_pcm_link_lock symbol
Date: Sat, 26 Apr 2003 15:39:20 +0100 (BST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030426143920.4910.qmail@web40613.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
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

Hi,

I have just installed the latest CVS and have
discovered that the snd-pcm-oss module needs the
snd_pcm_link_lock symbol. This is presumably because
the pcm_oss.c file includes pcm.h and uses its
snd_pcm_stream_*() functions.

Chris


__________________________________________________
Yahoo! Plus
For a better Internet experience
http://www.yahoo.co.uk/btoffer


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
