From: Eric Dantan Rzewnicki <eric@zhevny.com>
Subject: Re: [Alsa-user] error with current CVS and beta 12
Date: Wed, 17 Apr 2002 07:22:26 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <a9jlum$5e9$2@main.gmane.org>
References: <1019030378.2156.8.camel@littlewolf1.littlewolf>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from grace.speakeasy.org (grace.speakeasy.org [216.254.0.2])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with SMTP id NAA26575
	for <alsa-devel@alsa-project.org>; Wed, 17 Apr 2002 13:21:07 +0200
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Allan Klinbail <allank@labyrinth.net.au>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, alsa-user@alsa-project.org
List-Id: alsa-devel@alsa-project.org

If you're working with cvs or beta12 your modules should be called
snd-ice1712 and snd-ens1371 not snd-card-ice1712 and snd-card-ens1371.

-Eric Rz.

Allan Klinbail wrote:
> Starting sound driver: snd-card-ens1371
> modprobe: insmod snd-card-ice1712 failed
> 
> and from modules.conf (yes I know it's messy)
> 
>  alias char-major-116 snd
> options snd snd_major=116 snd_cards_limit=4
> alias snd-card-0 snd-card-ens1371
> alias snd-card-1 snd-card-ice1712
