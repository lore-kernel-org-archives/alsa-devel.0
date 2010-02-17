From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Latency of mixer reconfiguration
Date: Wed, 17 Feb 2010 19:15:30 +0100
Message-ID: <20100217181530.GA23152@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id AABFC243EF
	for <alsa-devel@alsa-project.org>; Wed, 17 Feb 2010 19:15:58 +0100 (CET)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Heya!

So, as some of you might know in PA we extend the abilities of the
hardware volume control in software. Meaning that if a hw mixer
control only allows a limited range or granularity of a volume scale
or does not distuingish between channels then PA will configure the
hardware to the next higher available setting of the real
volume it wants to achieve, and then attenuates the PCM stream to
compensate for the rest.

This actually works quite well but there is a certain probelm with
latency: i.e. the mixer setting will be applied at a slightly
different time than the PCM attenuation. 

Now the question I have is, how should I best deal with this? I
currently assume that mixer volume changes are basically instantaneous
when I call the respective function of ALSA. But are they really? How
big is the latency at max? Do we need an API to query it?

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
