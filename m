From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: Re: aplay won't play on any second sound card
Date: Sat, 13 Jul 2002 00:02:18 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D2EEF7A.3020406@boosthardware.com>
References: <m3adoyr6pr.fsf@ccs.covici.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
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
To: John Covici <covici@ccs.covici.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

John Covici wrote:
> Using the rc2 aplay, it doesn't honor -c 1 at all, just plays on card
> 0.  I even changed the aliases around so what was card1 is now 0, but
> aplay still only plays on card 0.
> 

aplay -D hw:0,0 --> card 0 device 0

aplay -D hw:1,0 --> card 1 device 0 etc...

-d is for duration of play.

-- 
Patrick Shirkey - Boost Hardware Ltd.
For the discerning hardware connoisseur
Http://www.boosthardware.com
Http://www.boosthardware.com/LAU/guide/
========================================



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Gadgets, caffeine, t-shirts, fun stuff.
http://thinkgeek.com/sf
