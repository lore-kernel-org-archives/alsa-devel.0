From: Florian Bomers <Florian.Bomers@sun.com>
Subject: Re: [Fwd: use new API ?]
Date: Mon, 11 Nov 2002 15:31:05 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DD03DB9.3F68125D@sun.com>
References: <Pine.LNX.4.33.0211112312140.521-100000@pnote.perex-int.cz>
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
To: ALSA devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

That's useful and very promising news! Thank you very much.

Florian


Jaroslav Kysela wrote:
> > Is it more likely that
> >
> > 1) the already changed function prototypes, which are usable
> >   by defining ALSA_PCM_NEW_HW_PARAMS_API, change in future,
> 
> If you use this define, your application will work with next major ALSA
> release (probably 1.0). Note that we have also ALSA_PCM_NEW_SW_PARAMS_API.
> 
> > or
> > 2) that the deprecated functions will be removed ?
> 
> Yes, we'll remove deprecated functions, but not for 0.9.
> 
> > I am talking here e.g. of  snd_pcm_hw_params_get_period_size()
> >
> > Are there any incompatibilities likely from 0.9.0rc5 to 0.9.0FCS ?
> 
> I hope that this change was the last change before 0.9.0final, but as you
> seen, we are trying to retain compatibility. So, old programs will work
> with newer ALSA libraries (at least for major ALSA releases) - note that
> it does not work in opposite way - programs linked with newer libraries
> can have trouble with older libraries.
> 
> I am sorry for late reply.
> 
>                                                 Jaroslav
> 
> -----
> Jaroslav Kysela <perex@suse.cz>
> Linux Kernel Sound Maintainer
> ALSA Project, SuSE Labs
> 
> -------------------------------------------------------
> This sf.net email is sponsored by:ThinkGeek
> Welcome to geek heaven.
> http://thinkgeek.com/sf
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel

-- 
Florian Bomers
Java Sound
Java Software/Sun Microsystems, Inc.
http://java.sun.com/products/java-media/sound/


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
