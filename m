From: Paul Davis <pbd@Op.Net>
Subject: Re: .asoundrc - share device
Date: Thu, 28 Feb 2002 09:52:26 -0500
Message-ID: <200202281452.JAA09207@renoir.op.net>
In-reply-to: Your message of "Thu, 28 Feb 2002 15:56:11 +0200."
             <Pine.LNX.4.44.0202281544350.3739-100000@ecabase.localdomain>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Kai Vehmanen <kai.vehmanen@wakkanet.fi>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>Another currently available option is to use the pcm_shm plugin which
>outputs audio to a separate aserver process (see alsa-lib/aserver). This
>plugin does work, but like pcm_share, hasn't been widely used yet. But
>it's the only working ALSA alternative for concurrent pcm access at the
>moment.

thanks Kai. the "shm" device type is the one i have always been
referring to when i have used the term "share". apologies for the
confusion. 

--p

ps. in case anyone finds Kai's last sentence via Google, let me add 
    "concurrent pcm access *to hardware that does not support it*" so
    that nobody thinks that ALSA can't do this in the simple cases :)

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
