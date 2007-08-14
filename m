From: Eliot Blennerhassett <linux@audioscience.com>
Subject: Current alsa module list discrepancies
Date: Tue, 14 Aug 2007 21:16:07 +1200
Message-ID: <200708142116.07471.linux@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp5.clear.net.nz (smtp5.clear.net.nz [203.97.33.68])
	by alsa0.perex.cz (Postfix) with ESMTP id 6F8A110380D
	for <alsa-devel@alsa-project.org>;
	Tue, 14 Aug 2007 11:14:50 +0200 (CEST)
Received: from zaphod (121-72-250-62.cable.telstraclear.net [121.72.250.62])
	by smtp5.clear.net.nz (CLEAR Net Mail)
	with ESMTP id <0JMR00DJBB0MAX20@smtp5.clear.net.nz> for
	alsa-devel@alsa-project.org; Tue, 14 Aug 2007 21:14:47 +1200 (NZST)
Content-disposition: inline
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

Hello all,

As part of getting the wiki up to date I have been comparing three lists of 
driver modules
1) List given by "configure --help" for --with-cards option
2) List of modules installed on my system when I  make install alsa-driver
3) Current list of Module-* pages in the wiki

The results of these comparisons is here.

http://www.alsa-project.org/main/index.php/Matrix_Talk:Main

Question is, are there some drivers in these lists that should be listed 
in "configure --help"  (loopback -> aloop at least)

Should all modules (even helpers) be documented in the wiki?
Particularly helper modules that have parameters, to explain what the 
parameters are for.

regards

Eliot
