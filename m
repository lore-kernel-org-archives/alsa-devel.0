From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: [linux-audio-dev] interesting info regarding hdsp behavior
Date: Mon, 27 Jan 2003 08:23:44 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E18d99X-0008IL-00@sc8-sf-list1.sourceforge.net>
References: <000001c2c5ce$eed8b6b0$ac1f830a@ICO>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Mon, 27 Jan 2003 01:40:07 EST."
             <000001c2c5ce$eed8b6b0$ac1f830a@ICO>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: linux-audio-dev@music.columbia.edu
Cc: alsa-devel@lists.sourceforge.net, alsa-user@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>I've been messing with hdsp and found out an interesting issue. After
>installing the driver for the first time onto the xp machine I also had
>no sound coming out of the soundcard even though totalmix app showed
>levels to be up. After clicking on the levels and/or moving them a bit,
>suddenly the sound was there (as if the default values were there only
>in the app itself, but did not affect the actual levels on the card
>until they were moved for the first time). I was wondering maybe this is
>the problem we're having in Linux, where the card loads just fine, but
>for some reason there is no sound until a reboot has taken place.

this problem has already been fixed.

it was caused by a missing register write on intel systems (the
relevant one was there for PPC systems). marcus fixed this, oh, maybe
2-3 months ago.

--p


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
