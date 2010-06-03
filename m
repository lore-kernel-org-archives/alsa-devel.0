From: Stuart Longland <redhatter@gentoo.org>
Subject: Re: ASoC: Defining "signed integer" mixer controls?
Date: Thu, 3 Jun 2010 20:33:22 +1000
Message-ID: <20100603103322.GB3662@www.longlandclan.yi.org>
References: <hu6v9i$v43$1@dough.gmane.org>
 <4C0766EC.3090708@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from helicon.mas.viperplatform.net.au
	(helicon.mas.viperplatform.net.au [202.147.75.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 4916F103ACD
	for <alsa-devel@alsa-project.org>;
	Thu,  3 Jun 2010 17:11:25 +0200 (CEST)
Received: from eryx.mas.viperplatform.net.au ([172.16.5.11])
	by helicon.mas.viperplatform.net.au with esmtp (Exim 4.43)
	id 1OKC4n-0007bq-DW
	for alsa-devel@alsa-project.org; Fri, 04 Jun 2010 01:11:21 +1000
Received: from mail by eryx.mas.viperplatform.net.au with spam-scanned (Exim
	4.43) id 1OKC4n-0001AZ-5Q
	for alsa-devel@alsa-project.org; Fri, 04 Jun 2010 01:11:21 +1000
Received: from [172.16.100.13] (helo=helicon.mas.viperplatform.net.au)
	by eryx.mas.viperplatform.net.au with esmtp (Exim 4.43)
	id 1OKB8H-0001GN-Qs
	for alsa-devel@alsa-project.org; Fri, 04 Jun 2010 00:10:53 +1000
Received: from [203.94.56.252] (helo=longlandclan.yi.org)
	by helicon.mas.viperplatform.net.au with esmtp (Exim 4.43)
	id 1OK7jn-0004Bv-BZ
	for alsa-devel@alsa-project.org; Thu, 03 Jun 2010 20:33:23 +1000
Content-Disposition: inline
In-Reply-To: <4C0766EC.3090708@ladisch.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Jun 03, 2010 at 10:25:16AM +0200, Clemens Ladisch wrote:
> Stuart Longland wrote:
> > /* ADC PGA gain volumes. From 0 to 59.5 dB in 0.5 dB steps */
> > static DECLARE_TLV_DB_MINMAX(adc_tlv, 0, 0);
> 
> The comment is wrong, this control goes from 0 to 0 dB.
> 
> > 	SOC_DOUBLE_R_TLV("PCM Playback Volume",
> > 			 AIC3204_LDACVOL, AIC3204_RDACVOL,
> > 			 0, 127, 0, dac_tlv),
> > 
> > However; it treats the bitfield as unsigned, which is wrong in this
> > case.  The bitfield is a signed integer in two's complement format.  How
> > do I convince ALSA that these integers have a sign bit?
> 
> ALSA's controls use signed values, it's the SOC_ macros that assume
> bitfields.  You should be able to define a control with your own
> callbacks like in a non-ASoC driver.

Ahh okay... makes sense... I'll have a closer look; perhaps some
additional macros could be written to allow use of signed integer
bitfields as well.  I'm sure the TLV320AIC3204 is not the only CODEC
that uses such beasts.
-- 
Stuart Longland (aka Redhatter, VK4MSL)      .'''.
Gentoo Linux/MIPS Cobalt and Docs Developer  '.'` :
. . . . . . . . . . . . . . . . . . . . . .   .'.'
http://dev.gentoo.org/~redhatter             :.'

I haven't lost my mind...
  ...it's backed up on a tape somewhere.
