From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: intel ICH sample rate
Date: Sun, 28 Dec 2003 00:07:25 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200312280507.hBS57QZg002377@dhin.linuxaudiosystems.com>
References: <200312272109.hBRL9TVD031711@dhin.linuxaudiosystems.com>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Sat, 27 Dec 2003 16:09:29 EST."
             <200312272109.hBRL9TVD031711@dhin.linuxaudiosystems.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
Cc: Jaroslav Kysela <perex@suse.cz>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>meanwhile, i have found that the plughw layer doesn't work with JACK
>anymore. it appears that any attempt to set the period size fails. any
>ideas about that?

to clarify: any attempt to set the period size if the SR is not 48kHz
will fail.

--p


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
