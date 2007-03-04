From: "John Pierce" <john.j35@gmail.com>
Subject: Willing to help!
Date: Sat, 3 Mar 2007 19:09:32 -0600
Message-ID: <aa73b9a0703031709p6cebaf84nc27c34a645548e9d@mail.gmail.com>
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

Hello list, I am not sure where to post this so here goes.

I just purchased an HP DV9208NR laptop, I installed opensuse 10.2 and
all worked well except the headphones.  All of the buttons on the
machine worked, including the mute button.   However, when I plugged
in my headphones the speakers would not mute and no sound came from
the headphones.

In an attempt to fix this, I searched the lists and found another
users experiences and noticed the following snippet.

Also some know issues : When headphones are plugged , laptop speakers dont mute.
============New Patch Released 01/30/2007 T.Davis Alsa-Users List ==========
!!Backup your current drivers with following command !!
tar -zcvf original-drivers.tgz /lib/modules/`uname -r`/kernel/sound

Now, get the latest release, apply the patch, and build.

wget ftp://ftp.alsa-project.org/pub/driver/alsa-driver-1.0.14rc2.tar.bz2
tar -jxf alsa-driver-1.0.14rc2.tar.bz2
cd alsa-driver-1.0.14rc2/alsa-kernel
patch -p1
cd ..
./configure --with-debug=detect --with-cards=hda-intel
make ; make install

I downloaded the current 1.0.14rc2 and went through the motions of
configuring, making and make installing.  I removed the modules from
my original install and then modprobed the snd_hda_intel and now when
I plug in the headphones they work correctly, that is the speakers
stop and the headphones start.

Now the problem, the mute button above the keyboard that used to stay
blue, and would mute the sound to the speakers, now has changed to
orange and will not mute any sound.

I am willing to help the developers debug this if any wish to contact
me and tell me what they need me to do.

It wouldn't be the first time I trashed a system and then put it back together.

Thanks for all of your work.



-- 
John
Registered Linux User 263680, get counted at
http://counter.li.org

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
