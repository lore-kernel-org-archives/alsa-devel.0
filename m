From: Hynek Hanke <hanke@brailcom.org>
Subject: Crack sounds in playback
Date: Fri, 5 Aug 2005 13:05:53 +0200
Message-ID: <20050805110553.GB32027@brailcom.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from smtp-out3.iol.cz (smtp-out3.iol.cz [194.228.2.91])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 7B08B20E
	for <alsa-devel@alsa-project.org>; Fri,  5 Aug 2005 13:09:16 +0200 (MEST)
Received: from antivir3.iol.cz (unknown [192.168.30.206])
	by smtp-out3.iol.cz (Internet on Line ESMTP server) with ESMTP id 946133180A1
	for <alsa-devel@alsa-project.org>; Fri,  5 Aug 2005 13:09:12 +0200 (CEST)
Received: from localhost (antivir3.iol.cz [127.0.0.1])
	by antivir3.iol.cz (Postfix) with ESMTP id 865736DC007
	for <alsa-devel@alsa-project.org>; Fri,  5 Aug 2005 13:09:12 +0200 (CEST)
Received: from smtp-out3.iol.cz (unknown [192.168.30.28])
	by antivir3.iol.cz (Postfix) with ESMTP id C6B8B6DC002
	for <alsa-devel@alsa-project.org>; Fri,  5 Aug 2005 13:09:11 +0200 (CEST)
Received: from chopin (unknown [80.188.214.108])
	by smtp-out3.iol.cz (Internet on Line ESMTP server) with ESMTP id 3A32B3C2A3
	for <alsa-devel@alsa-project.org>; Fri,  5 Aug 2005 13:09:09 +0200 (CEST)
Received: from hanke by chopin with local (Exim 3.36 #1 (Debian))
	id 1E101R-0001mr-00
	for <alsa-devel@alsa-project.org>; Fri, 05 Aug 2005 13:05:53 +0200
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
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


Hello everyone,

after all the suggestions (thanks for them), I got the alsa playback working
with the non-blocking/polling approach. I'm checking for xrun and suspend
states in the poll loop and after I send all the samples, I set avail_min to
the whole buffer and poll() until the states gets to XRUN. I open the device
before playing each track and close it after that. Sometimes, I interrupt the
sound in the middle through snd_pcm_drop() and immediatelly close the device.

I'm setting the usual hw parameters. From software parameters, I set only
avail_min at the end, when I need to ,,drain''.

The playback seems good now, but my colleague is reporting he hears some crack
sounds on his SoundBlaster Platinum. They appear mostly at the beginning and at
the end, but in the middle sometimes too. They appear often.

I've examined the log and the device does never get to XRUN or SUSPEND, except
for the last stage, when I set avail_min to the size of the buffer and wait
until it's empty -- but that's expected behavior. None of snd_pcm_ calls
returns any error.

Any ideas of what am I doing wrong or how to debug this?

Thank you,
Hynek Hanke


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
