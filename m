From: Bryan Green <bryan.d.green@nasa.gov>
Subject: Re: no audio output with TYAN S7025 motherboard and
	Realtek ALC262
Date: Wed, 10 Mar 2010 19:37:56 +0000 (UTC)
Message-ID: <loom.20100310T201304-875@post.gmane.org>
References: <20100303185454.4D36231781@vis06.nas.nasa.gov>
	<1267694159.9133.7.camel@mattotaupa>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 5090D243DE
	for <alsa-devel@alsa-project.org>; Wed, 10 Mar 2010 20:40:04 +0100 (CET)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1NpRlC-0000Iq-P9
	for alsa-devel@alsa-project.org; Wed, 10 Mar 2010 20:40:03 +0100
Received: from vis06.nas.nasa.gov ([129.99.125.6])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Wed, 10 Mar 2010 20:40:02 +0100
Received: from bryan.d.green by vis06.nas.nasa.gov with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Wed, 10 Mar 2010 20:40:02 +0100
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

Hi Paul,

Paul Menzel <paulepanter <at> users.sourceforge.net> writes:
> 
> Dear Bryan,
> 
> Am Mittwoch, den 03.03.2010, 10:54 -0800 schrieb Bryan Green:
> > I have several systems with a TYAN S7025 motherboard and Realtek ALC262 
> > chipset.
> > I have not been able to produce any audio output.  Well, that is except
> > for
> > one of the systems: after a variety of tweeks and tests, I got sound
> > working
> > on one system, but I do not know what change enabled sound to start
> > working,
> > and I have not been able to reproduce the effect on the other systems.
> 
> Can you give list of what tweeks you did (even incomplete).

I tried changing the 'model' setting several times, before reverting back
to the default.  I reran 'alsaconf' several times in the process, and
occasionally noticed changes to the set of mixer elements listed by
alsamixer.  Sometimes a "PCM" element would be present, other times not.  I
also upgraded t the kernel from 2.6.31 to 2.6.32.  While in 2.6.32, with
the default 'model' setting (i.e.  auto), I was in the alsamixer and
unmuted one of the elements - I think it was the "Front Mic" element.
Suddenly, audio started working.  I then muted all the mixer elements
except master and maybe PCM (if PCM was present at the time).  Audio
remained working.  I booted back into 2.6.31.  Audio still worked.  I
couldn't get it to stop working at that point, in order to try to reproduce
the original problem.  I also was not able to reproduce success on the
other systems with the same hardware.


> 
> Have you tried different values for the model parameter [1]? If I am not
> mistaken you can use HDA-Analyzer [2] to change such values. But I never
> used it myself.

I tried a few values for 'model'.  I have not tried HDA-Analyzer.  I had
hoped to avoid going in that deep.

Thanks,

-bryan
