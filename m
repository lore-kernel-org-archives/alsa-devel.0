From: Raymond <rayau@netvigator.com>
Subject: unresolved symbol class_device_destroy, class_device_create - alsa-driver-1.0.9a
 on kernel 2.4
Date: Sun, 05 Jun 2005 19:39:18 +0800
Message-ID: <42A2E466.3080507@netvigator.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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

alsa-driver-1.0.9a compile ok on kernel 2.4.22-1.2199

Are there any patch to fix the unresolved symbol ?


/etc/init.d/alsasound start
Starting sound driver: snd-au8830 
/lib/modules/2.4.22-1.2199.nptl/kernel/sound/acore/snd.o: unresolved 
symbol class_device_destroy
/lib/modules/2.4.22-1.2199.nptl/kernel/sound/acore/snd.o: unresolved 
symbol class_device_create
/lib/modules/2.4.22-1.2199.nptl/kernel/sound/acore/snd.o: insmod 
/lib/modules/2.4.22-1.2199.nptl/kernel/sound/acore/snd.o failed
/lib/modules/2.4.22-1.2199.nptl/kernel/sound/acore/snd.o: insmod 
snd-au8830 failed
done



-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
