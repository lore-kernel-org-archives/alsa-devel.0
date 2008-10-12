From: "Blacky (alsa-devel)" <alsa-devel@blackdog.shacknet.nu>
Subject: Status of HDMI on Nvidia 10de:0774 device (Asus M3N-H
	HDMI
Date: Mon, 13 Oct 2008 00:47:14 +1100
Message-ID: <assp.11714b3fa6.59BA8640D0DC924897A613C8240D88390442B4@vex.jingella.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from jingella.dyndns.org (unknown [124.189.101.81])
	by alsa0.perex.cz (Postfix) with ESMTP id B45F32459F
	for <alsa-devel@alsa-project.org>;
	Sun, 12 Oct 2008 15:47:34 +0200 (CEST)
Received: from dalmatian.dnsdojo.net (localhost.localdomain [127.0.0.1])
	by jingella.dyndns.org (8.13.8/8.13.8) with ESMTP id m9CDlFGo018708
	for <alsa-devel@alsa-project.org>; Mon, 13 Oct 2008 00:47:15 +1100
Content-class: urn:content-classes:message
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

 

Hi all,

 

I am using the above model (MB Asus M3N-H/HDMI) and attempting to use
the latest

patches for nvhdmi. (By latest, I just checked them from CVS today, and
they seem

to be very recent.. very bleeding edge)

 

Do they support the 10de:0774 device?  The source matches them against
0x10de0004, but

I've not been able to identify if it is matching or not. (There are mask
values in there which

I've not worked out yet).

 

So far, I've failed abysmally at getting HDMI (audio) output on the
above mentioned MB.

 

Can anyone tell me if the code is even there to support it?  I'm
starting to suspect it

isn't.

 

 

I'll follow up with details (aplay -L / -l, asoundconf and other details
if there is interest.)

 

Getting the HDMI audio working will be the final piece of the puzzle
stopping me from putting

the new system into the living room as a working mythtv box.  

 

Regards

Blacky
