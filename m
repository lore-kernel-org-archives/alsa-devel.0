From: Jeremy Nickurak <alsa-devel@atrus.rifetech.com>
Subject: Non-functional Altec Lansing FX5051 USB-soundcard +
	speakers
Date: Sun, 9 Nov 2008 21:09:34 -0700
Message-ID: <20081110040933.GA29870@katran.rifetech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from spunkymail-a2.g.dreamhost.com (sd-green-bigip-66.dreamhost.com
	[208.97.132.66])
	by alsa0.perex.cz (Postfix) with ESMTP id CAA5A103827
	for <alsa-devel@alsa-project.org>; Mon, 10 Nov 2008 05:09:37 +0100 (CET)
Received: from kedri (S0106001ee57a9819.ed.shawcable.net [68.149.183.24])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by spunkymail-a2.g.dreamhost.com (Postfix) with ESMTP id 96A1D870F6
	for <alsa-devel@alsa-project.org>; Sun,  9 Nov 2008 20:09:35 -0800 (PST)
Received: from atrus by kedri with local (Exim 4.69)
	(envelope-from <atrus@katran.rifetech.com>) id 1KzO5m-0007tN-DM
	for alsa-devel@alsa-project.org; Sun, 09 Nov 2008 21:09:34 -0700
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
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

About 14 months ago I purchased a nice new ~$300 set of altec lansing 
5.1 speakers, which include a USB-sound card. Since that time they've 
largely gone unused, or at least not properly used. I brought this up on 
the mailing list at the time, but didn't get much response, so I thought 
I'd poke my head up again and see if anybody has any insight.

First off, the set works correctly, out-of-the-box under windows, 
without having to install any special drivers or software at all.

Under linux, plugging them in instantly freezes the usb sound card up, 
and locks it at 100% volume, in such a way that there's absolutely no 
way to turn the volume down: not from alsamixer, and not from the 
speaker's hardware control dial. Sound does play, but again, it's 
unbearably loud, to the point where I don't do it for risk of damaging 
my speakers and/or ears.

I filed the bug away on the bug-tracker, but haven't heard much out of 
it since. The bug contains my lsusb -v information, the "contents" 
output from amixer for this card, and some preliminary results showing 
some ability to tweak the volume with amixer, but not reliably.

Any suggestions are welcome. I'm happy to experiment with this set more 
if it can help, run experimental code, etc. Heck, I'd go at the thing 
with a screwdriver for chipset information if I know what I was looking 
for or thought it could help.
