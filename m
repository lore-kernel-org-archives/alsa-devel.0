From: alsa@slackware.ru
Subject: Re: Redhat 9.0 also has the snd.o unresolved symbol schedule_work issue
Date: Sun, 30 Mar 2003 14:34:08 +0400 (MSD)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.53.0303301424030.21623@scil.sinp.msu.ru>
References: <3E861CFC.9040908@corekin.no-ip.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3E861CFC.9040908@corekin.no-ip.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sat, 29 Mar 2003, Jason Corekin wrote:

> I work for HP and I just downloaded the new RH 9.0 iso's from our
> internal source yesterday.  After upgrading from RH 8.0 and the 2.4.18
> kernel I tried to update my Alsa drivers to work with the new 2.4.20
> kernel and found that althought the Alsa 0.9.2 drivers had compiled and
> installed without trouble the would not load.  Instead I am getting the
> error unresolved symbol schedule_work.

please, check the kernel includes.
/usr/include/linux MUST be the link to the include directory of the
kernel. it was in the process of migration from 2.4.<20 to 2.4.>20.
some distributions have /usr/include/linux as a directory. and, when
compiling the fresh kernel, one can get strange things with unresolved
symbols etc (old headers + new kernel).

so,
/usr/include/linux must be the link to /usr/src/linux/include/linux,
if kernel sources were unpacked to the /usr/src/linux.
and, also, You need to recompile drivers.

maybe, the described approach can help.



-------------------------------------------------------
This SF.net email is sponsored by:
The Definitive IT and Networking Event. Be There!
NetWorld+Interop Las Vegas 2003 -- Register today!
http://ads.sourceforge.net/cgi-bin/redirect.pl?keyn0001en
