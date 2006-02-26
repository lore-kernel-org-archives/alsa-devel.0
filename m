From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Re: [PPC,SOUND] Fix audio gpio state detection
Date: Sun, 26 Feb 2006 14:19:18 -0500
Message-ID: <1140981558.24141.112.camel@mindpipe>
References: <jehd7527wq.fsf@sykes.suse.de>
	 <1139783738.5247.54.camel@localhost.localdomain>
	 <20060226173908.GA4871@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mustang.oldcity.dca.net (mustang.oldcity.dca.net [216.158.38.3])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id 8148A187
	for <alsa-devel@alsa-project.org>; Sun, 26 Feb 2006 20:24:52 +0100 (MET)
In-Reply-To: <20060226173908.GA4871@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Olaf Hering <olh@suse.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Andreas Schwab <schwab@suse.de>, linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, Ben Collins <ben.collins@ubuntu.com>
List-Id: alsa-devel@alsa-project.org

On Sun, 2006-02-26 at 18:39 +0100, Olaf Hering wrote:
> /proc/device-tree/pci@f2000000/mac-io@17/gpio@50:
> linux,device     cfdc7808
> name             "gpio"
> linux,phandle    ff90fcd0
> reg              00000050 00000030
> built-in        
> device_type      "gpio"
> 

Argh, /proc abuse... "historical reasons" presumably?

Lee



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
