From: Dmitry Baryshkov <dbaryshkov@gmail.com>
Subject: ASoC suspend/resume
Date: Tue, 12 Aug 2008 14:22:27 +0000 (UTC)
Message-ID: <g7s6b3$e79$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by alsa0.perex.cz (Postfix) with ESMTP id 50FF5243D8
	for <alsa-devel@alsa-project.org>;
	Tue, 12 Aug 2008 16:22:36 +0200 (CEST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KSulf-0005cu-BH
	for alsa-devel@alsa-project.org; Tue, 12 Aug 2008 14:22:35 +0000
Received: from iap-pxy-mow1.siemens.ru ([212.248.25.26])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Tue, 12 Aug 2008 14:22:35 +0000
Received: from dbaryshkov by iap-pxy-mow1.siemens.ru with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Tue, 12 Aug 2008 14:22:35 +0000
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

Hi,

I'm trying to clean up spitz ASoC driver: I need to put some GPIO pins to low
during suspend and restore them during resume. What is the most logical place
to do that? I can't find any suitable suspend hook.

-- 
With best wishes
Dmitry
