From: Paul Davis <pbd@op.net>
Subject: Re: Calling snd_pcm_oss_write directly.
Date: Wed, 24 Jul 2002 07:39:40 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E17XKRX-0007HC-00@usw-sf-list1.sourceforge.net>
References: <3D3E7EC2.E28C98AF@multitech.co.in>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: Your message of "Wed, 24 Jul 2002 15:47:38 +0530."
             <3D3E7EC2.E28C98AF@multitech.co.in>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Shaju Abraham <shaju@multitech.co.in>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>          I am in a situation where I intend to call snd_pcm_oss_write
>directly.

AFAIK, this is not a supported use of the alsa-lib API. There is no
guarantee that your application will continue to work in future
versions of alsa-lib.

>What exactly happens is - the open and all the initial ioctl calls are
>done by the oss application. But the write call of the oss application
>is not done but it is done by some other task.

there is still no reason to be using snd_pcm_<type>_<function> directly.

if you insist on using the OSS API (a big error, IMHO) then you can
just use the OSS API in the other task.

--p


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
