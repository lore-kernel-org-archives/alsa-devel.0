From: "Ivica Bukvic" <ico@fuse.net>
Subject: RE: question regarding latest CS4205 laptop soundcard driver
Date: Thu, 28 Feb 2002 00:32:52 -0500
Message-ID: <000001c1c019$5df7f090$ac1f830a@ico>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
In-Reply-To: <200202280309.WAA14147@renoir.op.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: 'Paul Davis' <pbd@Op.Net>
Cc: alsa-devel@alsa-project.org, alsa-user@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> 1a) Get Abramo to post (or point to) detailed information on using a
>    "share" PCM device
> 
> 1b) Get Abramo or Jaroslav to post (or point to) detailed information
>    on setting up libaoss (specifically, how to map /dev/dspN to a
specific
>    ALSA PCM device)
> 
> 2) edit your ~/.asoundrc file to define a "share" PCM device
> 
> 3) run all your legacy (OSS) apps with LD_PRELOAD set to preload
libaoss.
>       a small wrapper script is useful for this; ALSA may already
>       come with one (*)
> 
> 4) run all your newer (ALSA) apps with an argument telling it to use
>      the "share" PCM device
> 
> and you should be done. if, that is, the "share" device type is really
> working. if not, you can help us debug it.
> 
> --p
> 
> (*) something like:
> 
> % cat aoss
> #!/bin/sh
> 
> export LD_PRELOAD=/where/i/put/libaoss.so
> exec $*
> %
> 
> then you can just run OSS apps like this:
> 
> % aoss oss-app-name oss-app-args...
> 
> i know this appears hacky. like i said, there is no way around this
> because of the way OSS was designed.
> 

Wow, finally a huge step forward!:-)

I really do not care if it is a hacker-like way of doing stuff as long
as it works. I will try fiddling with what you gave me and post some
results when (and if) I get anywhere with it... Thanks once more for a
concise explanation...

Is there anyone else with some kind of experience in this field? Maybe
it is time to start documenting this potentially awesome feature... I
could easily provide webspace and/or maintain the docs webpage if
needed, as long as I can get a pool of people working on this issue with
me... Anyone interested?

Ico



_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
