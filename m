From: Chuck Ebbert <cebbert@redhat.com>
Subject: 1.0.15: volume levels drift on HDA with STAC92XX codec
Date: Thu, 01 Nov 2007 13:47:39 -0400
Message-ID: <472A113B.7030406@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
	by alsa0.perex.cz (Postfix) with ESMTP id 05D002438D
	for <alsa-devel@alsa-project.org>; Thu,  1 Nov 2007 18:47:42 +0100 (CET)
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com
	[172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.1) with ESMTP id lA1Hlfa9022330
	for <alsa-devel@alsa-project.org>; Thu, 1 Nov 2007 13:47:41 -0400
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.76.12])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id
	lA1HleGJ005711
	for <alsa-devel@alsa-project.org>; Thu, 1 Nov 2007 13:47:40 -0400
Received: from [172.16.83.145] (dhcp83-145.boston.redhat.com [172.16.83.145])
	by mail.boston.redhat.com (8.13.1/8.13.1) with ESMTP id
	lA1HldV3026416
	for <alsa-devel@alsa-project.org>; Thu, 1 Nov 2007 13:47:39 -0400
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

We have two reports now of unstable volume levels:

https://bugzilla.redhat.com/show_bug.cgi?id=361051
https://bugzilla.redhat.com/show_bug.cgi?id=354981

This is with kernel 2.6.23 plus the two ALSA merge patches from
2.6.23-rc1.
