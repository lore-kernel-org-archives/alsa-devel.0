From: Juan Carlos Castro y Castro <jcastro@instant.com.br>
Subject: Re: Error compiling alsa-driver from sources
Date: Tue, 16 May 2006 15:33:43 -0300
Message-ID: <446A1B07.3070403@instant.com.br>
References: <4464A474.6070604@instant.com.br>	<s5h3bfa3x9e.wl%tiwai@suse.de>	<4469F55A.8060909@instant.com.br> <s5hlkt22cbx.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hlkt22cbx.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:

>(snip)
>
>It's a known issue that I've seen sometimes.
>alsa-driver/include/linux/pci_ids.h is missing, which is a symlink to
>../pci_ids_compat.h.  It must be created by configure script but it's
>removed by some reason on hgcompile.
>
>Create the symlink above manually or just run configure again.
>  
>
./configure did it, thanks.

In the meantime I also realized alsa-utils requires gettext-devel. 
Again, unlike the stable tarball.


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
