From: torsten <torsten@inetw.net>
Subject: Re: wolk kernel headers
Date: Tue, 11 Feb 2003 16:34:59 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030211163459.61d158b7.torsten@inetw.net>
References: <20030210161442.55d398cd.torsten@inetw.net>
	<s5hznp3ciyp.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hznp3ciyp.wl@alsa2.suse.de>
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


>> Since the kerenel headers copied into /usr/include match
>> the glibc when my kernel was compiled (non-wolk), there
>> are no files asound.h and asequencer.h (needed by kdelibs).
>
>this is a bug of kdelibs.  the application shouldn't refer to these
>files.  i thought it's fixed on kde cvs...


I have searched bugs.kde.org, but I find no mention.
It may be fixed in CVS, I'm using release 3.1.

Torsten


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
