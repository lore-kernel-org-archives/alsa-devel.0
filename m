From: Pannaga Bhushan <bhushan@multitech.co.in>
Subject: Re: A newbie's question with snd_pcm_writei
Date: Fri, 18 Oct 2002 15:25:11 +0530
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DAFDA7F.83E2FFAC@multitech.co.in>
References: <Pine.GSO.4.10.10210081932420.4476-100000@iesun67>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: yan hang fai <hfyan0@ie.cuhk.edu.hk>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


frame is what is played out(during playback) or what is recorded(during
capture) at each sample.
so this frame depends on what format your sound is i.e whether it is one
channel or two channel and
length of each sample, whether 16 bit or 8 bit.

so a 2 channel stereo 16-bit sound will have a frame of 4 bytes. i.e two
bytes per channel and two
channel

period size is number of frames? (or bytes?) between two successive
interrupts.

-- Pannaga Bhushan


yan hang fai wrote:

> Dear everyone
>      I have a question on using this api call.
>      In the last argument, we need to pass in the "frame". But the problem
> is that I dont understand the term "frame". Could anyone explain to me a
> little bit what it is? And also, what is meant by a "period"?
>      I have read http://www.suse.de/~mana/alsa090_howto.html and tested
> their "Basic PCM audio" program, I heard some random noise coming out from
> my speakers as the program is executed. Then I tried to modify the
> program. First I read some pcm data into a char* from a local file, then I
> tried to call snd_pcm_writei, passing my pcm data as argument. But I hear
> no sound. So I would like to know what I should pass as the "frame"
> argument.
>     Thank you very much



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
