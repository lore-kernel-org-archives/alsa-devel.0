From: "Karsten Wiese" <annabellesgarden@yahoo.de>
Subject: RE: snd_ prefix for module options
Date: Wed, 9 Oct 2002 12:15:17 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <DAELIEGDPLDDCIJPAICBEENLCDAA.annabellesgarden@yahoo.de>
References: <s5hfzvh2fid.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hfzvh2fid.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> Hi,
> 
> so far, all alsa modules use snd_ prefix for each module option.
> iirc, there was a problem regarding namespace at the time of 2.0
> kernel, and this was some workaround to avoid confliction.
> but 2.2 and later kernels have no such a problem at all.
> 
> so, i'd like to ask you how do you think to remove this snd_ prefix.
> of course, there is one and only big problem - compatibility!
> 
> 
> the questions are
> 
> - whether we should really do it or not?  is it worthy?
> 
leave it like it is.
changing would break lots of users module.conf entries,
which might be the fruits of hours of work.

> and
> 
> - when? now or after 0.9.0-final release?
> 
> 
> opinions, please?
> 
> 
> Takashi
> 
> 
> -------------------------------------------------------
> This sf.net email is sponsored by:ThinkGeek
> Welcome to geek heaven.
> http://thinkgeek.com/sf
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
__________________________________________________________________

Gesendet von Yahoo! Mail - http://mail.yahoo.de
Yahoo! pr‰sentiert als offizieller Sponsor das Fuﬂball-Highlight des
Jahres: - http://www.FIFAworldcup.com


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
