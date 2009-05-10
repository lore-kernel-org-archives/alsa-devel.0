From: Jon Smirl <jonsmirl@gmail.com>
Subject: How to test new SDPIF implementation?
Date: Sun, 10 May 2009 15:13:18 -0400
Message-ID: <9e4733910905101213y6c8909b4l16542f9e59c4db6f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from qw-out-1920.google.com (qw-out-1920.google.com [74.125.92.150])
	by alsa0.perex.cz (Postfix) with ESMTP id 4F30C243CE
	for <alsa-devel@alsa-project.org>;
	Sun, 10 May 2009 21:13:20 +0200 (CEST)
Received: by qw-out-1920.google.com with SMTP id 4so1442835qwk.56
	for <alsa-devel@alsa-project.org>; Sun, 10 May 2009 12:13:19 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel mailing list <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

I would like to test my SPDIF driver implementation. How can I used
command line tools to play sample 5.1 music over SPDIF?

I have a file 5.1 AC3 encoded file -- w.ac3

This doesn't work:

iecset -D hw:0 audio off
aplay -c 2 -r 48000 -f S16_BE -D hw:0,1 w.ac3

I can play uncompressed music on SDPIF without problem. I know my
audio system will play the compressed music, I can use A52 from my
desktop.

-- 
Jon Smirl
jonsmirl@gmail.com
