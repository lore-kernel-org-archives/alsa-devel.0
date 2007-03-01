From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: what criteria should be used to choose between
 snd_ac97_update_bits, snd_ac97_write, snd_ac97_write_cache ?
Date: Thu, 01 Mar 2007 09:25:40 +0100
Message-ID: <1172737540.9561.1177138781@webmail.messagingengine.com>
References: <F8FB97052F1BEF409F7842E960E49B5AAAF8BB@sea-exch-01.na.corp.dmxmusic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <F8FB97052F1BEF409F7842E960E49B5AAAF8BB@sea-exch-01.na.corp.dmxmusic.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: John Utz <John.Utz@dmxmusic.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

John Utz wrote:
> are there reasons why one might prefer one of these or the other?

Because reading AC'97 registers is rather slow, there is a cache of
register values.

Use snd_ac97_write() for registers that should not be cached.

Use snd_ac97_write_cache() to write to a register that can be cached,
i.e., later reads can take the value from the cache instead of reading
from the codec.

Use snd_ac97_update() to write to a register where writing the same
value would not have any effect.

Use snd_ac97_update_bits() in the same situation as snd_ac97_update(),
but when you want to update only some bits.

Use snd_ac97_read() for uncached reads; and snd_ac97_read_cache() for
reads from the cache, if possible.


HTH
Clemens

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
