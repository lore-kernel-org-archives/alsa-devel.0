From: Mark Knecht <markknecht@comcast.net>
Subject: Re: Re: No /dev/snd/seq? - SOLVED
Date: Wed, 27 Aug 2003 19:54:47 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1062039287.1598.5.camel@Wizard.knechthome.com>
References: <1062033229.1475.14.camel@Wizard.knechthome.com>
	 <1062033547.1475.16.camel@Wizard.knechthome.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1062033547.1475.16.camel@Wizard.knechthome.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alsa-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Wed, 2003-08-27 at 18:19, Mark Knecht wrote:
> OK, so modprobe snd-seq fixed this. I suppose this should be in
> modules.conf?
> 
> Thanks,
> Mark
> 

OK, by placing snd-seq at the end of my modules.autoload file this is
loaded at boot time and Rosegarden runs fine so far.

Cheers,
Mark



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
