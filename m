From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: hdsp/firmware problem
Date: Fri, 14 Feb 2003 09:05:52 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E18jgTf-0004Qj-00@sc8-sf-list1.sourceforge.net>
References: <20030214135711.GA1792@finnendahl.de>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Fri, 14 Feb 2003 14:57:11 +0100."
             <20030214135711.GA1792@finnendahl.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Orm Finnendahl <finnendahl@folkwang-hochschule.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>It means he didn't use the rear outputs for checking but the line outs
>on the front of the Multifaceq which are muted even if alsamixers
>controls are up afaik.

FYI this (from modules.conf) will turn on line out monitoring by
default (all channels, unity gain):

    options snd-hdsp snd_id="hdsp" snd_line_outs_monitor=1



-------------------------------------------------------
This SF.NET email is sponsored by: FREE  SSL Guide from Thawte
are you planning your Web Server Security? Click here to get a FREE
Thawte SSL guide and find the answers to all your  SSL security issues.
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0026en
