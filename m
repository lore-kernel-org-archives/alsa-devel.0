From: =?iso-8859-1?q?Chris=20Rankin?= <rankincj@yahoo.com>
Subject: Lockup with ALSA CVS on 2.4.19 SMP, 1 GB
Date: Mon, 16 Sep 2002 22:58:34 +0100 (BST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020916215834.86476.qmail@web40602.mail.yahoo.com>
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
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

I tried reporting this a few days ago, but it seems as
if the list is currently being moderated by a tame
black hole. I have now subscribed ...

My machine run Linux 2.4.19 SMP, 1 GB memory
(Highmem), has a SB Live! card and recently locked up
completely after updating my ALSA kernel modules from
CVS. All I had done to trigger it was to try and play
a WAV file using aplay, but aplay did not even return
before the keyboard, mouse and network connection all
froze. After rebooting and fscking, I restored
memory.c to version 1.19 and wrappers.c to version
1.5, recompiled, and everything was fine again. I have
since stopped updating my CVS sources, of course.

Does anyone have hardware similar to mine (SMP +
HIGHMEM) for comparison? I haven't noticed any other
screams of pain recently, apart from ones relating to
snd_pcm_hw_params_get_format().

Chris


__________________________________________________
Do You Yahoo!?
Everything you'll ever need on one web page
from News and Sport to Email and Music Charts
http://uk.my.yahoo.com


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
