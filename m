From: matt yee-king <yeeking@no-future.com>
Subject: Re: modprobe of snd-powermac fails
Date: 26 Apr 2002 14:11:07 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1019830272.786.29.camel@bennyhill.belmont>
References: <1019828111.786.24.camel@bennyhill.belmont>
	<s5h1yd2bon6.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h1yd2bon6.wl@alsa2.suse.de>
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

yep. thats fixed it! nice one. the world of alsa awaits.... :)

- matthew


> then add #include <asm/delay.h> to alsa-kernel/ppc/keywest.c.
> 
> 
> Takashi
> 
