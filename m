From: liufc <liufc10@gmail.com>
Subject: HDA driver without interrupt
Date: Wed, 02 May 2012 20:54:41 +0800
Message-ID: <4FA12E91.8050804@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pb0-f51.google.com (mail-pb0-f51.google.com
	[209.85.160.51]) by alsa0.perex.cz (Postfix) with ESMTP id 1E4A824330
	for <alsa-devel@alsa-project.org>;
	Wed,  2 May 2012 14:54:46 +0200 (CEST)
Received: by pbbrp16 with SMTP id rp16so1335815pbb.38
	for <alsa-devel@alsa-project.org>; Wed, 02 May 2012 05:54:45 -0700 (PDT)
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

Hi guys,I'm trying to implement an alsa driver based on the Intel HDA 
driver.However due to some hardware defects,I'm not able to use 
interrupt.So I wonder whether there is a way to do the job without the 
help of interrupt.Can anyone give me a suggestion?
