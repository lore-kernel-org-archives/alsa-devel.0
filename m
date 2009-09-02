From: Elimar Riesebieter <riesebie@lxtec.de>
Subject: Re: [Pkg-alsa-devel] Bug#544607:
 /usr/share/alsa/init/default:52: missing closing brace for format
Date: Wed, 2 Sep 2009 14:29:15 +0200
Message-ID: <20090902122915.GB4978@frodo.home.lxtec.de>
References: <20090901202614.5849.99958.reportbug@base.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpout0.hostsharing.net (smtpout0.hostsharing.net
	[83.223.95.250]) by alsa0.perex.cz (Postfix) with ESMTP id 5D3F7245C4
	for <alsa-devel@alsa-project.org>;
	Wed,  2 Sep 2009 14:29:22 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20090901202614.5849.99958.reportbug@base.lan>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Philipp Jocham <philipp.jocham@gmx.net>, 544607@bugs.debian.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

forward 544607 alsa-devel@alsa-project.org
thanks


* Philipp Jocham [090901 22:26 +0200]
> Package: alsa-utils
> Version: 1.0.20-2
> Severity: normal
> 
> 
> $ alsactl init
> Unknown hardware: "HDA-Intel" "Analog Devices AD1884" "HDA:11d41884,103c3029,00100100" "0x103c" "0x3029"
> Hardware is initialized using a guess method
> /usr/share/alsa/init/default:51: control element not found
> /usr/share/alsa/init/default:52: missing closing brace for format
> /usr/share/alsa/init/default:52: error parsing CTL attribute
> /usr/share/alsa/init/default:52: invalid rule
> 
> It's just a small typo:
> diff -r -U1 alsa-utils-1.0.20/alsactl/init/default alsa-utils-1.0.20.1/alsactl/init/default
> --- alsa-utils-1.0.20/alsactl/init/default	2009-05-06 09:07:24.000000000 +0200
> +++ alsa-utils-1.0.20.1/alsactl/init/default	2009-09-01 22:13:16.832163534 +0200
> @@ -51,3 +51,3 @@
>  ENV{has_pmaster_vol}=="true",CTL{values}="0dB",RESULT=="0",GOTO="headphone0_end"
> -ENV{has_pmaster_vol}=="true",CTL{values)="100%",GOTO="headphone0_end"
> +ENV{has_pmaster_vol}=="true",CTL{values}="100%",GOTO="headphone0_end"
>  CTL{values}="$env{pvolume}",RESULT!="0",CTL{values}="$env{ppercent}"
> 
> Sound was very quiet per default. 
> 
> Regards,
> Philipp

Thanks a lot! will be patched at Debian 1.0.21 upload and hopefully
recognized by alsa-devel ;-)

Elimar


-- 
  We all know Linux is great... it does infinite loops in 5 seconds.
        -- Linus Torvalds
