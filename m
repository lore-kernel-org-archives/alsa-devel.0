From: <ext-Eero.Nurkkala@nokia.com>
Subject: Re: [RFC 3/4] OMAP3: McBSP: Add interface for transmit
 FIFO state query
Date: Wed, 3 Mar 2010 20:07:21 +0100
Message-ID: <1FFEF31EBAA4F64B80D33027D42977602148968E69@NOK-EUMSG-02.mgdnok.nokia.com>
References: <1267537191-25254-1-git-send-email-peter.ujfalusi@nokia.com>
	<1267596472.24345.16.camel@eenurkka-desktop>
	<20100303090324.83d076b6.jhnikula@gmail.com>,
	<201003031202.48598.peter.ujfalusi@nokia.com>,
	<1FFEF31EBAA4F64B80D33027D42977602148968E68@NOK-EUMSG-02.mgdnok.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id 269B910396C
	for <alsa-devel@alsa-project.org>; Wed,  3 Mar 2010 20:12:11 +0100 (CET)
In-Reply-To: <1FFEF31EBAA4F64B80D33027D42977602148968E68@NOK-EUMSG-02.mgdnok.nokia.com>
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
To: ext-Eero.Nurkkala@nokia.com, peter.ujfalusi@nokia.com, jhnikula@gmail.com
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org



> what went wrong? (the pcm pointer w/dma pos never missed that
> greatly)
> Very unlikely that an IRQ just happened to come in between the
> register reads..with that frequency (> 1/50)

Just to make sure:

+void omap_mcbsp_buffstat(unsigned int id, unsigned int *xbuffstat,
+				unsigned int *rbuffstat)
+{
+	struct omap_mcbsp *mcbsp;
+
+	if (!(cpu_is_omap2430() || cpu_is_omap34xx()))
+		return;
+
+	if (!omap_mcbsp_check_valid_id(id)) {
+		printk(KERN_ERR "%s: Invalid id (%d)\n", __func__, id + 1);
+		return;
+	}
+
+	mcbsp = id_to_mcbsp_ptr(id);
+	*xbuffstat = OMAP_MCBSP_READ(mcbsp->io_base, XBUFFSTAT);
+	*rbuffstat = OMAP_MCBSP_READ(mcbsp->io_base, RBUFFSTAT);
+}

see, the above is not trusted. However, it's 100% trusted to read off
the timestamps recorded at DMA IRQ callback. (and at that time the buffer
has just been filled up.).


- Eero
