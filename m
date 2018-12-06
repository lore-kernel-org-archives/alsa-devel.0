From: Antonio Ospite <ao2@ao2.it>
Subject: Invalid TLS certificate for mailman.alsa-project.org
Date: Thu, 6 Dec 2018 10:09:24 +0100
Message-ID: <20181206100924.869a02405e1f94f66810b725@ao2.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ao2.it (mail.ao2.it [92.243.12.208])
 by alsa0.perex.cz (Postfix) with ESMTP id 9DF07267BB3
 for <alsa-devel@alsa-project.org>; Thu,  6 Dec 2018 10:09:25 +0100 (CET)
Received: from localhost ([::1] helo=jcn.localdomain)
 by ao2.it with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.84_2) (envelope-from <ao2@ao2.it>) id 1gUpeC-0006T0-Tc
 for alsa-devel@alsa-project.org; Thu, 06 Dec 2018 10:08:40 +0100
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

when logging in to mailman.alsa-project.org[1] to change my subscription
options I noticed that the TLS certificate used for HTTPS
connections does not cover said domain, firefox says:

-----------------------------------------------------------------------
mailman.alsa-project.org uses an invalid security certificate.

The certificate is only valid for the following names:
alsa-project.org, alsa0.perex.cz, bugtrack.alsa-project.org,
git.alsa-project.org, mail.alsa-project.org, www.alsa-project.org

Error code: SSL_ERROR_BAD_CERT_DOMAIN
-----------------------------------------------------------------------

Basically, mailman.alsa-project.org is not in Subject Alternative Names
for the certificate.

This is not a huge deal as:

  1. mail.alsa-project.org works fine with HTTPS;
  2. the password is sent by email in the monthly reminder anyways.

However it would still be handy to have this fixed as
mailman.alsa-project.org URLs are used in the Wiki[2] pages and in the
footer of messages coming from the mailing list, and it can be
surprising for users that HTTPS does not work.

Thank you,
   Antonio

[1] https://mailman.alsa-project.org/mailman/options/alsa-devel
[2] https://www.alsa-project.org/main/index.php/Mailing-lists

-- 
Antonio Ospite
https://ao2.it
https://twitter.com/ao2it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
