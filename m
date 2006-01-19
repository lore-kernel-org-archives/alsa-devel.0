From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: RFC: OSS driver removal, a slightly different approach
Date: Thu, 19 Jan 2006 21:28:27 +0000
Message-ID: <1137706107.8471.44.camel@localhost.localdomain>
References: <20060119174600.GT19398@stusta.de>
	 <1137694944.32195.1.camel@mindpipe>  <20060119182859.GW19398@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.perex.cz (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D3CCD141
	for <alsa-devel@alsa-project.org>; Thu, 19 Jan 2006 22:40:21 +0100 (MET)
Received: from lxorguk.ukuu.org.uk (unknown [81.2.110.250])
	by gate.perex.cz (Perex's E-mail Delivery System) with ESMTP id 385EC957F2
	for <alsa-devel@alsa-project.org>; Thu, 19 Jan 2006 22:40:21 +0100 (MET)
In-Reply-To: <20060119182859.GW19398@stusta.de>
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
Cc: Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, perex@suse.cz
List-Id: alsa-devel@alsa-project.org

On Iau, 2006-01-19 at 19:28 +0100, Adrian Bunk wrote:
> > ALSA certainly does support "100% Sound Blaster compatibles (SB16/32/64,
> > ESS, Jazz16)", it would be a joke if it didn't...
> 
> That's not the problem, I should have added an explanation:


OSS supports several "not quite compatibles", notably Cyrix 55x0 systems
where the SB firmware blows up on 64/128K transfers. 


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
