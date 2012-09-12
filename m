From: Henrik Fasth <henrik.fasth@axis.com>
Subject: Amixer: suppressing errors when called from stdin
Date: Wed, 12 Sep 2012 11:39:54 +0200
Message-ID: <5050586A.1060405@axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ra.se.axis.com (ra.se.axis.com [195.60.68.13])
 by alsa0.perex.cz (Postfix) with ESMTP id 09D7F26168F
 for <alsa-devel@alsa-project.org>; Wed, 12 Sep 2012 11:35:04 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by ra.se.axis.com (Postfix) with ESMTP id 8403C182F6D
 for <alsa-devel@alsa-project.org>; Wed, 12 Sep 2012 11:35:03 +0200 (CEST)
Received: from ra.se.axis.com ([127.0.0.1])
 by localhost (ra.se.axis.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id XetmIk3eyZ94 for <alsa-devel@alsa-project.org>;
 Wed, 12 Sep 2012 11:35:01 +0200 (CEST)
Received: from thoth.se.axis.com (thoth.se.axis.com [10.0.2.173])
 by ra.se.axis.com (Postfix) with ESMTP id 92B6E11EE8
 for <alsa-devel@alsa-project.org>; Wed, 12 Sep 2012 11:35:01 +0200 (CEST)
Received: from xmail2.se.axis.com (xmail2.se.axis.com [10.0.5.74])
 by thoth.se.axis.com (Postfix) with ESMTP id 7E19034193
 for <alsa-devel@alsa-project.org>; Wed, 12 Sep 2012 11:35:01 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

We have some problems with amixer always returning 0 when called from 
stdin (exec_stdin). The global variable ignore_error is always set to 1 
in function exec_stdin which leads to sset and cset always returning 0 
even if an error occured.

Are there any specific reasons for suppressing error messages and error 
return values like this?

Br
Henrik
