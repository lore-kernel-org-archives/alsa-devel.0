From: Andy Wingo <wingo@pobox.com>
Subject: Re: new alsa docs.
Date: Tue, 6 Aug 2002 12:24:47 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020806122447.J683@cebreiro.nc.rr.com>
References: <20020806104713.2f0ce97e.sjt@star.sr.bham.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20020806104713.2f0ce97e.sjt@star.sr.bham.ac.uk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: ALSA Development <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Tue, 06 Aug 2002, James Tappin wrote:

> 2) For debian it is possible to add a new file "alsasound" (say) to
> /etc/modutils/ and update-modules will find it (I'm not sure if this is
> recommended practice or not, I'm still very much a beginner with
> debian).

For debian, you're best off installing the alsa libs, etc from packages,
and building the modules from source. The alsa-base package provides
modutils and sysvinit integration. See /etc/alsa/modutils/0.9 [*] for
the modutils stuff.

[*] It might be 1.0 now. I have both files and they look the same. Hey
Jaroslav, let's get a 1.0 ;-)

regards,

wingo.


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
