From: Pierre Peiffer <pierre.peiffer@st.com>
Subject: ASOC: dapm event errors not reported
Date: Wed, 12 Sep 2012 14:12:36 +0200
Message-ID: <50507C34.7050109@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog118.obsmtp.com (eu1sys200aog118.obsmtp.com
 [207.126.144.145])
 by alsa0.perex.cz (Postfix) with ESMTP id B3D92261694
 for <alsa-devel@alsa-project.org>; Wed, 12 Sep 2012 14:12:53 +0200 (CEST)
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 959361D0
 for <alsa-devel@alsa-project.org>; Wed, 12 Sep 2012 12:12:38 +0000 (GMT)
Received: from Webmail-eu.st.com (safex1hubcas2.st.com [10.75.90.16])
 by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0FD7444DD
 for <alsa-devel@alsa-project.org>; Wed, 12 Sep 2012 12:12:38 +0000 (GMT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

I have observed that in dapm, most of the errors of widget event calls
are reported in kernel log but not returned to the caller.
This leads in some cases to a situation where the error is not reported
to the userspace caller, letting it continue, even if it can't and
following calls from userspace will fail as well.

Is there a reason for this ?

Thanks & BR

-- 
Pierre
