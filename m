From: Erik de Castro Lopo <erikd-alsa@mega-nerd.com>
Subject: Re: usb quattro permission denied as normal user
Date: Sun, 25 May 2003 17:07:43 +1000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030525170743.2dd7bacb.erikd-alsa@mega-nerd.com>
References: <Law9-F68BE5op1NGGbf0004b443@hotmail.com>
	<3ED05E27.3030804@boosthardware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mega-nerd.net (foobar@CPE-144-132-185-246.nsw.bigpond.net.au [144.132.185.246])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id JAA10521
	for <alsa-devel@alsa-project.org>; Sun, 25 May 2003 09:22:16 +0200
Received: from coltrane (coltrane [192.168.1.101])
	by mega-nerd.net (Postfix) with SMTP id 6DB978D95
	for <alsa-devel@alsa-project.org>; Sun, 25 May 2003 17:07:43 +1000 (EST)
In-Reply-To: <3ED05E27.3030804@boosthardware.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sun, 25 May 2003 15:09:43 +0900
Patrick Shirkey <pshirkey@boosthardware.com> wrote:

> After installing latest cvs and running chmod a+rw /dev/dsp* /dev/mixer 
> I get this error while normal user which doesn't occur as root.

In case you didn't know, there is probably a better to do this.

For each user who needs to access the audio hardware do:

    adduser <username> <group owner of audio devices>

In my case that would be (as root):

    adduser erikd audio

> Could this be related to the recent changes to the snddevices script 
> procedure?

That I can't answer, but the procedure above should solve this problem 
another way.

Cheers,
Erik
-- 
+-----------------------------------------------------------+
  Erik de Castro Lopo  nospam@mega-nerd.com (Yes it's valid)
+-----------------------------------------------------------+
The difference between genius and stupidity is that
  genius has its limits.


-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge
