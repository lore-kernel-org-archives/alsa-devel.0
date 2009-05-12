From: javier Martin <javier.martin@vista-silicon.com>
Subject: Audio blank samples after some seconds of playing
Date: Tue, 12 May 2009 09:28:07 +0200
Message-ID: <eedb5540905120028j20a9ff5as829e78ccb8a43dec@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yw-out-1718.google.com (yw-out-1718.google.com [74.125.46.154])
	by alsa0.perex.cz (Postfix) with ESMTP id EB121103823
	for <alsa-devel@alsa-project.org>;
	Tue, 12 May 2009 09:28:07 +0200 (CEST)
Received: by yw-out-1718.google.com with SMTP id 4so2559577ywq.2
	for <alsa-devel@alsa-project.org>; Tue, 12 May 2009 00:28:07 -0700 (PDT)
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

I have a .wav file which lasts about 2 minutes.
I am playing it with aplay. It works fine, but after some seconds of
playing, I hear two blanks suddenly. After that, it continues playing fine
till the end of the file.
I have tried to increment buffer size and period size but I don't see any
difference.
Possition of blank samples seems to be quite random, but it always happens
near the beggining of the file.

Can you please give me some tip for debugging this problem or an idea of
what more can I try?

Thank you.
