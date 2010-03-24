From: Bryan Green <bryan.d.green@nasa.gov>
Subject: Re:
	=?utf-8?q?no_audio_output_with_TYAN_S7025_motherboar?=
	=?utf-8?q?d_and=09Realtek_ALC262?=
Date: Wed, 24 Mar 2010 18:26:13 +0000 (UTC)
Message-ID: <loom.20100324T191745-418@post.gmane.org>
References: <20100303185454.4D36231781@vis06.nas.nasa.gov>
	<1267694159.9133.7.camel@mattotaupa>
	<loom.20100310T201304-875@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 0BC8C10388E
	for <alsa-devel@alsa-project.org>; Wed, 24 Mar 2010 19:26:40 +0100 (CET)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1NuVHr-0005Hm-FG
	for alsa-devel@alsa-project.org; Wed, 24 Mar 2010 19:26:39 +0100
Received: from vis06.nas.nasa.gov ([129.99.125.6])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Wed, 24 Mar 2010 19:26:39 +0100
Received: from bryan.d.green by vis06.nas.nasa.gov with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Wed, 24 Mar 2010 19:26:39 +0100
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


Bryan Green <bryan.d.green <at> nasa.gov> writes:
> 
> Paul Menzel <paulepanter <at> users.sourceforge.net> writes:
> > 
> > Am Mittwoch, den 03.03.2010, 10:54 -0800 schrieb Bryan Green:
> > > I have several systems with a TYAN S7025 motherboard and Realtek ALC262
> > > chipset.  I have not been able to produce any audio output.
> > > ...
> > 
> > Have you tried different values for the model parameter [1]? If I am not
> > mistaken you can use HDA-Analyzer [2] to change such values. But I never
> > used it myself.
> 
> I tried a few values for 'model'.  I have not tried HDA-Analyzer.  I had
> hoped to avoid going in that deep.
> 
> Thanks,
> 
> -bryan
> 


I've found that the 'hp-bpc' model works for this motherboard/chip.

At least one key factor seems to be the line_out value of '0x1b', rather than
'0x14', which it had been defaulting to when model was 'auto'.

-bryan
