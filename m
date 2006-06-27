From: Matthias Koenig <list@phasorlab.de>
Subject: Re: asoundlib.h: No such file or directory
Date: Tue, 27 Jun 2006 15:44:13 +0200
Message-ID: <87ejxalnma.fsf@zebra.localdomain>
References: <6474b3950606270603n3577b1d6l48eb1974c78863e2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <6474b3950606270603n3577b1d6l48eb1974c78863e2@mail.gmail.com>
	(techie tone's message of "Tue, 27 Jun 2006 18:33:28 +0530")
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: techie tone <techietone@gmail.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

"techie tone" <techietone@gmail.com> writes:

> While compiling alsa applications, I'm getting foll' error:
> asoundlib.h: No such file or directory
>
> I could not locate this file on my linux system.

Header should be in /usr/include/alsa/
Perhaps you don't have installed the corresponding developer
package. E.g. on a debian system it is called
libasound2-dev
On other distros the name might be different.

Matthias

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
