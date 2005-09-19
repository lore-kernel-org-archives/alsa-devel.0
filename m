From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Audigy DSP questions.
Date: Mon, 19 Sep 2005 17:05:08 -0400
Message-ID: <1127163909.9899.46.camel@mindpipe>
References: <432D8AA7.4040203@superbug.co.uk>
	 <432DA3D7.2070904@superbug.co.uk>  <432DAB41.9070508@superbug.co.uk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <432DAB41.9070508@superbug.co.uk>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: James Courtier-Dutton <James@superbug.co.uk>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Sun, 2005-09-18 at 19:00 +0100, James Courtier-Dutton wrote:
> James Courtier-Dutton wrote:
> > I think I have worked it out.
> > Take each value and divide by 0x80000000 to get a value between 0 and 1.
> > This is then converted into dB with
> > 0 == Mute
> > 0x01571f82 == -19.8 dB
> > 0x7fffffff == 0 dB
> > With each value being a constant step of 0.2 dB.
> > 
> > James
> > 
> > 
> Did anyone spot the deliberate mistake?
> 

I give up, what is it and why do you think it's deliberate?

Lee



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
