From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: Moving from OSS to ALSA
Date: Mon, 12 Jan 2004 07:54:37 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200401121254.i0CCscqt026891@dhin.linuxaudiosystems.com>
References: <Pine.LNX.4.58.0401120938110.1941@pnote.perex-int.cz>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Mon, 12 Jan 2004 09:42:16 +0100."
             <Pine.LNX.4.58.0401120938110.1941@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Lorn Potter <lpotter@trolltech.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>Yes, we're aware that our APIs are rather too much complicated for simple 
>applications. We are designing the very simple (current name ordinary) 
>APIs to let more developers join us. But as Kai noticed, these APIs will 
>be a bit limited, so they won't be intended for more complex applications.

Jaroslav, please don't spend much time on this. There are no
indications that ALSA is going to be picked as a native API by
freedesktop.org, nor any of the incarnations of various X
organizations as a network-transparent API. Simple applications are
just not going to use ALSA, they will be using some API approved by
GNOME/KDE/freedesktop, which will sit happily on top of the more
complex API that alsa-lib currently provides.

There are much more important things that ALSA needs to fix, like the
asoundrc syntax/handling/setup.

--p


-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
