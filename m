From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: [Fwd: use new API ?]
Date: Mon, 11 Nov 2002 23:17:43 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0211112312140.521-100000@pnote.perex-int.cz>
References: <3DD0286B.9E49DD86@sun.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3DD0286B.9E49DD86@sun.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Florian Bomers <Florian.Bomers@sun.com>
Cc: ALSA devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Mon, 11 Nov 2002, Florian Bomers wrote:

> Please apologize for the repetition of my question. I probably don't have to
> tell you that in commercial software engineering I have to deal with hard
> dead-lines and longer development and test cycles. I guess most of you don't
> even care... but I think it would be a pity for many people if Sun's Java still
> wouldn't support ALSA in the next years, just because I did not choose the
> 0.9.0-compatible way.
> 
> If there are other reasons why answers were pretty rare to my following
> question, please tell me. Being a OSS developer myself I know that commitment is
> unpopular (and "urgent" requests even more so), but then I'd appreciate at least
> to hear that you don't have any plans for 0.9.0rc5's compatibility with future
> versions.
> 
> --------
> 
> Is it more likely that 
> 
> 1) the already changed function prototypes, which are usable 
>   by defining ALSA_PCM_NEW_HW_PARAMS_API, change in future,

If you use this define, your application will work with next major ALSA 
release (probably 1.0). Note that we have also ALSA_PCM_NEW_SW_PARAMS_API.

> or
> 2) that the deprecated functions will be removed ?

Yes, we'll remove deprecated functions, but not for 0.9.

> I am talking here e.g. of  snd_pcm_hw_params_get_period_size()
> 
> Are there any incompatibilities likely from 0.9.0rc5 to 0.9.0FCS ?

I hope that this change was the last change before 0.9.0final, but as you 
seen, we are trying to retain compatibility. So, old programs will work 
with newer ALSA libraries (at least for major ALSA releases) - note that 
it does not work in opposite way - programs linked with newer libraries 
can have trouble with older libraries.

I am sorry for late reply.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
