From: David Henningsson <david.henningsson@canonical.com>
Subject: Expected behaviour for two mic jacks
Date: Fri, 12 Nov 2010 10:50:19 +0100
Message-ID: <4CDD0DDB.9020509@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 784EB103926
	for <alsa-devel@alsa-project.org>; Fri, 12 Nov 2010 10:50:20 +0100 (CET)
Received: from hutte.canonical.com ([91.189.90.181])
	by adelie.canonical.com with esmtp (Exim 4.69 #1 (Debian))
	id 1PGqGx-0003ij-7L
	for <alsa-devel@alsa-project.org>; Fri, 12 Nov 2010 09:50:19 +0000
Received: from c-83-233-18-148.cust.bredband2.com ([83.233.18.148]
	helo=[192.168.8.102]) by hutte.canonical.com with esmtpsa
	(TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32) (Exim 4.69)
	(envelope-from <david.henningsson@canonical.com>) id 1PGqGx-0007SX-4O
	for alsa-devel@alsa-project.org; Fri, 12 Nov 2010 09:50:19 +0000
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

A while ago I asked for the default/expected behaviour for auto-mute. 
Here's the same question for mics:

If there are two mic jacks, e g one on the front and one on the back, is 
the standard/default behaviour that we should:

1) Show one mic only and add auto-switch functionality, and if so, what 
should determine which mic takes precedence?

2) Show both mics and let the user choose between them?

3) Show both mics, two volume control and let the user mix both signals 
together (when possible)?

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic
