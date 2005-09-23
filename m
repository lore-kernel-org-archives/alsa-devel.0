From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: 96KHz SPDIF output
Date: Fri, 23 Sep 2005 08:53:45 +0200 (METDST)
Message-ID: <Pine.HPX.4.33n.0509230853080.28663-100000@studcom.urz.uni-halle.de>
References: <4333271F.1080008@redfish-solutions.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mailgate.uni-halle.de (mailgate.urz.uni-halle.de [141.48.3.51])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 7ECBE164
	for <alsa-devel@alsa-project.org>; Fri, 23 Sep 2005 08:53:49 +0200 (MEST)
In-Reply-To: <4333271F.1080008@redfish-solutions.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Philip Prindeville <philipp_subx@redfish-solutions.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Philip Prindeville wrote:
> I was reading the datasheet on the VT1617A, that bit 3 (i.e. 0x0008) of
> register 0x76 (miscellaneous register) controls the SPDIF_96 mode...
>
> In this mode, the odd samples (N+1) go to SDATA_OUT1 (instead of
> SDATA_OUT)... which is supported if bit 1 (0x0002) is set when this
> register is read back (EN_DRA).
>
> And was wondering if it was fairly simple/straightforward to add
> support for this...

Good question.  Thank you for volunteering to find out!  ;-)


SCNR
Clemens



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
