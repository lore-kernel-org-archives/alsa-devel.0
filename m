From: Adrian Bunk <bunk@stusta.de>
Subject: Re: RFC: OSS driver removal, a slightly different approach
Date: Thu, 19 Jan 2006 23:45:01 +0100
Message-ID: <20060119224501.GC19398__8567.11643650687$1137710789$gmane$org@stusta.de>
References: <20060119174600.GT19398@stusta.de> <m3ek34vucz.fsf@defiant.localdomain> <1137709308.8471.77.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mailout.stusta.mhn.de (emailhub.stusta.mhn.de [141.84.69.5])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id 0702211F
	for <alsa-devel@alsa-project.org>; Thu, 19 Jan 2006 23:45:03 +0100 (MET)
Content-Disposition: inline
In-Reply-To: <1137709308.8471.77.camel@localhost.localdomain>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Krzysztof Halasa <khc@pm.waw.pl>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, perex@suse.cz
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 19, 2006 at 10:21:47PM +0000, Alan Cox wrote:
> On Iau, 2006-01-19 at 21:24 +0100, Krzysztof Halasa wrote:
>...
> > > SOUND_WAVEARTIST
> 
> Not sure

config SOUND_WAVEARTIST
        tristate "Netwinder WaveArtist"
        depends on ARM && SOUND_OSS && ARCH_NETWINDER
        help
          Say Y here to include support for the Rockwell WaveArtist sound
          system.  This driver is mainly for the NetWinder.

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
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
