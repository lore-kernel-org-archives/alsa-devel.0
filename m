From: Florian Bomers <Florian.Bomers@sun.com>
Subject: Re: dsnoop, dshare and dmix plugins
Date: Thu, 20 Mar 2003 14:13:18 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E7A3CFE.4A6293A5@sun.com>
References: <E18vjIM-0006pL-00@sc8-sf-list2.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

just to clarify: all 3 plugins will not enable several processes to use the same
soundcard's channels, i.e. software mixing?

Thanks,
Florian


> Hi all,
> 
>         the dmix plugin was extended to support channel bindings and
> mixing code for 32-bit samples (24-bit resolution).
>         I'd like to introduce new two plugins (seems also "most wanted" by
> ALSA users): dsnoop and dshare. The dsnoop plugin allows spliting of one
> stream to more applications. And finally the dshare plugin does sharing of
> channels (thus you may use your multi-channel device for separated
> independent tasks). The ALSA configuration syntax for both of new plugins
> is same as for the dmix plugin. Please note that dshare plugin must have
> the bindings section with unique destination channels otherwise it won't
> work.
> 
>                                                 Jaroslav
> 
> -----
> Jaroslav Kysela <perex@suse.cz>
> Linux Kernel Sound Maintainer
> ALSA Project, SuSE Labs

-- 
Florian Bomers
Java Sound
Java Software/Sun Microsystems, Inc.
http://java.sun.com/products/java-media/sound/


-------------------------------------------------------
This SF.net email is sponsored by: Tablet PC.  
Does your code think in ink? You could win a Tablet PC. 
Get a free Tablet PC hat just for playing. What are you waiting for? 
http://ads.sourceforge.net/cgi-bin/redirect.pl?micr5043en
