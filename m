From: <pradeep.gane@wipro.com>
Subject: Question on Interrupt Handling...
Date: Mon, 10 Oct 2005 19:19:38 +0530
Message-ID: <D6DA3A176076B2408E53467FC0B0056B018CB490@BLR-EC-MBX04.wipro.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-class: urn:content-classes:message
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

I am using the mmap feature of ALSA framework (without PCI DMA). I am
expecting an interrupt after data of scheduled size is transferred by
the hardware. I am supposed to call the snd_pcm_period_elapsed() API in
the interrupt handler.=20

My questions are...

1 - Is the snd_pcm_period_elapsed call sufficient for my driver?=20
2 - How are error conditions like under-run and over-run supposed to be
passed to the higher layers? Should I call snd_pcm_period_elapsed in
this case as well?

Thanks very much in advance.

Best Regards,
Pradeep


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
