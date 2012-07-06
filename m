From: Zhen Fu <fuzh@marvell.com>
Subject: then there was "overrun" occue every time once trigger
 the audio recording
Date: Fri, 6 Jul 2012 03:00:00 -0700
Message-ID: <DBBC59900F0EF340B9938F193FB1A3453625BD3E@SC-VEXCH4.marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog113.obsmtp.com (na3sys009aog113.obsmtp.com
	[74.125.149.209])
	by alsa0.perex.cz (Postfix) with ESMTP id 87431103F67
	for <alsa-devel@alsa-project.org>;
	Fri,  6 Jul 2012 12:00:45 +0200 (CEST)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Zhen Fu <fuzh@marvell.com>
List-Id: alsa-devel@alsa-project.org

Hi Clemens,



Your answer is very useful to help me. Thank you very much.



>     case AUDIO_STREAM_CMDID_DATARXTXREQ:

>           len1 = get_zsp_buf_avail(&prtd->zsp_buf);

>           len2 = get_fw_avail(p_zsp_req, substream->stream);

>           len3 = get_buf_avail(&prtd->zsp_buf, substream->stream);

>           tsize = ((len1 < len2) ? len1 : len2);

>           if ((tsize == len1) && (len1 == len3) && (tsize >= \

>                 2 * prtd->zsp_buf.zsp_period_bytes)) {

>                 tsize -= prtd->zsp_buf.zsp_period_bytes;

>           }



>     This doesn't look as if tsize is always the same as the period size.

>     And what do the get_fw_avail and get_buf_avail functions do?



The ZSP have own buffer to save data, so get_fw_avail is acquired zsp buf avial.

And ZSP buffer must ensure the zsp_buf have sequenced, so do above process.

--
Best Regards,
Zhen Fu
