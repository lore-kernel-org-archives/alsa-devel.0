From: Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: current cvs, unresolved symbol in snd-msnd-pinnacle.o
Date: Fri, 19 Jul 2002 10:19:48 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200207191719.KAA16411@cmn29.stanford.edu>
References: <200207191323.g6JDNOLL077610@smtpzilla1.xs4all.nl>
Mime-Version: 1.0 (NeXT Mail 3.3 v148.2.1)
Content-Type: text/plain
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200207191323.g6JDNOLL077610@smtpzilla1.xs4all.nl>
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

Found this last evening, just confirmed it is still there:

# depmod -ae
depmod: *** Unresolved symbols in  
/lib/modules/2.4.18-11.ll/kernel/drivers/sound/isa/msnd/snd-msnd-pinnacle.o
depmod: 	vfree

-- Fernando


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
