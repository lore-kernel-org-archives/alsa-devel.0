From: matt yee-king <yeeking@no-future.com>
Subject: modprobe of snd-powermac fails
Date: 26 Apr 2002 12:46:11 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1019825181.790.13.camel@bennyhill.belmont>
References: <20020426111845.5195036F9@sitemail.everyone.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20020426111845.5195036F9@sitemail.everyone.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello i just built alsa0.9rc1 on my revA tibook (tumbler card i think)

i configured like this:

__________

./configure --with-sequencer=yes --with-oss=yes --with-isapnp=no
--with-cards=powermac, virmidi

__________

modules.conf looks like this:

___________

# ALSA portion
alias snd-card-0 snd-powermac
alias char-major-116 snd

# OSS/Free portion
alias sound-slot-0 snd-card-0
alias char-major-14 soundcore
alias sound-service-0-0 snd-mixer-oss
alias sound-service-0-1 snd-seq-oss
alias sound-service-0-3 snd-pcm-oss
alias sound-service-0-8 snd-seq-oss
alias sound-service-0-12 snd-pcm-oss

_______________

modprobe snd-powermac output this:

_______________

/lib/modules/2.4.19-pre6-ben0/kernel/sound/ppc/snd-powermac.o:
unresolved symbol udelay
/lib/modules/2.4.19-pre6-ben0/kernel/sound/ppc/snd-powermac.o: insmod
/lib/modules/2.4.19-pre6-ben0/kernel/sound/ppc/snd-powermac.o failed
/lib/modules/2.4.19-pre6-ben0/kernel/sound/ppc/snd-powermac.o: insmod
snd-powermac failed

____________________

:(

please can someone help becaouse i got _really_  excited since this is
the first version of alsa thats built on my machine so far!

cheers

matthew
