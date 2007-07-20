From: Saurav SAHU <saurav.sahu@st.com>
Subject: ALSA-USB driver issues with C-Media chipset
Date: Fri, 20 Jul 2007 12:49:05 +0800
Message-ID: <03ff01c7ca89$4d538d00$7c70500a@amk.st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from s200aog10.obsmtp.com (s200aog10.obsmtp.com [207.126.144.124])
	by alsa0.perex.cz (Postfix) with ESMTP id 90B9C1037EC
	for <alsa-devel@alsa-project.org>;
	Fri, 20 Jul 2007 06:49:19 +0200 (CEST)
Received: from zeta.dmz-ap.st.com (ns6.st.com [138.198.234.13])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 95E02DA4D
	for <alsa-devel@alsa-project.org>; Fri, 20 Jul 2007 04:49:06 +0000 (GMT)
Received: from mail1.amk.st.com (mail1.amk.st.com [138.198.240.233])
	by zeta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 780FD4A5BA
	for <alsa-devel@alsa-project.org>; Fri, 20 Jul 2007 04:49:06 +0000 (GMT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

We have encountered some audio recording quality issues on the recent ALSA-USB drivers. These problems are faced on C-Media chipset based external USB audio devices. The recorded audio with 'arecord' is quite noisy, unclear and jerky. The version of ALSA I encountered are 1.0.12 and beyond. It seemed to work well previously on ALSA version 1.0.8. If I record with a Philips webcam mic (Philips chipset), the audio recording is very clear on across all ALSA versions.

In case you have observed similar issues with C-Media drivers and aware of them, please let me know.

Best Regards
Saurav
