From: Olaf Hering <olh@suse.de>
Subject: Re: RFC: OSS driver removal, a slightly different approach
Date: Fri, 20 Jan 2006 22:29:17 +0100
Message-ID: <20060120212917.GA14405__6150.03959178484$1137792618$gmane$org@suse.de>
References: <20060119174600.GT19398@stusta.de> <20060120115443.GA16582@palantir8> <20060120190415.GM19398@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 5AD0516F
	for <alsa-devel@alsa-project.org>; Fri, 20 Jan 2006 22:29:29 +0100 (MET)
Content-Disposition: inline
In-Reply-To: <20060120190415.GM19398@stusta.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Adrian Bunk <bunk@stusta.de>
Cc: benh@kernel.crashing.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, linuxppc-dev@ozlabs.org
List-Id: alsa-devel@alsa-project.org

 On Fri, Jan 20, Adrian Bunk wrote:

 
> Can someone from the ppc developers drop me a small note whether 
> SND_POWERMAC completely replaces DMASOUND_PMAC?

It doesnt. Some tumbler models work only after one plug/unplug cycle of
the headphone. early powerbooks report/handle the mute settings
incorrectly. there are likely more bugs.

-- 
short story of a lazy sysadmin:
 alias appserv=wotan


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
