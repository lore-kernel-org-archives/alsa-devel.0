From: Bent Bisballle Nyeng <deva@aasimon.org>
Subject: Intel HDA: Realtek ALC260 - jack plugging event
	interface
Date: Mon, 21 Mar 2011 09:51:25 +0100
Message-ID: <201103210951.25985.deva@aasimon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from twilight.aasimon.org (aasimon.org [87.63.217.174])
	by alsa0.perex.cz (Postfix) with ESMTP id A8734103856
	for <alsa-devel@alsa-project.org>; Mon, 21 Mar 2011 09:51:28 +0100 (CET)
Received: from deva.localnet (deva [192.168.0.10])
	by twilight.aasimon.org (Postfix) with ESMTP id 7B8D7BC1F
	for <alsa-devel@alsa-project.org>; Mon, 21 Mar 2011 09:51:26 +0100 (CET)
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

Hello

I have a FitPC2 with an Realtek ALC260 chip.
In the kernel config I have enabled CONFIG_SND_HDA_INPUT_JACK which reads 
"enable the jack plugging notification via input layer" in the kernel help 
text.

I do however not see any /dev/input/eventX node for the events.
Is there another way in which I can read the jack plugging notification events 
from a C program?

I have run til ALSA Iformation script with the following result:
http://www.alsa-project.org/db/?f=7f6d755a504980cd0494ee9b87850c1dee7f8f03

Thank you in advance.
Bent Bisballe Nyeng
