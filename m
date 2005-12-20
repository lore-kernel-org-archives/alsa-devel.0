From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: 2.6.15-rc6: boot failure in saa7134-alsa.c
Date: Tue, 20 Dec 2005 17:17:47 -0500
Message-ID: <1135117067.27101.5.camel@mindpipe>
References: <Pine.LNX.4.64.0512181641580.4827@g5.osdl.org>
	 <20051220131810.GB6789@stusta.de>
	 <20051220155216.GA19797@master.mivlgu.local>
	 <Pine.LNX.4.64.0512201018000.4827@g5.osdl.org>
	 <20051220191412.GA4578@stusta.de>
	 <Pine.LNX.4.64.0512201156250.4827@g5.osdl.org>
	 <43A86B20.1090104@superbug.co.uk>
	 <Pine.LNX.4.64.0512201248481.4827@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mustang.oldcity.dca.net (mustang.oldcity.dca.net [216.158.38.3])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id 68C561B6
	for <alsa-devel@alsa-project.org>; Tue, 20 Dec 2005 23:13:56 +0100 (MET)
In-Reply-To: <Pine.LNX.4.64.0512201248481.4827@g5.osdl.org>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Linus Torvalds <torvalds@osdl.org>
Cc: James Courtier-Dutton <James@superbug.co.uk>, Adrian Bunk <bunk@stusta.de>, Sergey Vlasov <vsu@altlinux.ru>, Ricardo Cerqueira <v4l@cerqueira.org>, mchehab@brturbo.com.br, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, video4linux-list@redhat.com, perex@suse.cz, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 2005-12-20 at 13:03 -0800, Linus Torvalds wrote:
> Forcing (or even just encouraging) people to use loadable modules is
> just horrible. I personally run a kernel with no modules at all: it
> makes for a simpler bootup, and in some situations (embedded) it has
> both security and size advantages. 

With modules it's possible to test a new ALSA version without
recompiling the kernel or even rebooting.  Encouraging people to build
it into the kernel would create a problematic barrier to entry for
debugging.  With the amount of poorly documented hardware we support,
it's essential for preventing driver regressions for users to be able to
easily test the latest ALSA version.  

Lee



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
