From: Adrian Bunk <bunk@stusta.de>
Subject: Re: 2.6.15-rc5-mm1
Date: Fri, 9 Dec 2005 00:02:03 +0100
Message-ID: <20051208230203.GA23349__2561.99705550007$1134083159$gmane$org@stusta.de>
References: <20051204232153.258cd554.akpm@osdl.org> <1134068983.21841.71.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mailout.stusta.mhn.de (mailout.stusta.mhn.de [141.84.69.5])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id D5024197
	for <alsa-devel@alsa-project.org>; Fri,  9 Dec 2005 00:02:06 +0100 (MET)
Content-Disposition: inline
In-Reply-To: <1134068983.21841.71.camel@localhost.localdomain>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Badari Pulavarty <pbadari@gmail.com>, Jaroslav Kysela <perex@suse.cz>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Dec 08, 2005 at 11:09:43AM -0800, Badari Pulavarty wrote:
> On Sun, 2005-12-04 at 23:21 -0800, Andrew Morton wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.15-rc5/2.6.15-rc5-mm1/
> 
> In file included from sound/pci/ens1371.c:2:
> sound/pci/ens1370.c: In function `snd_audiopci_probe':
> sound/pci/ens1370.c:2462: error: `spdif' undeclared (first use in this
> function)sound/pci/ens1370.c:2462: error: (Each undeclared identifier is
> reported only once
> sound/pci/ens1370.c:2462: error: for each function it appears in.)
> sound/pci/ens1370.c:2462: error: `lineio' undeclared (first use in this
> function)
> make[2]: *** [sound/pci/ens1371.o] Error 1
> make[2]: *** Waiting for unfinished jobs....

Jaroslav, this seems to come from your

  [ALSA] ens1371: added spdif and lineio module option

patch in the ALSA git tree if SUPPORT_JOYSTICK=n.

> Thanks,
> Badari

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
