From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: [PATCH] RME HDSP MADI  pci naming bug
Date: Tue, 31 May 2005 16:50:46 +0200 (CEST)
Message-ID: <Pine.LNX.4.58.0505311650330.1744@pnote.perex-int.cz>
References: <429C727C.9050709@idmt.fraunhofer.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <429C727C.9050709@idmt.fraunhofer.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Joachim Deguara <dga@idmt.fraunhofer.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, 31 May 2005, Joachim Deguara wrote:

> Hello,
> 	I discovered a trivial bug where the snd-hdsp and snd-hdspm do not play 
> together.  They cannot be loaded as modules simultaneously and create 
> detection problems if compiled as static modules in a kernel.  The 
> problem come from the sysfs while registering their PCI names, which 
> happens to be the same (oops).  Therefore the first module to get loaded 
> stayed in, but the secound one would be blocked...not anymore ;)

Thanks. Applied to CVS.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
