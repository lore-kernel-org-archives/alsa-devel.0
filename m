From: Jurgen Kramer <gtmkramer@xs4all.nl>
Subject: Re: [PATCH] add native DSD support for XMOS based DACs.
Date: Fri, 05 Sep 2014 13:01:03 +0200
Message-ID: <1409914863.2959.3.camel@xs4all.nl>
References: <1409906971-3365-1-git-send-email-gtmkramer@xs4all.nl>
 <54098410.6050103@ladisch.de> <1409910794.2959.1.camel@xs4all.nl>
 <54099072.3040202@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-vbr14.xs4all.nl (smtp-vbr14.xs4all.nl [194.109.24.34])
 by alsa0.perex.cz (Postfix) with ESMTP id BFFEF261A2C
 for <alsa-devel@alsa-project.org>; Fri,  5 Sep 2014 13:01:04 +0200 (CEST)
In-Reply-To: <54099072.3040202@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, 2014-09-05 at 12:29 +0200, Clemens Ladisch wrote:
> Jurgen Kramer wrote:
> > On Fri, 2014-09-05 at 11:36 +0200, Clemens Ladisch wrote:
> >> Jurgen Kramer wrote:
> >>> Add quirk for XMOS based DACs for native DSD playback support using the new DSD_U32_LE sample
> >>> format. Works for all DAC vendors which use XMOS as idVendor. E.g. iFi Audio
> >>> with their micro iDSD and nano iDSD.
> >>>
> >>> +++ b/sound/usb/quirks.c
> >>> +	/* XMOS based DACs, e.g. iFi Audio micro/nano iDSD */
> >>> +	if (le16_to_cpu(chip->dev->descriptor.idVendor) == 0x20b1) {
> >>> +		switch (fp->altsetting) {
> >>> +		case 2:
> >>> +			return SNDRV_PCM_FMTBIT_DSD_U32_LE;
> >>
> >> Can you confirm that all XMOS devices ever built will have DSD on that
> >> alternate setting?
> >
> > No, I can not. Most newer implementations will use alt setting 2 for
> > native DSD support.
> 
> But it's possible to have other XMOS-based devices that use multiple
> alternate settings for PCM.
Correct. So it will be better to make the quirks vendor/device specific.
Downside being that each device has be added. I'll rework my patch.

> 
> > My first version also used idProduct to only target iFi devices. If
> > this is required, I'll rework my patch.
> 
> I guess there isn't any property of the descriptors to distinguish DoP
> from PCM?  How does the generic Windows driver know which alternate
> settings are DoP?
Indeed. Unfortunately DoP support is not exposed in any way. That is why
the quirks mechanism was added to the kernel.
Windows still does not support UAC2 out of the box. For XMOS based
devices support comes through the commercial Thesycon driver. Each
vendor uses a tailored version specific for their devices.

Native DSD support on Windows works through Steinbergs ASIO 2.1/2.2
driver. This has to be supported by the Windows UAC2 driver.

Regards,
Jurgen
