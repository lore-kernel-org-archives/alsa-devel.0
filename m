From: pl bossart <bossart.nospam@gmail.com>
Subject: HDAudio volume/widget control?
Date: Tue, 2 Jun 2009 12:33:39 -0500
Message-ID: <6160a5130906021033hd25fd47j1f951369010a0a16@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yw-out-1718.google.com (yw-out-1718.google.com [74.125.46.152])
	by alsa0.perex.cz (Postfix) with ESMTP id BDCCB103872
	for <alsa-devel@alsa-project.org>;
	Tue,  2 Jun 2009 19:33:40 +0200 (CEST)
Received: by yw-out-1718.google.com with SMTP id 4so5503622ywq.2
	for <alsa-devel@alsa-project.org>; Tue, 02 Jun 2009 10:33:39 -0700 (PDT)
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

Hi all,
Bear with my ignorance here. It's not clear to me how an application
or an audio server can precisely control volumes if the hierarchy of
HDAudio widgets is not exposed. I checked in the HDaudio code, and it
seems the connection list and connectivity entries are only showed in
sysfs, not really directly usable. My findings are backed by the 2008
LPC report at http://lwn.net/Articles/299093/ which asserts that

"The new audio standard, HD-Audio, is commonly found on new systems,
and it's well-supported at the kernel level. However, it's based on
"widgets" with vendor-configurable I/O pins. A driver can't tell how
the HD-Audio part is connected, so some Linux plumbing work is
required to identify which of the many exposed level controls is the
right one to show the user. An audience member pointed out the need to
tweak multiple level settings on his hardware, to get the right level
without distortion. Linux will need more information on how each
machine has its HD-Audio hardware hooked up in order to reliably give
the user a useful volume control."

Am I missing something? Or is there already a plan to change this?
Thanks for your feedback.
Cheers,
Pierre
