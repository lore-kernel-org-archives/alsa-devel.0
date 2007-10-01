From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: snd-hdsp & digiface
Date: Mon, 01 Oct 2007 15:19:08 -0700
Message-ID: <1191277148.4209.6.camel@cmn3.stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp3.stanford.edu (smtp3.Stanford.EDU [171.67.20.26])
	by alsa0.perex.cz (Postfix) with ESMTP id 23BDA243B1
	for <alsa-devel@alsa-project.org>;
	Tue,  2 Oct 2007 00:19:14 +0200 (CEST)
Received: from smtp3.stanford.edu (localhost.localdomain [127.0.0.1])
	by localhost (Postfix) with SMTP id 2206C4C31B
	for <alsa-devel@alsa-project.org>; Mon,  1 Oct 2007 15:19:11 -0700 (PDT)
Received: from cm-mail.stanford.edu (cm-mail.Stanford.EDU [171.64.197.135])
	by smtp3.stanford.edu (Postfix) with ESMTP id C288C4BE2E
	for <alsa-devel@alsa-project.org>; Mon,  1 Oct 2007 15:19:10 -0700 (PDT)
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
Cc: carrlane@ccrma.Stanford.EDU, nando@ccrma.Stanford.EDU, sandyg@ccrma.Stanford.EDU
List-Id: alsa-devel@alsa-project.org

Hi... We are using both digiface and multiface interfaces here at ccrma
and we have a (small) problem of consistency in the channel numbering
because of the way they are connected. Both cards are connected
digitally to digital mixers, but in the case of the multiface the
digital channels (which would be the ones users use) are 9-16 while on
the digiface the first eight are 1-8[*].

Is there a way to change the ordering in the multiface so that the
digital interface is presented as ports 1-8 instead of 9-16? (even a
hack to the driver would be welcome) - and preferably one that does not
need the default interface to be changed from hw:0 in jack...

-- Fernando

[*] accounts are shared so any configuration you do on one machine for
1-8 will be wrong for the other where the real outputs are 9-16. 
