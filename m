From: Stefan Schoenleitner <dev.c0debabe@gmail.com>
Subject: Relation between SND_PCM_IOPLUG_HW_PERIODS and
 SND_PCM_IOPLUG_HW_BUFFER_BYTES ?
Date: Fri, 30 Apr 2010 13:59:55 +0200
Message-ID: <4BDAC63B.2050701@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from keymachine.tbmn.org (mail.tbmn.org [87.118.84.39])
	by alsa0.perex.cz (Postfix) with ESMTP id 78D2710392D
	for <alsa-devel@alsa-project.org>;
	Fri, 30 Apr 2010 14:00:02 +0200 (CEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by keymachine.tbmn.org (Postfix) with ESMTP id A55C08AC5C3
	for <alsa-devel@alsa-project.org>;
	Fri, 30 Apr 2010 13:59:57 +0200 (CEST)
Received: from keymachine.tbmn.org ([127.0.0.1])
	by localhost (keymachine.tbmn.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LUdlYxq9bbzz for <alsa-devel@alsa-project.org>;
	Fri, 30 Apr 2010 13:59:57 +0200 (CEST)
Received: from [192.168.1.5] (chello080108001212.35.11.tuwien.teleweb.at
	[80.108.1.212])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: mne@tbmn.org)
	by keymachine.tbmn.org (Postfix) with ESMTPSA id 3BCA08AC5C1
	for <alsa-devel@alsa-project.org>;
	Fri, 30 Apr 2010 13:59:57 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

what is the relation between SND_PCM_IOPLUG_HW_PERIODS and
SND_PCM_IOPLUG_HW_BUFFER_BYTES ?

While SND_PCM_IOPLUG_HW_BUFFER_BYTES is the setting of the hardware
buffer size, I'm not sure exactly what SND_PCM_IOPLUG_HW_PERIODS is.

I suppose it is the number of periods the hardware buffer can take ?
Hence the SND_PCM_IOPLUG_HW_PERIODS value is actually derived from the
size of the hardware buffer ?

Or is it rather the number of periods the ioplugin can receive at once ?

Please enlighten me,
cheers,
Stefan
