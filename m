From: Rolf Theunissen <rolf.theunissen@gmail.com>
Subject: Hardware events
Date: Mon, 29 Nov 2010 12:54:43 +0100
Message-ID: <4CF39483.4050704@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51]) by alsa0.perex.cz (Postfix) with ESMTP id 6C8562452B
	for <alsa-devel@alsa-project.org>; Mon, 29 Nov 2010 12:54:46 +0100 (CET)
Received: by ewy19 with SMTP id 19so1822211ewy.38
	for <alsa-devel@alsa-project.org>; Mon, 29 Nov 2010 03:54:46 -0800 (PST)
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

Hello,

For some hardware devices (for instance the ThinkPad EC) the volume can 
be changed by (only) hardware buttons. Changes in the the hardware 
mixers are notified in the driver via the function "snd_ctl_notify" with 
the mask SNDRV_CLT_EVENT_MASK_VALUE.
For notification of volume changes to the users of the system, an OSD 
can be used. To implement such a OSD, it must be possible to respond to 
changes done by the hardware.

This raises the following question: is it possible to detect the events 
originating from the hardware in the functions that handle the callbacks 
(set via snd_mixer_elem_set_callback/snd_hctl_elem_set_callback)? This 
would allow to implement an OSD that only responds to the hardware 
buttons and that would ignore events originating from "software".

Thanks
