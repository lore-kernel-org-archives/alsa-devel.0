From: Tim Blechmann <TimBlechmann@gmx.net>
Subject: SOLVED: snd-hdsp+cardbus=distortion
Date: Wed, 5 May 2004 11:20:50 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040505112050.44a264fe@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: linux-pcmcia@lists.infradead.org, linux-audio-user@music.columbia.edu, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

hi all,

both ico and myself were able to solve our problems with the hdsp and
the cardbus interface:

ene1410 cardbus bridge (ico): 
ico had to enable "Memory read burst enable upstream" and "TLTEnable" on
his cardbus bridge. the fix for that was added to the kernel's pcmcia
subsystem and is probably released in one of the following releases.

o2micro 6933 (myself):
i had to enable "read prefetching" on my cardbus bridge, a flag that
windows didn't need to run the hdsp, but the systems seem to be quite
different (thanks to eric still from o2micro for this hint)
there is no kernel fix for that, yet, but i suppose the kernel guys will
write one pretty quick...

ti pci1250 (timothy):
the problem with this cardbus bridge isn't solved, yet ... anyway, i
suppose that after solving the problems with the 2 cardbus bridges, it's
probably much easyer to solve this...

if someone experiences the same problem as we had on any cardbus bridge,
this problem seems to be fixable ... 
the way to go is, find out as much as you can about your cardbus bridge
(not very easy in some cases), send a report to the kernel maintainers
of the pcmcia subsystem (linux-pcmcia@lists.infradead.org), they should
be able to fix that...

anyway, thanks a lot to all the guys who helped me ...

 Tim                          mailto:TimBlechmann@gmx.de
                              ICQ: 96771783
--
The only people for me are the mad ones, the ones who are mad to live,
mad to talk, mad to be saved, desirous of everything at the same time,
the ones who never yawn or say a commonplace thing, but burn, burn,
burn, like fabulous yellow roman candles exploding like spiders across
the stars and in the middle you see the blue centerlight pop and
everybody goes "Awww!"
                                                          Jack Kerouac



-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
