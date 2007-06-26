From: Chuck Ebbert <cebbert@redhat.com>
Subject: PCMCIA Audigy 2 broken in 2.6.21?
Date: Tue, 26 Jun 2007 14:56:14 -0400
Message-ID: <4681614E.7060705@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.redhat.com (mx2.redhat.com [66.187.237.31])
	by alsa0.perex.cz (Postfix) with ESMTP id 54D1024343
	for <alsa-devel@alsa-project.org>;
	Tue, 26 Jun 2007 20:56:17 +0200 (CEST)
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com
	[172.16.52.254])
	by mx2.redhat.com (8.13.1/8.13.1) with ESMTP id l5QIuF1D021751
	for <alsa-devel@alsa-project.org>; Tue, 26 Jun 2007 14:56:15 -0400
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.76.12])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id
	l5QIuE62019433
	for <alsa-devel@alsa-project.org>; Tue, 26 Jun 2007 14:56:14 -0400
Received: from [172.16.83.145] (dhcp83-145.boston.redhat.com [172.16.83.145])
	by mail.boston.redhat.com (8.13.1/8.13.1) with ESMTP id
	l5QIuEw6014863
	for <alsa-devel@alsa-project.org>; Tue, 26 Jun 2007 14:56:14 -0400
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


Multiple users report the PCMCIA Audigy 2 adapter hangs the machine in
2.6.21 while it work OK in 2.6.20:

https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=242208
