From: Thierry Vignaud <tvignaud@mandrakesoft.com>
Subject: Re: support for PCI_DEVICE_ID_INTEL_ICH6_15
Date: Tue, 23 Nov 2004 12:50:14 +0100
Message-ID: <m2zn18vl6x.fsf@vador.mandrakesoft.com>
References: <419F7E9F.6040807@ens-lyon.fr>
	<1100975509.6879.31.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1100975509.6879.31.camel@krustophenia.net> (Lee Revell's
 message of "Sat, 20 Nov 2004 13:31:48 -0500")
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>, Takashi Iwai <tiwai@suse.de>
Cc: Brice.Goglin@ens-lyon.org, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Lee Revell <rlrevell@joe-job.com> writes:

> Sorry I missed the 'HD Audio' part.  I think you want the 'azx' driver:
> 
> http://sourceforge.net/mailarchive/message.php?msg_id=8912810
> 
> AFAIK Intel posted this driver and it was committed to CVS but we have
> no user feedback yet.  So it should be considered experimental, though
> it should work.  It would be good to know how it works...

no it didn't.

from my locally cvs2cl-generated changelog:

(...)

2004-07-28 16:55  tiwai

        * doc/azx.txt, pci/Kconfig, pci/Makefile: Added Intel ICH6 HD Audio
          (Azalia) driver.

(...)

the actual driver is currently missing from CVS...



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
