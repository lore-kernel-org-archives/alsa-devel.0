From: Rene Herman <rene.herman@keyaccess.nl>
Subject: 2.6.9: snd-cs46xx
Date: Wed, 20 Oct 2004 02:22:19 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <4175AFBB.6090501@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from smtpq1.home.nl (smtpq1.home.nl [213.51.128.196])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 273D22A9
	for <alsa-devel@alsa-project.org>; Wed, 20 Oct 2004 02:26:43 +0200 (MEST)
Received: from [213.51.128.132] (port=55714 helo=smtp1.home.nl)
	by smtpq1.home.nl with esmtp (Exim 4.30)
	id 1CK4JO-00012Q-Nh
	for alsa-devel@alsa-project.org; Wed, 20 Oct 2004 02:26:42 +0200
Received: from cc334381-a.groni1.gr.home.nl ([82.74.248.238]:32988 helo=[192.168.0.2])
	by smtp1.home.nl with esmtp (Exim 4.30)
	id 1CK4JM-0003NL-IP
	for alsa-devel@alsa-project.org; Wed, 20 Oct 2004 02:26:40 +0200
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Good day.

Don't know if this is known/expected...

Just installed a "TerraTec DMX Xfire 1024" = Crystal CS4624-CQ + CS4294-JQ.

When I configure the cs46xx driver (the kernel 2.6.9 one) without the 
new DSP support, the "Master" control in alsamixer controls the front 
line-out, and "Headphone" the rear line-out. When I configure _with_ the 
new DSP support, the "Headphone" control does not seem to do anything 
anymore and I can't find a way to get the rear line-out functional. Bug 
or just me?

Rene.


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
