From: Orm Finnendahl <finnendahl@folkwang-hochschule.de>
Subject: hdsp/firmware problem
Date: Fri, 14 Feb 2003 13:06:58 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030214120658.GE1169@finnendahl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: Simon de Bakker <sim@z2.v2.nl>
List-Id: alsa-devel@alsa-project.org

Hi,

the hdsp driver still seems to have problems with the new pci
card. It's a little complicated for me to give exact information as
the machine is in Rotterdam and I'm in Berlin. I got The following
email from the sysadmin of the machine:

> Hi Orm,
> 
> The driver seems to load ok except it fails when loading the firmware. 
> The lights flicker as you described but I get the messages:
> - loading firmware
> - wait for fifo status <= 0 failed after 100 iterations
> - wait for fifo status <= 0 failed after 40000 iterations
> - timeout at end of firmware loading
> - RME Hammerfall-DSP no cards found
> 
> if I try to load the driver afterwards it does not try to upload the
> firmware and so no complaints:
> - I/O Box is a Multiface
> 
> But I can't get any sound out of the box (use headphone in line out) and
> setting all channels to 30 in alsamixer.
> Probably because the firmware was not loaded correctly.
> 
> Simon

Could that be related to the new revision (0xb) of the firmware?

--
Orm


-------------------------------------------------------
This SF.NET email is sponsored by: FREE  SSL Guide from Thawte
are you planning your Web Server Security? Click here to get a FREE
Thawte SSL guide and find the answers to all your  SSL security issues.
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0026en
