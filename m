From: nagual.hsu <nagual.hsu@gmail.com>
Subject: Re: libaoss.so hole?
Date: Mon, 20 Mar 2006 02:18:33 +0000 (UTC)
Message-ID: <loom.20060320T031107-48@post.gmane.org>
References: <7fe205990603170512j58c63e4es@mail.gmail.com> <s5h4q1xt3oe.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai <tiwai <at> suse.de> writes:

> 
> >     After I turn on the ALSA_OSS_DEBUG environment variable,
> > libaoss.so first tried to open /dev/dsp0 but in vain. Then it tried a
> > alsa-default device successfully. I can see that every time libaoss.so
> > tries to opena pcm device with a new thread. And thta's the source of
> > the un-expected SIGCHLD signal.
> 
> No, aoss has no single code calling any thread functions...
> 
> Takashi
> 

    Maybe, it's the dmix and it is turned on as default since version
 1.0.10. I tried this with version 1.0.10.

    Check the following code run on computers with intel8x0 chips 
pre-loading libaoss.so:

#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <stdio.h>
#include <signal.h>

void handler(int signum)
{
	fprintf(stderr, "signal...%d == SIGCHLD??\n", signum);
	return;
}

int main(int argc, char *argv[])
{
	int fd;
	signal(SIGCHLD, handler);
	signal(SIGTERM, handler);
	
	fd = open("/dev/dsp", O_WRONLY);
	fprintf(stderr, "success...\n");
	close(fd);
	return 0;
}






-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
