From: Prince John <princejohnm@yahoo.com>
Subject: Re: ALSA Driver Testing
Date: Sat, 26 Jul 2003 08:05:52 -0700 (PDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030726150552.8105.qmail@web11704.mail.yahoo.com>
References: <s5hwuehyzcg.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hwuehyzcg.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


config
> > files. The error happens during the search of some
> > sound
> > config files in conf.c file of ALSA lib. 
> > 
> > The .asoundrc file is kept at / and /root. The
> > alsa.conf file is placed in /alsa and
> /usr/share/alsa
> 
> / is not referred at all.
> the file is either ~/.asoundrc or /etc/asound.conf.
> 
> > # ls -l /dev/snd
> > lrwxrwxrwx    1 root     root           16 Jun  7
> > 14:48 /dev/snd -> /proc/asound
> > /dev
> 
> ok, you're using an old version...
> 
> 
> > Am I missing any config files or path settings ?
> Can
> > somebody please give the info on how & where to
> setup
> > the config files for a new driver?
> 
> how about checking via strace which files are
> opened?
> 
> 
> Takashi
> 
> 
Thanks for the response. The problem got solved by
placing 'alsa.conf' file in
<install-prefix>/share/alsa directory.

Thanks,
Prince

__________________________________
Do you Yahoo!?
Yahoo! SiteBuilder - Free, easy-to-use web site design software
http://sitebuilder.yahoo.com


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
