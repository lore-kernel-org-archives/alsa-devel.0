From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: asound.conf pcm.tee, anyone know how to use it
Date: Mon, 13 May 2002 09:57:06 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <abnroh$o59$2@main.gmane.org>
References: <20020513004239.56478.qmail@web14108.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20020513004239.56478.qmail@web14108.mail.yahoo.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Dave Andruczyk <djandruczyk@yahoo.com>
Cc: ALSA development <alsa-devel@alsa-project.org>, ALSA user <alsa-user@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Sun, 12 May 2002, Dave Andruczyk wrote:

> Please someone correct me if I am mistaken.  Can the pcm.tee option in alsa.con
> (/usr/share/alsa/alsa.conf) be setup so that the output of a program that uses
> alsa natively be monitored by connecting to this "tee" ??
> 
> My primary app (eXtace) needs this sort of functionality, The old ALSA 0.5.x
> called it loopback, can this do the same?  Can anyone offer tips for someone
> who really doesn't understand the asound.conf syntax to possibly get it to
> work?

aplay -D tee:'plughw:0',a.raw ~/audio/audio_10.wav

All samples should go to 'a.raw' file, but as Paul mentioned, if you use a 
pipe, the audio process can be blocked (possible underruns).

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com


_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
