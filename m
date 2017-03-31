From: Paul Stone <metabagel@icloud.com>
Subject: Re:
 =?utf-8?q?mono/stereo_translation_=26_number_of_fram?=
 =?utf-8?q?es_per_period?=
Date: Fri, 31 Mar 2017 21:14:54 +0000 (GMT)
Message-ID: <84ce3d13-5625-4fbc-a114-4dbcbba0d811@me.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from st11p00im-asmtp004.me.com (st11p00im-asmtp004.me.com
 [17.172.80.98]) by alsa0.perex.cz (Postfix) with ESMTP id 9E5D82668F6
 for <alsa-devel@alsa-project.org>; Fri, 31 Mar 2017 23:14:58 +0200 (CEST)
Received: from process-dkim-sign-daemon.st11p00im-asmtp004.me.com by
 st11p00im-asmtp004.me.com
 (Oracle Communications Messaging Server 7.0.5.38.0 64bit (built Feb 26 2016))
 id <0ONP00A003E22300@st11p00im-asmtp004.me.com> for
 alsa-devel@alsa-project.org; Fri, 31 Mar 2017 21:14:57 +0000 (GMT)
Received: from st13p13im-spool001.me.com ([17.164.57.96])
 by st11p00im-asmtp004.me.com
 (Oracle Communications Messaging Server 7.0.5.38.0 64bit (built Feb 26 2016))
 with ESMTP id <0ONP00KE170UIC40@st11p00im-asmtp004.me.com> for
 alsa-devel@alsa-project.org; Fri, 31 Mar 2017 21:14:54 +0000 (GMT)
Received: from localhost ([17.164.56.54]) by st13p13im-spool001.mac.com
 (Oracle Communications Messaging Server 7.0.5.38.0 64bit (built Feb 26 2016))
 with ESMTP id <0ONP00GLH70UDU10@st13p13im-spool001.mac.com> for
 alsa-devel@alsa-project.org; Fri, 31 Mar 2017 21:14:54 +0000 (GMT)
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

This is becoming increasingly difficult and frustrating. I've tried to work around ALSA by setting up a different chunk size for mono vs. stereo. However, ALSA now wants the total stereo buffer size to be half as large, in accordance with the chunk size. This seems completely arbitrary to me. Why can I not specify the buffer size?

I feel like I must be missing something very basic.
-Paul Stone
