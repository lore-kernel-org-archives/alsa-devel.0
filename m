From: Peter Vollmer <remllov_@gmx.de>
Subject: ice1712, snd_pcm_mmap_readi(), POLLERR in poll_revents
Date: Fri, 16 May 2003 16:03:48 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <5.1.0.14.2.20030516153136.032daf08@pop.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
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

Hi all,

I am still trying to get the ice1712-based soundcard to work on an embedded 
platform, using alsa driver/lib 0.9.3
While capturing works for hw:0,0 (multitrack mode) using snd_pcm_readi(), I 
get an -EIO when capturing with snd_pcm_mmap_readi(), immediatly after the 
buffer is filled up with 4 periods.
I tracked the problem down to the snd_read_areas() function, where 
snd_pcm_wait(pcm,-1) returns -EIO (detection of POLLERR in revents), 
waiting for the soundcard to become ready.

Do you have any idea where to start debugging in the driver from this point ?

Thanks for your help,

Peter



-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
