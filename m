From: longer <longer.zhou@gmail.com>
Subject: problems about dummy alsa driver
Date: Mon, 26 Jul 2010 09:44:24 +0000 (UTC)
Message-ID: <loom.20100726T114150-296@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 371A3103885
	for <alsa-devel@alsa-project.org>;
	Mon, 26 Jul 2010 11:44:40 +0200 (CEST)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1OdKEg-0005F0-VM
	for alsa-devel@alsa-project.org; Mon, 26 Jul 2010 11:44:39 +0200
Received: from 61.183.225.66 ([61.183.225.66])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Mon, 26 Jul 2010 11:44:38 +0200
Received: from longer.zhou by 61.183.225.66 with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Mon, 26 Jul 2010 11:44:38 +0200
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

Hi all ,


I've written an ALSA driver(only support 8K sample rate), which register two 

dummy sound cards.The main function of this driver is to exchange audio data 

of that two dummy sound cards. In other words , the driver route audio data of 

dummy sound card (PLAYBACK) to the other (CAPTURE),and vice versa.   

And I've written some test programs based on my ALSA driver . When the sample 

rate in application is set to be 8K , the driver work well. But when requiring  

rate conversion , the driver can't get any data. And , when tracing the code of 

alsa-lib (1.0.23), I found that :

     In case of rate conversion, It mmap an address from my driver, but writing 

data to another address instead of that mmaped address.

I think this is why my driver don't get any audio data. But I don't know why it 

don't write audio data to that mmaped address.

I am looking forward to your reply. And any advices will help me a lot.

Thank you,
longer zhou
