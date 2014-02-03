From: Hubert Denkmair <hubert@denkmair.de>
Subject: =?utf-8?q?mentoring_for_open_sound_hardware_project?=
	=?utf-8?q?=3F?=
Date: Mon, 03 Feb 2014 11:43:36 +0200
Message-ID: <6b13108559968f4fca18b21420753eaa@little-isp.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mxout.aspect-it.de (mxout.aspect-it.de [78.46.235.169])
 by alsa0.perex.cz (Postfix) with ESMTP id 978042602F3
 for <alsa-devel@alsa-project.org>; Mon,  3 Feb 2014 10:43:36 +0100 (CET)
Received: from localhost ([127.0.0.1] helo=mail.aspect-it.de)
 by mail.aspect-it.de with esmtp (Exim 4.71)
 (envelope-from <hubert@denkmair.de>) id 1WAG40-0000ts-Ax
 for alsa-devel@alsa-project.org; Mon, 03 Feb 2014 10:43:36 +0100
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

 Hello list,

 I'm currently pushing a project for free audio hardware (basically a 
 digital audio interface / mixer with attached linux system).
 The details are not final yet, but the design involves a FPGA for audio 
 routing and a ARM SoC board for recording, playback etc.
 Plan is to support quite a few channels on the linux side, say 20 in, 
 20 out at 96kHz/24bit.

 Of course, this needs a Alsa driver.

 My question is: Is there a "best way" to do the FPGA<->Linux 
 connection?
 Using the linux GPMC system for communication is the best thing we came 
 up with until now.

 Are there already drivers doing something alike that we could build 
 upon?
 Since there is no kernel developer in our team (yet), is someone on 
 this list willing to mentor our driver development?

 Greetings,

 Hubert Denkmair
