From: =?UTF-8?B?T3phbiDDh2HEn2xheWFu?= <ozan@pardus.org.tr>
Subject: 1.0.16->1.0.17 regression for some HDA NVidia's
Date: Sun, 06 Jul 2008 19:18:01 +0300
Message-ID: <4870F039.8020207@pardus.org.tr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from pardus.org.tr (ns2.uludag.org.tr [193.140.100.220])
	by alsa0.perex.cz (Postfix) with ESMTP id 8DBC924502
	for <alsa-devel@alsa-project.org>;
	Sun,  6 Jul 2008 18:17:30 +0200 (CEST)
Received: from [192.168.1.2] (unknown [88.249.178.198])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pardus.org.tr (Postfix) with ESMTP id F3BB66261912
	for <alsa-devel@alsa-project.org>;
	Sun,  6 Jul 2008 19:17:21 +0300 (EEST)
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

Everything seems OK with those onboard audio chipsets but there's 
absolutely no sound.
We have 2 bug reports on our bug tracking system indicating this 
regression for MCP51, MCP61 and MCP73.

Here are the URL's for alsa-info.sh output's:

MCP51: http://pastebin.ca/1062418
MCP61: http://pastebin.ca/1058482
MCP73: http://pastebin.ca/1058319

Those users have recently reported that downgrading to 1.0.16 series 
solves the problem.

I have an ASUS mainboard which contains the MCP51 one, I can help if you 
want me to rebuild the driver with a patch, or anything else.

Thanks.

--
Ozan Caglayan
<ozan_at_pardus.org.tr>
http://www.pardus.org.tr/eng
