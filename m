From: Baek Chang <baeksan@ccrma.stanford.edu>
Subject: switching pcm devices dynamically when using dmix
Date: Wed, 3 Aug 2011 15:13:09 -0700
Message-ID: <CAG3SCMspSq=aVbGLwKkcp+x7syNf4a9Too+SgmQ7jJSJBH26=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
	[209.85.213.51]) by alsa0.perex.cz (Postfix) with ESMTP id B251B2434C
	for <alsa-devel@alsa-project.org>;
	Thu,  4 Aug 2011 00:13:10 +0200 (CEST)
Received: by ywb26 with SMTP id 26so817408ywb.38
	for <alsa-devel@alsa-project.org>; Wed, 03 Aug 2011 15:13:09 -0700 (PDT)
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

Hi,

I'm wondering if the following is possible.

If I have my asound.conf configured in such a way that

pcm.media {

}

route to hw:0,0 throuh dmix.

can I dynamically change the device to hw:0,1 or hw:1,0 if necessary?

Thanks!
-- 
-baeksanchang
