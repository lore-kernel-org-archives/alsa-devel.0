From: Paul Davis <pbd@op.net>
Subject: Re: alsa-api question
Date: Thu, 27 Jun 2002 13:13:38 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200206271711.g5RHBaD00230@post2.fast.net>
References: <Pine.LNX.4.40.0206271732370.5389-100000@ping01.stura.uni-weimar.de>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: Your message of "Thu, 27 Jun 2002 19:02:13 +0200."
             <Pine.LNX.4.40.0206271732370.5389-100000@ping01.stura.uni-weimar.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: joy ping <joy@pingfm.org>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

>i currently writing a plugin for alsa9 and i'm thinking of various
>paramters which could be set and if there are usefull for example does
>someone know 'good' values for snd_pcm_sw_params_set_xfer_align(), in the
>code samples it varies from 1 to 4, is it also usefull to set it to higher
>values for example 1024? and at least what is it good for?
>is there any need for any sw_parameters for 'normal' player applications??

avail_min is the only sw_param you typically need to set, and even
that is only if you intend to use poll(2). all ALSA params come with
"reasonable" defaults. xfer_align, in particular, is one that i've
never ever bothered to set.

--p

\begin{ObJack}
ps. but why bother with all this when you can use JACK (http://jackit.sf.net/)?
\end{ObJack}


-------------------------------------------------------
Sponsored by:
ThinkGeek at http://www.ThinkGeek.com/
