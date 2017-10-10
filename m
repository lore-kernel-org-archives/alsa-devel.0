From: Henrik Eriksson <henrik.eriksson@axis.com>
Subject: timestamp update when no hw delta
Date: Tue, 10 Oct 2017 14:14:59 +0200
Message-ID: <20171010121459.GF24037@lnxhenriken2.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
 by alsa0.perex.cz (Postfix) with ESMTP id 6288A266B38
 for <alsa-devel@alsa-project.org>; Tue, 10 Oct 2017 14:15:01 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by bastet.se.axis.com (Postfix) with ESMTP id B229718808
 for <alsa-devel@alsa-project.org>; Tue, 10 Oct 2017 14:15:00 +0200 (CEST)
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
 by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 5u9JElhtB3UO for <alsa-devel@alsa-project.org>;
 Tue, 10 Oct 2017 14:15:00 +0200 (CEST)
Received: from boulder02.se.axis.com (boulder02.se.axis.com [10.0.8.16])
 by bastet.se.axis.com (Postfix) with ESMTPS id 3369418801
 for <alsa-devel@alsa-project.org>; Tue, 10 Oct 2017 14:15:00 +0200 (CEST)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B649C1A0F2
 for <alsa-devel@alsa-project.org>; Tue, 10 Oct 2017 14:14:59 +0200 (CEST)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AB5491A0F1
 for <alsa-devel@alsa-project.org>; Tue, 10 Oct 2017 14:14:59 +0200 (CEST)
Received: from thoth.se.axis.com (unknown [10.0.2.173])
 by boulder02.se.axis.com (Postfix) with ESMTP
 for <alsa-devel@alsa-project.org>; Tue, 10 Oct 2017 14:14:59 +0200 (CEST)
Content-Disposition: inline
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

Hi

I am looking into commit 3179f62001880e588e229db3006a59ad87b7792a
("ALSA: core: add .get_time_info"), which, if I understand the code
correctly, changed the behaviour of timestamps.  Before this change,
snd_pcm_update_hw_ptr0() just returned if the no_delta_check showed that
the hw_ptr had not changed.  With this change it will update the
timestamps before returning.

Was this intended, and if so does anyone have any insights to why?  The
original behaviour to not update the timestamps when the hw position has
not changed seems more correct to me, but I am new to this code.

Regards,
/henrik
