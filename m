From: Cesar Hernandez <chernandez@genos.es>
Subject: note on /off at same time
Date: Tue, 26 Jul 2005 18:51:43 +0200
Message-ID: <1122396703.2224.63.camel@tordera.genos.intranet>
Reply-To: chernandez@genos.es
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from genos.genos.es (7.red-62-57-110.user.auna.net [62.57.110.7])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id 5C7AF1C1
	for <alsa-devel@alsa-project.org>; Tue, 26 Jul 2005 18:51:44 +0200 (MEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi.
I have some questions about sending noteon and noteoff events. 
-If I first send a noteon and then a noteoff to the same channel, note,
and timetick, what happens? Will the note play? I've been playing with
this and I can't hear anything... but using aseqview it seems to play a
very short note. If I send first the noteoff and then noteon, what
happens?

-If I send two noteon with the same timetick, channel and note, will it
play only one note? And then, must I send two noteoff to stop them ? Or
it's only needed one noteon?

Thanks


-- 
Cesar Hernandez
chernandez@genos.es
Genos Open Source S.L.
Tarragona, 100. 08015 Barcelona
Tel. 932 282 231

http://genos.es
http://www.genos.org



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
