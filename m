From: Axel Schmidt <axel@assoftware.de>
Subject: Re: alsa patch for Fantom G
Date: Thu, 26 May 2011 16:52:56 +0000 (UTC)
Message-ID: <loom.20110526T183600-277@post.gmane.org>
References: <4D91DF19.1060903@assoftware.de>
	<alpine.LNX.2.00.1103291544260.4805@eeebox2.perex-int.cz>
	<4D933371.8000402@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id BC5CC103810
	for <alsa-devel@alsa-project.org>;
	Thu, 26 May 2011 18:55:15 +0200 (CEST)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1QPdpy-0002nf-SJ
	for alsa-devel@alsa-project.org; Thu, 26 May 2011 18:55:06 +0200
Received: from statdsl-085-016-071-110.ewe-ip-backbone.de ([85.16.71.110])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Thu, 26 May 2011 18:55:06 +0200
Received: from axel by statdsl-085-016-071-110.ewe-ip-backbone.de with local
	(Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Thu, 26 May 2011 18:55:06 +0200
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

Clemens Ladisch <clemens <at> ladisch.de> writes:

> 
> Jaroslav Kysela wrote:
> > On Tue, 29 Mar 2011, Axel Schmidt wrote:
> > > I've seen a simple patch that should make the Roland Fantom G working.
> > > http://www.mail-archive.com/alsa-user <at> lists.sourceforge.net/msg23584.html
> > 
> > Clemens, does the patch looks reasonable?
> 
> Yes.
> 
> It would be nice to know which MIDI ports are which so that the port
> names can be added to the driver.
> 
> Regards,
> Clemens
> 

Hello Clemens,

sorry for my late responce.

There is only one Midiport. I think "FANTOM-G" is a good name.
I've change the following code of this patch:

.out_cables = 0x0001,
.in_cables  = 0x0001

Audio is not working with this patch. And I've no idea why.
But MIDI is better than nothing.

Regards
Axel
 
