From: Lennart Poettering <mznyfn@0pointer.de>
Subject: how is 'dir' in snd_pcm_hw_params_set_periods_near()
	supposed to	work?
Date: Mon, 8 Sep 2008 22:28:08 +0200
Message-ID: <20080908202808.GB5221@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id 220B224391
	for <alsa-devel@alsa-project.org>;
	Mon,  8 Sep 2008 22:28:09 +0200 (CEST)
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

How is the 'dir' argument in snd_pcm_hw_params_set_periods_near()
supposed to work?

I'd assume that passing dir=1 would mean that it is looked for a
number of periods that is greater *or equal* to what we request. If we
pass dir=-1 we'd be looking for a number of periods that is smaller
*or equal* to what we request. 

However, what I am experiencing is that there is no "or equal". On my
softvol on hda setup here if I ask for 5 periods I will always get 6
if I pass dir=1 -- even if the could give me 5 and will give me five
if I pass dir=0.

The docs don't really elaborate on this much. 

I'd certainly think that having ">=" and "<=" here is much more useful
and natural than ">" and "<", and hence I was wondering: is this just
a bug in the software or is it really intended to be this way?

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net         ICQ# 11060553
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
