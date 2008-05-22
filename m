From: "Harsha priya gupta" <harshapriya@gmail.com>
Subject: snd_kcontrol questions
Date: Thu, 22 May 2008 11:45:04 +0530
Message-ID: <827ad74d0805212315o7e55bf92q6aa81cfa9c1e461e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.172])
	by alsa0.perex.cz (Postfix) with ESMTP id 9A38E2470C
	for <alsa-devel@alsa-project.org>;
	Thu, 22 May 2008 08:15:06 +0200 (CEST)
Received: by wf-out-1314.google.com with SMTP id 24so3275562wfg.23
	for <alsa-devel@alsa-project.org>; Wed, 21 May 2008 23:15:05 -0700 (PDT)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

Can anyone help me to with the following questions on controls?

1. I want to define a snd_kcontrol that is of type mono. I am basically
trying to define a mono output control that is exposed in KMIX and  whose
'split channel' does not split into two channels.
2. My input controls give out 9 channels when i say 'split channels' in
kmix. can anyone help me how to fix that to 2 channels
3. I would want to get the individual setting of each channel from KMIX into
my ALSA driver. How do I get them? will .get and .set functions help in
this?

-- 
-Harsha
