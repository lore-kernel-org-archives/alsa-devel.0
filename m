From: Allan Klinbail <allank@labyrinth.net.au>
Subject: Re: [Alsa-user] error with current CVS and beta 12
Date: 17 Apr 2002 22:27:57 +1000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <a9jprs$bdo$2@main.gmane.org>
References: <1019030378.2156.8.camel@littlewolf1.littlewolf>
	<3CBD5AF2.6DA84FD4@zhevny.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3CBD5AF2.6DA84FD4@zhevny.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Eric Dantan Rzewnicki <eric@zhevny.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, alsa-user@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Thanks that worked fine



On Wed, 2002-04-17 at 21:22, Eric Dantan Rzewnicki wrote:
> If you're working with cvs or beta12 your modules should be called
> snd-ice1712 and snd-ens1371 not snd-card-ice1712 and snd-card-ens1371.
> 
> -Eric Rz.
> 
> Allan Klinbail wrote:
> > Starting sound driver: snd-card-ens1371
> > modprobe: insmod snd-card-ice1712 failed
> > 
> > and from modules.conf (yes I know it's messy)
> > 
> >  alias char-major-116 snd
> > options snd snd_major=116 snd_cards_limit=4
> > alias snd-card-0 snd-card-ens1371
> > alias snd-card-1 snd-card-ice1712
