From: phiber@juniper.slackwaresupport.com
Subject: hda-intel
Date: Sun, 5 Jun 2005 19:42:22 -0500
Message-ID: <20050606004222.GB19608@juniper.slackwaresupport.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

having a problem with a card. it used to work fine.
its driver is hda-intel
heres the error

/lib/modules/2.4.29/kernel/sound/acore/snd.o: /lib/modules/2.4.29/kernel/sound/acore/snd.o: unresolved symbol class_device_destroy
/lib/modules/2.4.29/kernel/sound/acore/snd.o: /lib/modules/2.4.29/kernel/sound/acore/snd.o: unresolved symbol class_device_create
/lib/modules/2.4.29/kernel/sound/acore/snd.o: insmod /lib/modules/2.4.29/kernel/sound/acore/snd.o failed
/lib/modules/2.4.29/kernel/sound/acore/snd.o: insmod snd failed


driver 1.0.9a


any ideas?

chris.
-- 
    .~.
    /V\
   /( )\
   ^^-^^

A good Linux operating system distribution makes a great computer-related Christmas gift, winter-holiday gift, or any-occasion gift. If you do not have Linux already, give it to yourself. Give Linux to friends, relatives, and others on your gift lists that do not already have Linux. If you or the people to whom you give gifts already have Linux, give them a Linux upgrade gift. Linux is a great gift idea.


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
