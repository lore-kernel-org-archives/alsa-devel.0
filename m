From: Rajeev kumar <rajeev-dlh.kumar@st.com>
Subject: overrun in case of record
Date: Tue, 6 Sep 2011 15:04:44 +0530
Message-ID: <4E65E934.2070706@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog114.obsmtp.com (eu1sys200aog114.obsmtp.com
	[207.126.144.137])
	by alsa0.perex.cz (Postfix) with ESMTP id 1900A24615
	for <alsa-devel@alsa-project.org>;
	Tue,  6 Sep 2011 11:35:23 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, rajeev-dlh.kumar@st.com, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Hello Mark

I am testing my audio driver on spear platform.During recording I am 
getting two issues.
1. Overrun issue
2. pcm_read error

I am using arecord for capturing data.
#arecord -f dat > t
overrun!!! (at least 32.949 ms long)

Overrun issue: The issue is only reproducible if we try to record for 
more than 40 sec.The strange part is that Instead of overrun condition 
generated,
it will record complete data for 10sec.(This is verified with the number 
of bytes recorded).
So could you please let me know whether this is an error condition or 
just a warning.

pcm_read error: For this I have seen a bug is locked in the 
bugzila(*Bug 472469* <show_bug.cgi?id=472469> -arecord: input/output 
error ). and the status  is closed saying insufficient data.
Could you please let me know what is the meaning of this bug? Is it 
like, data is not available in the buffer and pcm_read from the user 
space fails? But why this situation will
arise?

Best Regards
Rajeev
