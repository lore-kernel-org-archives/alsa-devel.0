From: Paul Davis <pbd@Op.Net>
Subject: Re: Separating left/right channels (voices)
Date: Sun, 07 Apr 2002 10:34:14 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200204071434.KAA21337@renoir.op.net>
References: <20020406132739.U83199-100000@flex.com>
In-Reply-To: Your message of "Sat, 06 Apr 2002 13:37:52 -1000."
             <20020406132739.U83199-100000@flex.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Jimen Ching <jching@flex.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>I am working on a problem where I want to extract the left and right
>channels from a sound file.  

sox can do this from the command line.

			      I am running into a problem where I can not
>tell if the samples are from the left only, or the right only channels.
>I have a sound file that is mono, when I play this file through ALSA, the
>samples come out on both left and right speakers.  It seems either ALSA is
>sending the mono samples to both channels, or my soundcard is doing it.
>I am wondering if there is a way to control whether a mono sound file can
>be played to only one speaker using ALSA.

alsa-lib does this when you use a "plug" PCM device (which is the
default when you install ALSA).  if you open a N channel device as an
(N-M) channel device, it duplicates the signal across the the missing
channels. this can be controlled from your ~/.asoundrc but nobody has
written a decent document to explain how to change this. a search of
the archives for "ttable" may reveal some ideas, but ...

--p
