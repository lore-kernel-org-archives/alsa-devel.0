From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: The ALSA Situation
Date: Wed, 10 Nov 2004 23:22:24 +0000
Message-ID: <4192A2B0.6090503@superbug.co.uk>
References: <200411100150.iAA1okCE029069@localhost.localdomain>	 <001e01c4c6ce$77672eb0$0a00000a@eugenia> <1100066393.3137.4.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1100066393.3137.4.camel@krustophenia.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Eugenia Loli-Queru <eloli@eugenia.co.uk>, Paul Davis <paul@linuxaudiosystems.com>, alsa-devel@lists.sourceforge.net, torvalds@osdl.org
List-Id: alsa-devel@alsa-project.org

Lee Revell wrote:
> On Tue, 2004-11-09 at 18:38 -0800, Eugenia Loli-Queru wrote:
> 
>>2. This: http://www.osnews.com/img/6443/audio.png Check the clean and 
>>logical OSS options and then check the endless alsa ones (my monitor was not 
>>wide enough to fit them all). Why things like that are not cleaned up? (it's 
>>not gnome's volume control fault btw, I asked the developer, he said it's 
>>Alsa's)
> 
> 
> Bullshit.  If ALSA provides too many controls then GNOME volume control
> should abstract them a bit.  For example, use separate tabs for playback
> and capture, like alsamixer, or leave some elements out, instead of
> blithely cramming every mixer element into one tab without regard to
> whether it will fit on screen or whether that mixer control SHOULD be
> user visible.  Sorry, this is not ALSA's job. 
> 
> Lee
> 

alsamixer only has separate tabs for playback and capture because 
someone spent time implementing it.

ALSA has a very good API for PCM audio. The plans are ready for creating 
a very good API for mixer. While the plans have been there for some time 
now, developer's time has not been available. Unluckily, the current 
underdevelopment of the mixer parts of ALSA are very much apparent to 
all users.

The work required to support so many different sound cards has been 
considerable.

So, if you ignore the current well understood problems with the mixer, 
the rest of ALSA is very good.

James


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
