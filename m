From: Dan Hollis <goemon@anime.net>
Subject: Re: [Alsa-user] RE: question regarding latest CS4205
 laptop    soundcard driver
Date: Tue, 26 Feb 2002 22:29:38 -0800 (PST)
Message-ID: <a5hum0$gsc$1@quimby2.netfonds.no>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
In-Reply-To: <000001c1bf53$fe982860$ac1f830a@ico>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Ivica Bukvic <ico@fuse.net>
Cc: alsa-devel@alsa-project.org, alsa-user@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, 27 Feb 2002, Ivica Bukvic wrote:
> wouldn't it be a rather easy step to make it also
> be capable of accepting multiple queries and down-mixing them before
> sending them to the actual dsp?

Good resampling is hard, and good mixing is even harder and very 
processor intensive. You surely don't want to be doing this in 
kernelspace.

BTW this same discussion took place a long time ago on alsa-devel and it 
was decided to do from userspace, kernelspace mixing is too evil.

> Finally, why not merge the efforts of all these different
> groups/projects into one concise solution, rather than a dozen
> half-working ones?

Because the different projects have different (and sometimes mutually 
incompatible) goals.

-Dan
-- 
[-] Omae no subete no kichi wa ore no mono da. [-]


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
