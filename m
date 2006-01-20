From: Erik Andersen <andersen@codepoet.org>
Subject: Re: RFC: OSS driver removal, a slightly different approach
Date: Thu, 19 Jan 2006 19:55:13 -0700
Message-ID: <20060120025513.GA2438@codepoet.org>
References: <20060119174600.GT19398@stusta.de> <m3ek34vucz.fsf@defiant.localdomain> <1137709308.8471.77.camel@localhost.localdomain> <20060119224501.GC19398@stusta.de>
Reply-To: andersen@codepoet.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from codepoet.org (codepoet.org [166.70.99.138])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 245D2114
	for <alsa-devel@alsa-project.org>; Fri, 20 Jan 2006 03:55:16 +0100 (MET)
Content-Disposition: inline
In-Reply-To: <20060119224501.GC19398@stusta.de>
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
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Krzysztof Halasa <khc@pm.waw.pl>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, perex@suse.cz
List-Id: alsa-devel@alsa-project.org

On Thu Jan 19, 2006 at 11:45:01PM +0100, Adrian Bunk wrote:
> config SOUND_WAVEARTIST
>         tristate "Netwinder WaveArtist"
>         depends on ARM && SOUND_OSS && ARCH_NETWINDER
>         help
>           Say Y here to include support for the Rockwell WaveArtist sound
>           system.  This driver is mainly for the NetWinder.

I own two netwinders (strongArm SA110) and I would be glad to
fire them up to test things if someone feels like writing a
driver....

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
