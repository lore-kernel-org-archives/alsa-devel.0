From: Mauro Sacchetto <mauro.sacchetto@alice.it>
Subject: Troubles with hda_intel
Date: Sat, 23 Sep 2006 15:19:53 +0200
Message-ID: <200609231519.53947.mauro.sacchetto@alice.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from smtp-out01.alice.it (smtp-out01.alice.it [85.33.2.12])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 15FB2236
	for <alsa-devel@alsa-project.org>;
	Sat, 23 Sep 2006 15:19:44 +0200 (MEST)
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
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I use Slackware 10.2 and current with different kernel of 2.6 branch.
I've got a Pentium 4 3200 with mobo GigaByte 8AECXPD i925XE.
In both these cases, I'm not able to shut down my pc,
but if and ONLY IF I use KDE. With other DE or if I use
only the console, it works fine. But, if I enter in KDE,
when I try to shut down my pc, I receive the message:
"Power down. Acpi_power_off called" and it's possibile
to turn the pc off only turnin' off the elettricity too.
The on/off button doesn't work.
After a lot of investigations and recompilations of kernel,
finally I discovered the cause of this trouble. The origin of all
is the module hda_intel, for my sound card. If it's disabled,
the pc shuts down correctly. If loaded, the pc doesn't halt.
I don't know if this is due to alsa modules or to KDE, but,
in any case, I've no problems If I use other DE as Fluxbox
or I work in console. So, IMHO, there must be something hurting
in the relationship between the audio management in KDE
and that module...

Thanx for your attention
Mauro Sacchetto

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
