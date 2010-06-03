From: Stuart Longland <redhatter@gentoo.org>
Subject: ASoC: Defining "signed integer" mixer controls?
Date: Thu, 03 Jun 2010 11:07:57 +1000
Message-ID: <hu6v9i$v43$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id EC318103A03
	for <alsa-devel@alsa-project.org>;
	Thu,  3 Jun 2010 03:40:04 +0200 (CEST)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1OJzPf-0002IZ-BC
	for alsa-devel@alsa-project.org; Thu, 03 Jun 2010 03:40:03 +0200
Received: from eth421.qld.adsl.internode.on.net ([150.101.181.164])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Thu, 03 Jun 2010 03:40:03 +0200
Received: from redhatter by eth421.qld.adsl.internode.on.net with local
	(Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Thu, 03 Jun 2010 03:40:03 +0200
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi all...

I'm posting this via GMane since my server at home seems to be down, 
hopefully it gets through.  I hope to put a version of the TLV320AIC3204 
driver that I've been working on up there -- I did try posting it to the 
list, but I suspect it's either been left in the moderation queue or 
silently dropped.  In short, I got the sound working; just testing 
playback for now... Recording should work, once I get the mixer set up.

My query though; the mixer on this CODEC provides gain settings, 
helpfully scaled in dB, as signed integers.  For instance; the four line 
level output drivers: Headphone left/right,and Line Out left/right, can 
all be adjusted in gain from -6dB through to +29dB.

These are set in individual registers as the lower 6 bits; so:
	-6 dB is represented as 111010 (0x3a)
	29 dB is represented as 011101 (0x1d)

At the moment, things "half work" with the following code:
/*
  * DAC digital volumes. From -63.5 to +24 dB in 0.5 dB steps
  */
static DECLARE_TLV_DB_MINMAX(dac_tlv, -6350, 2400);
/* ADC PGA gain volumes. From 0 to 59.5 dB in 0.5 dB steps */
static DECLARE_TLV_DB_MINMAX(adc_tlv, 0, 0);
/*
  * Output driver stage volumes; -6dB through to +29dB
  */
static DECLARE_TLV_DB_MINMAX(output_stage_tlv, -600, 2900);

static const struct snd_kcontrol_new aic3204_snd_controls[] = {
	/* Output */
	SOC_DOUBLE_R_TLV("Headphone Output Volume",
			 AIC3204_HPLGAIN, AIC3204_HPRGAIN,
			 0, 29, 0, output_stage_tlv),
	SOC_DOUBLE_R_TLV("Line Output Volume",
			 AIC3204_LOLGAIN, AIC3204_LORGAIN,
			 0, 29, 0, output_stage_tlv),
	SOC_DOUBLE_R_TLV("PCM Playback Volume",
			 AIC3204_LDACVOL, AIC3204_RDACVOL,
			 0, 127, 0, dac_tlv),
...

However; it treats the bitfield as unsigned, which is wrong in this 
case.  The bitfield is a signed integer in two's complement format.  How 
do I convince ALSA that these integers have a sign bit?

Regards,
Stuart Longland
