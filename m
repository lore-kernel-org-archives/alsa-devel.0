From: "Rao, Nikhil" <nikhil.rao@intel.com>
Subject: Driver/ALSA  instrumentation
Date: Sat, 7 Aug 2004 08:57:59 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <012676D607FCF54E986746512C22CE7DE40C53@orsmsx407>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from caduceus.jf.intel.com (fmr06.intel.com [134.134.136.7])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id D9A511F4
	for <alsa-devel@alsa-project.org>; Sat,  7 Aug 2004 17:58:02 +0200 (MEST)
Received: from petasus.jf.intel.com (petasus.jf.intel.com [10.7.209.6])
	by caduceus.jf.intel.com (8.12.9-20030918-01/8.12.9/d: major-outer.mc,v 1.15 2004/01/30 18:16:28 root Exp $) with ESMTP id i77Fv4Bq020493
	for <alsa-devel@alsa-project.org>; Sat, 7 Aug 2004 15:57:04 GMT
Received: from orsmsxvs040.jf.intel.com (orsmsxvs040.jf.intel.com [192.168.65.206])
	by petasus.jf.intel.com (8.12.9-20030918-01/8.12.9/d: major-inner.mc,v 1.11 2004/07/29 22:51:53 root Exp $) with SMTP id i77G0266022507
	for <alsa-devel@alsa-project.org>; Sat, 7 Aug 2004 16:00:14 GMT
Received: from orsmsx331.amr.corp.intel.com ([192.168.65.56])
 by orsmsxvs040.jf.intel.com (SAVSMTP 3.1.2.35) with SMTP id M2004080708575919596
 for <alsa-devel@alsa-project.org>; Sat, 07 Aug 2004 08:57:59 -0700
Content-class: urn:content-classes:message
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


Hi All,

I have an audio decoder application that plays out to the soundcard. I
want to measure any underruns that occur as the application is playing
out to the soundcard. I suppose the interrupt handler for DMA sets up
the transfer from the=20
driver buffer to the hardware. If I record a time stamp whenever the DMA
is unable to set up a transfer because
there is no data available (dma_timestamp) and then also record a
timestamp when the application does a write()..
(write_timestamp). The difference (write_timestamp-dma_timestamp) will
provide me with the underrun duration.

If this technique sounds reasonable, In the ALSA code, how do I measure
the amount of data(no of frames) available for the DMA transfer ? I have
looked at the code, I haven't been able to figure out the details!

Looks like the relevant code starts somewhere here=20

snd_pcm_update_hw_ptr()..

Please let me if you any suggestions/pointers.

Thanks,
-Nikhil


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
