From: Rajeev kumar <rajeev-dlh.kumar@st.com>
Subject: Audio codec volume control
Date: Thu, 20 Sep 2012 13:26:39 +0530
Message-ID: <505ACC37.3060209@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog114.obsmtp.com (eu1sys200aog114.obsmtp.com
 [207.126.144.137])
 by alsa0.perex.cz (Postfix) with ESMTP id EB0BC260744
 for <alsa-devel@alsa-project.org>; Thu, 20 Sep 2012 09:56:45 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hello Mark,

We have three volume control in audio codec.
1. Master volume: control both left and right channel volume
2. left volume: control left channel vol
3. right volume: control right channel vol.

So we can provide interfaces for all volume control to the user. Please
find below the control I can provide to the user space

case 1:
1. Provide master volume control
2. Provide Left channel volume control.
3. Provide Right channel volume control.

case 2:

1. Provide master volume control
2. Instead of providing separate control for left and right channel,
combined it and provide a single control to user space. so that left and 
right volume is always in sync.


Please let me know which case is better and why?

Thank you very much for your support.

Best Regards
Rajeev
