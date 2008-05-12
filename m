From: "Nagar, Mrigendra" <x0088697@ti.com>
Subject: Mono streams
Date: Mon, 12 May 2008 18:35:16 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E9401234B506B@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from calf.ext.ti.com (calf.ext.ti.com [198.47.26.144])
	by alsa0.perex.cz (Postfix) with ESMTP id 19F49245C2
	for <alsa-devel@alsa-project.org>;
	Mon, 12 May 2008 15:05:25 +0200 (CEST)
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by calf.ext.ti.com (8.13.7/8.13.7) with ESMTP id m4CD5J31021399
	for <alsa-devel@alsa-project.org>; Mon, 12 May 2008 08:05:24 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id m4CD5H3s002257
	for <alsa-devel@alsa-project.org>; Mon, 12 May 2008 08:05:18 -0500 (CDT)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,
I have recently started working on ALSA libraries. I am facing following problems. It would be great help If some one can help me out.
1) Mono streams:
    If I try to play A MONO streams. It plays Faster.
    My driver configuration is
i)                     Blocking mode
ii)                   Access mode is interleaved
iii)                  No of channels are set to 1
2) Buffer under run while playing Mono stream.
    i) Blocking mode
    i) Hardware buffer size is 65536
    ii) Periods is set to 64
     I always encounter buffer under run If I try to decode and play a stream frame by frame. Frame size is constant and it is 2048. If I club two frames and
Try to play it. It plays well. In second case buffer size becomes 4096.
My question is: Is there any optimal buffer size. Which one should set to have smooth payout?

Regards,
Mrigen
