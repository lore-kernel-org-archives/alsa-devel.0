From: Nicolas =?iso-8859-1?q?H=FCppelsh=E4user?= <nh@emlix.com>
Subject: signed/unsigned pcm formats
Date: Tue, 7 Sep 2004 12:39:21 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E1C4dNi-0000yJ-0z@mailer.emlix.com>
Reply-To: nh@emlix.com
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.emlix.com (mail2.emlix.com [193.159.217.188])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 9EA5629C
	for <alsa-devel@alsa-project.org>; Tue,  7 Sep 2004 12:39:30 +0200 (MEST)
Received: from emlix ([172.17.111.84] helo=mailer.emlix.com)
	by mail.emlix.com with esmtp (Exim 4.34)
	id 1C4dNk-0001Rw-5S
	for alsa-devel@alsa-project.org; Tue, 07 Sep 2004 12:39:25 +0200
Content-Disposition: inline
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

Hi everybody!

I would like to know how pcm data is encoded.
What is the value range of a signed format type of data width x?
For 8 bit I would expect -127,...,128.

How is this range encoded in unsigned type of equal bit width?
Is, for 8 bit width, signed -127,...,0 mapped to unsigned 0,...,127 and signed 
1,...,128 to unsigned 128,...,255?  Or is it hardware dependent?

Viele Gruesse / best regards
        Nicolas Hueppelshaeuser
--
nicolas hueppelshaeuser, emlix gmbh, http://www.emlix.com,
mailto:nh@emlix.com
fon +49 551 37000-37, fax -38, keplerstrasse 24, 37085 goettingen, germany

emlix - your embedded linux partner


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
