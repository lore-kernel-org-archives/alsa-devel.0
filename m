From: Shaju Abraham <shaju@multitech.co.in>
Subject: ALSA in realtime linux
Date: Tue, 16 Jul 2002 15:04:50 +0530
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D33E8BA.A8188C21@multitech.co.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: linux-audio-user@music.columbia.edu, ardour-dev <ardour-dev@lists.sourceforge.net>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi all,
         I am trying to port ALSA code to rtlinux. I am doing it on a
intel810 chipset(built in sound card)  and linux kernel version is 2.4.4
with rt 3.1 patch.

The way we are going abt it is that we are registering the sound card
interrupt with rtlinux instead of linux.
We have also changed a few systems calls from linux to the corresponding
ones available in rtlinux.

Present status is that the driver works i.e plays a mp3 song of 4 min
length abt once in 5 times. while the other times it crashes.  In the
crashes what we have observed is that we get a debug msg - DMA OR IRQ
problem(pcm_lib.c).
1   Can anyone pls explain under what circumstances this will happen and
the work around if any.

2.  We suspect that this could be because of a call --
interruptible_sleep_on_timeout --  Is there any corresponding piece of
code that will do the same job in rtlinux?

Any suggesstions are welcome,
Shaju



-------------------------------------------------------
This sf.net email is sponsored by: Jabber - The world's fastest growing 
real-time communications platform! Don't just IM. Build it in! 
http://www.jabber.com/osdn/xim
