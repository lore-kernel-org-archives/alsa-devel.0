From: Peter L Jones <peter@drealm.org.uk>
Subject: ALSA in 2.5.x
Date: Wed, 2 Oct 2002 11:17:47 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200210021117.47402@advent.drealm.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
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

Hi all,

I was wondering when we can expect an update to ALSA in the kernel source - 
we're still on -rc2, aren't we?  Now that 2.5.x is getting a little more 
useable, I'd like to start running it again (I stopped at 2.5.25 as it really 
did become too dangerous).  But I want ALSA :-)

I'm currently compiling 2.5.40 with _no sound_.  However, for some reason, 
make modules_install comes back with:

make[3]: Entering directory `/usr/src/linux-2.5/linux/sound/core/oss'
Installing modules in /lib/modules/2.5.40/kernel/sound/core/oss
cp: cannot stat `snd-mixer-oss.o': No such file or directory
cp: cannot stat `snd-pcm-oss.o': No such file or directory

I'm not up to speed on the kernel configuration language, so I've no idea 
where to start looking...  Any clues?

Ta.

-- Peter



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
