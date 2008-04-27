From: Kristoffer Janke <kj@conceptT.com>
Subject: Patch for alsa-info.sh to include stderr of some tools
Date: Sun, 27 Apr 2008 13:36:14 +0200
Message-ID: <4814652E.7050908@conceptT.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------000405080703080206000609"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.conceptT.com (unknown [84.200.19.22])
	by alsa0.perex.cz (Postfix) with ESMTP id 81FCA24825
	for <alsa-devel@alsa-project.org>;
	Sun, 27 Apr 2008 13:36:38 +0200 (CEST)
Received: from [192.168.1.210] (dslb-084-063-112-095.pools.arcor-ip.net
	[84.63.112.95])
	by mail.conceptT.com (Postfix) with ESMTP id 129F2642DC8
	for <alsa-devel@alsa-project.org>;
	Sun, 27 Apr 2008 13:36:38 +0200 (CEST)
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

This is a multi-part message in MIME format.
--------------000405080703080206000609
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Here is a small patch for the alsa-info.sh tool, now the stderr isnt 
trown away.

--
Kristoffer 'spq' Janke

--------------000405080703080206000609
Content-Type: text/plain;
 name="alsa-info.sh.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="alsa-info.sh.patch"

3c3
< SCRIPT_VERSION=0.4.41
---
> SCRIPT_VERSION=0.4.42
80c80
<       aplay -l >> $FILE
---
>       aplay -l >> $FILE 2>&1
84c84
<       arecord -l >> $FILE
---
>       arecord -l >> $FILE 2>&1
105c105
<       amixer -c$i>> $FILE
---
>       amixer -c$i >> $FILE 2>&1

--------------000405080703080206000609
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------000405080703080206000609--
