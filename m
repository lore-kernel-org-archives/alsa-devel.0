From: "Joe Hsu" <nagual.hsu@gmail.com>
Subject: Re: libaoss.so hole?
Date: Sat, 18 Mar 2006 07:20:25 +0800
Message-ID: <7fe205990603171520t29c81bag@mail.gmail.com>
References: <7fe205990603170512j58c63e4es@mail.gmail.com>
	 <441AF6C6.4090706@cubic.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from zproxy.gmail.com (zproxy.gmail.com [64.233.162.196])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D3961176
	for <alsa-devel@alsa-project.org>; Sat, 18 Mar 2006 00:20:27 +0100 (MET)
Received: by zproxy.gmail.com with SMTP id i11so643598nzh
        for <alsa-devel@alsa-project.org>; Fri, 17 Mar 2006 15:20:25 -0800 (PST)
In-Reply-To: <441AF6C6.4090706@cubic.org>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Dirk Jagdmann <doj@cubic.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

2006/3/18, Dirk Jagdmann <doj@cubic.org>:
> >     I have an oss application which registers SIGCHLD signal handler
> > in the beginning and then opens /dev/dsp, and then forks a child
> > process. If the child process dies, the father process would receive a
> > SIGCHLD process and then free the allocated resources and then exit.
>
> I don't see any problem here if you did your code right.
> 1) fork() does return the pid of the child
> 2) in your SIGCHLD handler call wait(int*) which returns the pid of the
> terminated process.
> 3) If the pid from fork() and wait() match you can do your cleanup()
> 4) If they don't match, simply ignore the signal, as some other process
> (probably from the alsa lib) has died.
>
> --
> ---> Dirk Jagdmann ^ doj / cubic
> ----> http://cubic.org/~doj
> -----> http://llg.cubic.org
>
    Of course. I know what you mean. But that is like a work around to
me. And I did a work around too. Since many oss developers didn't
think about the oss-to-alsa layer, this layer must be as transparent
as possible.
    Well, just my own opinion.
--
The sun is shinny but the ice is slippery.


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
