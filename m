From: Shaju Abraham <shaju@multitech.co.in>
Subject: Re: Calling snd_pcm_oss_write directly.
Date: Wed, 24 Jul 2002 19:57:46 +0530
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D3EB962.EC2C947E@multitech.co.in>
References: <200207241129.g6OBTIbt000943@multitech.co.in>
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
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Paul Davis <pbd@op.net>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi all,
        I took the advice and used write()  from the other task.  It
promptly returned with < 0 error.
I do not know how the oss emulation in ALSA happens, so I do not know what
exactly went wrong.
Any more suggestions are welcome.

        Again, continuing my experiment with calling snd_pcm_oss_write
directly,  I traced the crash to few fns called from fn snd_pcm_prepare in
pcm_native.c   . These fns seem to be making few ioctls like
..._IOCTL_PREPARE  and  ..._IOCTL_DRAIN. (more fns name ..ioctl than
ioctl() call itself).   what are these fns doing and is it normal that they
are called after snd_pcm_oss_write has already been called.

--shaju abraham



Paul Davis wrote:

> >          I am in a situation where I intend to call snd_pcm_oss_write
> >directly.
>
> AFAIK, this is not a supported use of the alsa-lib API. There is no
> guarantee that your application will continue to work in future
> versions of alsa-lib.
>
> >What exactly happens is - the open and all the initial ioctl calls are
> >done by the oss application. But the write call of the oss application
> >is not done but it is done by some other task.
>
> there is still no reason to be using snd_pcm_<type>_<function> directly.
>
> if you insist on using the OSS API (a big error, IMHO) then you can
> just use the OSS API in the other task.
>
> --p



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
