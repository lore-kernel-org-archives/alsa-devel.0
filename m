From: Peter L Jones <peter@drealm.org.uk>
Subject: Re: snd_ prefix for module options
Date: Wed, 9 Oct 2002 19:37:05 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200210091937.05652@advent.drealm.org.uk>
References: <s5hfzvh2fid.wl@alsa2.suse.de> <DAELIEGDPLDDCIJPAICBEENLCDAA.annabellesgarden@yahoo.de> <s5hwuor29tv.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hwuor29tv.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>, Karsten Wiese <annabellesgarden@yahoo.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wednesday 09 Oct 2002 11:19, Takashi Iwai wrote:
> At Wed, 9 Oct 2002 12:15:17 +0200,
>
[snip]
>
> a convenient method is to check and rewrite /etc/modules.conf
> automatically when alsa-driver is installed.  (btw, in the case of
> debian, do we need to check another path, too?)

Yes.
/etc/modutils/alsa -> /etc/alsa/modutils/0.9
And then run update-modules.

This would normally be done when upgrading the .deb to the new version, so it 
shouldn't be something the driver or init.d file should worry about.

(My opinion only...)

>
> i'm not sure whether it's good manner or not, though.

I think it's not so nice.  Anyone running ALSA 0.9 should know it's not a 
"release" version and be happy to have (some breakage).  If all that's needed 
is a quick edit of modules.conf, it shouldn't cause too many power-users 
grief.  Those using distro upgrade tools should let their distro maintainer 
sort it out for them.

I don't think it's an ALSA developer problem.

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



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
