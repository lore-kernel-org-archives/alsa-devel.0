From: Joe Hsu <nagual.hsu@gmail.com>
Subject: Re: about bt878/879
Date: Thu, 31 Mar 2005 07:08:16 +0800
Message-ID: <7fe2059905033015081a7cac09@mail.gmail.com>
References: <200503301056.j2UAuRHo012810@www4.pobox.sk>
	 <7fe2059905033006087479f171@mail.gmail.com>
	 <424AE25D.7070000@pobox.sk>
Reply-To: Joe Hsu <nagual.hsu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <424AE25D.7070000@pobox.sk>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Peter Zubaj <pzad@pobox.sk>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Thanks for your reply....I have tried inserted some samples. And the
buffer underrun
for playback is gone. However, the sound quality is not right, ie.
having some noise.
 I think I may do something wrong. For example, I capture 64 frames
once at a time
and check 'snd_pcm_avail_update', and then decide to insert one extra frames.
This extra frame is an average of 32th and 33th frame. The numbers of
extra frames
are not fixed every time and the biggest num is 8.  And the number of
frames I capture
is raging from 64 to 256.(ie., 64, 128, 192, 256)

Should I measure HZs both in AC97 and Bt878 at first to get an overview
for up/down sampling?

On Wed, 30 Mar 2005 19:31:09 +0200, Peter Zubaj <pzad@pobox.sk> wrote:
> Yes, they can. But 8000 Hz on bt878 or AC97 is not exactly 8000 HZ. It
> can be for example 8010 Hz for AC97 and 7990 for bt878. Only high end
> sound card can be synchronized together. For your case, you should
> handle this situation for example by discarding or inserting some samples.
> 
> Peter Zubaj
> 
> Joe Hsu wrote:
> 
> >Well.....I believe the AC97 alsa driver can operate at 8000 HZ in
> >software level.
> >
> >
> >On Wed, 30 Mar 2005 12:56:27 +0200, Peter Zubaj <pzad@pobox.sk> wrote:
> >
> >
> >>Hi,
> >>
> >>Just blind shot: Maybe diffrence in crystal frequence. 8000 Hz on
> >>bt878 is not 8000 Hz on AC97.
> >>
> >>Peter Zubaj
> >>
> 


-- 
The sun is shinny but the ice is slippery.


-------------------------------------------------------
This SF.net email is sponsored by Demarc:
A global provider of Threat Management Solutions.
Download our HomeAdmin security software for free today!
http://www.demarc.com/Info/Sentarus/hamr30
