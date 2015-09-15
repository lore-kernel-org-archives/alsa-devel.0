From: James Cameron <quozl@laptop.org>
Subject: Occasional channel swapping, rt5631 vs mmp2 sspa
Date: Tue, 15 Sep 2015 14:36:21 +1000
Message-ID: <20150915043621.GG27294@us.netrek.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from zimbra.real-time.com (zimbra.real-time.com [63.170.91.9])
 by alsa0.perex.cz (Postfix) with ESMTP id 9E79826064C
 for <alsa-devel@alsa-project.org>; Tue, 15 Sep 2015 06:36:43 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zimbra.real-time.com (Postfix) with ESMTP id E859A583DDA
 for <alsa-devel@alsa-project.org>; Mon, 14 Sep 2015 23:36:41 -0500 (CDT)
Received: from zimbra.real-time.com ([127.0.0.1])
 by localhost (zimbra.real-time.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HjPLiXi3q1sB for <alsa-devel@alsa-project.org>;
 Mon, 14 Sep 2015 23:36:41 -0500 (CDT)
Received: from esk.lan (pa114-73-191-25.pa.nsw.optusnet.com.au [114.73.191.25])
 by zimbra.real-time.com (Postfix) with ESMTPSA id BFFA6583D8B
 for <alsa-devel@alsa-project.org>; Mon, 14 Sep 2015 23:36:40 -0500 (CDT)
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

G'day,

The rt5631 has a single serial data port shared by playback and
capture at the same time, using I2S.

Sometimes on playback or capture the channels are swapped left for
right.  The swap starts as a stream starts.  The swap continues until
the stream stops.

The SoC is an Armada 610 with an SSPA peripheral.

A workaround is to remove a clock domain reset when a stream is
started.  This is a reset bit in a register of the SSPA.

My theory is that the clock domain reset in the SSPA while I2S is
clocking interferes with LRCK (aka fsync) edge detection.

I'm wondering how this kind of problem should be solved properly;
avoiding the clock domain reset while I2S is clocking seems right, but
which codec and SoC driver ops should start I2S and/or reset the host
port?

My post is probably incomplete and inadequate; please ask any
questions.  ;-)

-- 
James Cameron
http://quozl.linux.org.au/
