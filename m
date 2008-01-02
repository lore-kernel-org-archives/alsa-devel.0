From: forumjunk@comcast.net (Darryl House)
Subject: Re:
	snd-hda-intel	support	for	SPDIF-in	wiht	vt1708	card?
Date: Wed, 02 Jan 2008 22:31:19 +0000
Message-ID: <010220082231.20107.477C10B700065FCA00004E8B220702105305029A06039A9D0100@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from QMTA05.westchester.pa.mail.comcast.net
	(qmta05.westchester.pa.mail.comcast.net [76.96.62.48])
	by alsa0.perex.cz (Postfix) with ESMTP id A4940243FF
	for <alsa-devel@alsa-project.org>; Wed,  2 Jan 2008 23:31:22 +0100 (CET)
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
Cc: tiwai@suse.de, john@stilen.com
List-Id: alsa-devel@alsa-project.org


 -------------- Original message ----------------------
[...]
> > I'd like to get this card's spdif working.  What else can I do to help?
> > Although the driver loads, the user space tools can't use the card any
> > more.  Thank you.
> > 
> Should I assume at this point no more work will be done on the
> snd-hda-intel driver to fixing SPDIF-in for the vt1708 sound card?
> Thank you for all your work so far.
> 

I think it is a bit early to make that assumption. There isn't a lot of demand for this particular card, but it doesn't seem that it will take too much work to get it going again... after all, it did basically work before the last patch, and I am hoping that Takashi will find some time soon to address the issues. As of this moment, I assume you're in the same boat I'm in, where the user space tools report an inappropriate ioctl for the device.

-- Darryl
