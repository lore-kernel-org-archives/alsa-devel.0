From: Patrick Lai <plai@codeaurora.org>
Subject: Playback and capture synchronization
Date: Tue, 08 Nov 2011 18:19:29 -0800
Message-ID: <4EB9E331.8070401@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wolverine01.qualcomm.com (wolverine01.qualcomm.com
	[199.106.114.254])
	by alsa0.perex.cz (Postfix) with ESMTP id 34511103940
	for <alsa-devel@alsa-project.org>; Wed,  9 Nov 2011 03:19:32 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>
Cc: Mark Brown <broonie@opensource.wolfsonmciro.com>
List-Id: alsa-devel@alsa-project.org

Hi,

I have a use case requiring playback and capture starting at the same
time. Latency between starting of playback and capture streams need to
be less than few PCM samples. Base on my understanding on ALSA which
does not have the concept of grouping multiple streams, the best I can
do is getting playback and capture to prepared state then trigger start
two streams one after the other. Then, the latency would be the time
for trigger start of first stream to complete. Is there a better way to
deal with my use case from ALSA API standpoint?

Thanks
Patrick

----
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
