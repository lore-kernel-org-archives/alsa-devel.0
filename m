From: "Ivica Bukvic" <ico@fuse.net>
Subject: Midisport 2x2 spawns before Alsa, taking the device0 slot event though modules.conf puts snd-usb-midi as 3rd device -> result potential hardlocks when opening dsp
Date: Tue, 25 Feb 2003 18:25:53 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <000001c2dd25$3d7d5e70$aa1f830a@ICO>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
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
To: alsa-devel@lists.sourceforge.net, alsa-user@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi all,

I was just wondering how can I force snd-usb-midi to assume device 2
slot, rather than the default 0 when spawning, since at boot time on my
machine USB gets initialized before alsa and therefore if I have
Midisport 2x2 hooked up, it ends up being my default /dev/dsp device
(which actually does not exist) and that makes apps like pd hardlock my
machine if trying to access them.

So my question is twofold:

1) Is there anything I can configure about my boot process, where Alsa
gets initialized before USB (I am assuming not, since Alsa does not
start until someone logs in, please correct me if I am wrong).

2) Is there anything I can specify in my modules.conf or elsewhere in
order to force the device to be used as snd-card-2 and not snd-card-0 (1
I would like to reserve for hdsp).

Obviously the quick and dirty fix is to hook-up the midisport once I've
logged in and if the device was already hooked-up simply restart alsa
once the midisport was removed (which I am doing), but that seems like a
real hacky solution to this issue and does not address the root of the
problem.

Any help is greatly appreciated! Sincerely,


Ivica Ico Bukvic, composer, multimedia sculptor,
programmer, webmaster & computer consultant 
http://meowing.ccm.uc.edu/~ico 
============================ 
"To be or not to be" - Shakespeare
"To be is to do"     - Socrates
"To do is to be"     - Sartre
"Do be do be do"     - Sinatra
"2b || ! 2b"         - ?
"I am"               - God




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
