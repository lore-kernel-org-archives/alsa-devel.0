From: Paul Davis <pbd@op.net>
Subject: Re: Broken Pipes
Date: Thu, 25 Jul 2002 10:16:21 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E17XjMV-0007jC-00@usw-sf-list1.sourceforge.net>
References: <20020725150319.A368@siberia>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: Your message of "Thu, 25 Jul 2002 15:03:19 -0000."
             <20020725150319.A368@siberia>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Tony Hardie-Bick <tonyhb@easynet.co.uk>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>Am reading audio using snd_pcm_readi() and using short buffer times
>that result in "Broken pipe" errors being returned. Occasionally losing
>audio is not a problem, but do I have to completely reinitialise whenever
>this occurs?

it depends on the sw params you set up (if any). i think the default
is to stop whenever an xrun of any length occurs. i generally set the
stop threshold to ~0U, which means that the driver will keep the
interface running more or less no matter what - my app notes the
-EPIPE return codes and takes its own steps to
stop+reinitialize+restart when it wants to. what behaviour you want
will depend on your application.

--p


-------------------------------------------------------
This sf.net email is sponsored by: Jabber - The world's fastest growing 
real-time communications platform! Don't just IM. Build it in! 
http://www.jabber.com/osdn/xim
