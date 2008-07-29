From: Wolfgang Rosenauer <wolfgang@rosenauer.org>
Subject: app-internal volume control
Date: Tue, 29 Jul 2008 11:00:47 +0200
Message-ID: <488EDC3F.3030501@rosenauer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ds9.rosenauer.org (ds9.rosenauer.org [78.47.28.164])
	by alsa0.perex.cz (Postfix) with ESMTP id 8D00F1037F9
	for <alsa-devel@alsa-project.org>;
	Tue, 29 Jul 2008 11:00:50 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by ds9.rosenauer.org (Postfix) with ESMTP id 3F06E4C32A
	for <alsa-devel@alsa-project.org>;
	Tue, 29 Jul 2008 11:00:50 +0200 (CEST)
Received: from ds9.rosenauer.org ([127.0.0.1])
	by localhost (78.47.28.164 [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fYTyRgsAtaVz for <alsa-devel@alsa-project.org>;
	Tue, 29 Jul 2008 11:00:48 +0200 (CEST)
Received: from [192.168.250.1] (p4FD03C64.dip0.t-ipconnect.de [79.208.60.100])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by ds9.rosenauer.org (Postfix) with ESMTP id 0E1DA4C32C
	for <alsa-devel@alsa-project.org>;
	Tue, 29 Jul 2008 11:00:48 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

might be a dumb question for people knowing the externals of Alsa but 
I'm not sure :-(

What is the best practice to control the volume of a Linux application?
I could control Alsa'x mixer for Master or PCM but that looks like a bad 
thing to do since it changes the volume for every other app as well.

Is there another mixer I could use which is application specific?
Or do I need to implement an application internal filter to control the 
volume by modifying the audio stream?

Thanks,
  Wolfgang
