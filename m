From: Laurent Canet <lc@tekila.org>
Subject: HPPA Harmony driver
Date: Tue, 5 Nov 2002 10:39:55 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20021105103955.2f35f217.lc@tekila.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


Hi there,

I'm working on the ALSA port of a linux audio driver. This is for the harmony chipset, which is found in some HP PA/RISC workstations.
This chipset is relatively old (datasheets mentions 93), however it supports 16bit 48Khz stereo playback & recording. 
The driver already exists in the 2.4 linux kernel, but to comply with plans for 2.6 kernel, we wish to switch it in an ALSA form.

I've converted most of the code (which still needs to be tested and debugged) to alsa 0.9, using dummy.c as a skeleton. 
I have a question:
- What is exactly the pointer function, what does it returns (in normal operation) ?


Thank you in advance.

(I'm sorry, due to badly configured mua, I send many bad mails to ml moderators, shame on me! :) )

--
Laurent Canet
PA/Linux ESIEE Team
http://pateam.esiee.fr




-------------------------------------------------------
This sf.net email is sponsored by: See the NEW Palm 
Tungsten T handheld. Power & Color in a compact size!
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0001en
