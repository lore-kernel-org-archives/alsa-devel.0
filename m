From: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@kth.se>
Subject: Re: snd_pcm_open fails
Date: Tue, 01 Jun 2004 00:03:56 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <yw1xsmdg9rub.fsf@kth.se>
References: <40BBA233.4000504@cornfed.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

"Frank W. Miller" <fwmiller@cornfed.com> writes:

> Hi,
>
> I've got my header file installed now.  I had to install two rpms
>
> alsa-lib-1.0.4-12.rhfc1.at.i386.rpm
> alsa-lib-devel-1.0.4-12.rhfc1.at.i386.rpm
>
> on my default Fedora Core 1 install.  I restarted and my cdplayer is
> still working so thats good.  I can also do my compiles with
> <alsa/asoundlib.h> being found and -lasound being linked, so thats
> good too.  Trouble is, now when I try to open the pcm devices with
> something like:
>
> snd_pcm_open(..., "default", ...);
>
> I'm getting a No such file or directory error.  Same thing for
> "plughw" and "plughw:0,0".  Anyone seen this before?

Most likely missing ALSA device files (/dev/snd/*).  There's a script
somewhere to create them.

-- 
Måns Rullgård
mru@kth.se



-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
