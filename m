From: John Covici <covici@ccs.covici.com>
Subject: Re: rc2 stereo problem with via8233
Date: Fri, 28 Jun 2002 20:32:44 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <m37kkiyleb.fsf@ccs.covici.com>
References: <m31yav1b40.fsf@ccs.covici.com> <s5hk7om563k.wl@alsa2.suse.de>
	<15642.10186.820516.331246@ccs.covici.com> <s5h66046gnp.wl@alsa2.suse.de>
	<15643.7633.177373.448813@ccs.covici.com> <s5h3cv86brk.wl@alsa2.suse.de>
	<15643.16455.420976.668125@ccs.covici.com> <s5hhejoobzr.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hhejoobzr.wl@alsa2.suse.de> (Takashi Iwai's message of "Thu,
 27 Jun 2002 19:41:28 +0200")
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Thanks, your patch worked fine!  But I would still like to know if I
have a multi-channel chip and if so how to use it?  I find that
playing cd quality wav files have a very peculiar sound over this
chip -- some artifact would be my guess.  Any ideas?

on Thu, 27 Jun 2002 19:41:28 +0200 Takashi Iwai <tiwai@suse.de> wrote:

> At Thu, 27 Jun 2002 12:41:43 -0400,
> John covici wrote:
>> 
>> OK, a stereo PCM does play both channels, a mono pcm plays left
>> channel only.
>
> then try the following patch.
>
>
> Takashi
>

-- 
         John Covici
         covici@ccs.covici.com


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Caffeinated soap. No kidding.
http://thinkgeek.com/sf
