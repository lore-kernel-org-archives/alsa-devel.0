From: Adrian Bunk <bunk@stusta.de>
Subject: Re: OSS driver removal, 2nd round
Date: Sun, 2 Jul 2006 01:12:16 +0200
Message-ID: <20060701231216.GG17588__42325.9764131673$1151795592$gmane$org@stusta.de>
References: <20060629192128.GE19712@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from mailout.stusta.mhn.de (mailout.stusta.mhn.de [141.84.69.5])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id A9D12239
	for <alsa-devel@alsa-project.org>;
	Sun,  2 Jul 2006 01:12:16 +0200 (MEST)
Content-Disposition: inline
In-Reply-To: <20060629192128.GE19712@stusta.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, Johannes Berg <johannes@sipsolutions.net>, perex@suse.cz, Olaf Hering <olh@suse.de>
List-Id: alsa-devel@alsa-project.org

On Thu, Jun 29, 2006 at 09:21:28PM +0200, Adrian Bunk wrote:

> Now that I've sent the first round of actually removing the code for OSS 
> drivers where ALSA drivers without regressions exist for the same 
> hardware, it's time for a second round amongst the remaining drivers.
> 
> 
> Removing OSS drivers where ALSA drivers for the same hardware exists has 
> two reasons:
> 
> 1. remove obsolete and mostly unmaintained code
> 2. get bugs in the ALSA drivers reported that weren't previously
>    reported due to the possible workaround of using the OSS drivers
> 
> 
> The list below divides the OSS drivers into the following three
> categories:
> 1. ALSA drivers for the same hardware
> 2. ALSA drivers for the same hardware with known problems
> 3. no ALSA drivers for the same hardware
> 
> 
> My proposed timeline is:
> - 2.6.18: let the drivers under 1. in the list below depend on
>           OSS_OBSOLETE_DRIVER
> - 2.6.20: remove the options depending on OSS_OBSOLETE_DRIVER
> - 2.6.22: remove the code for the drivers that were depending on
>           OSS_OBSOLETE_DRIVER from the kernel tree
>...
> 2. ALSA drivers for the same hardware with known problems
> 
> DMASOUND_PMAC
> - Olaf Hering regarding regressions in SND_POWERMAC:
>   Some tumbler models work only after one plug/unplug cycle of
>   the headphone. early powerbooks report/handle the mute settings
>   incorrectly. there are likely more bugs.
>...

Could anyone tell me whether there are still regressions in ALSA 
compared to DMASOUND_PMAC, and if yes give me bug numbers in the 
ALSA BTS so that I can track them?

TIA
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
