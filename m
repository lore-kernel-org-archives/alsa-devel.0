From: Jon Smirl <jonsmirl@gmail.com>
Subject: Synchronizing multiple machines
Date: Wed, 27 Jan 2010 20:52:54 -0500
Message-ID: <9e4733911001271752r4b9f77e2kef54d720ede5a704@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f181.google.com (mail-qy0-f181.google.com
	[209.85.221.181])
	by alsa0.perex.cz (Postfix) with ESMTP id 47EE92414F
	for <alsa-devel@alsa-project.org>; Thu, 28 Jan 2010 02:52:55 +0100 (CET)
Received: by qyk11 with SMTP id 11so96536qyk.16
	for <alsa-devel@alsa-project.org>; Wed, 27 Jan 2010 17:52:54 -0800 (PST)
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

What's the best strategy for synchronizing alsa between multiple
machines within earshot of each other? I can synchronize the CPU
clocks to microsecond accuracy. But how do I deal with drift in the
audio clocks? Can I periodically stop the stream and restart it using
CPU clock? That would compensate for the audio clock drift.

-- 
Jon Smirl
jonsmirl@gmail.com
