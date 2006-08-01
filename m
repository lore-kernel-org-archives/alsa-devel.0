From: Robert Vetter <vetter@bury.com>
Subject: How to add a new module to the drivers package?
Date: Tue, 1 Aug 2006 14:46:36 +0200
Message-ID: <200608011446.36562.vetter@thb.de>
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


Hi,

I'm trying to add a new driver (for example dummy1) module to the drivers 
package. What i do is:

1. to add the module into scripts/Modules.dep

%dir linux/sound/drivers
|snd-dummy snd-pcm
|snd-dummy1 snd-pcm

2. to add the module into linux/sound/drivers/Makefile

snd-dummy1-objs := dummy1.o
obj-$(CONFIG_SND_DUMMY1) += snd-dummy1.o

3. to run cvscompile

However I get an error from make daying no rule to make target dummy1.c

do I miss something?

thank you

Robert


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
