From: "Taipei Techwell" <techwell.taipei@gmail.com>
Subject: OSS emulatior can not create enough device files for me
Date: Tue, 26 Aug 2008 18:08:33 +0800
Message-ID: <2b8924330808260308r8f241f5l222762cdff0ffa17@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from po-out-1718.google.com (po-out-1718.google.com [72.14.252.157])
	by alsa0.perex.cz (Postfix) with ESMTP id 2940410381F
	for <alsa-devel@alsa-project.org>;
	Tue, 26 Aug 2008 12:08:34 +0200 (CEST)
Received: by po-out-1718.google.com with SMTP id b23so3491820poe.2
	for <alsa-devel@alsa-project.org>; Tue, 26 Aug 2008 03:08:33 -0700 (PDT)
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
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,
I am working on an ALSA audio driver for my device which is very similar to
BT878. It will have at least 8 audio devices in a single card. Now, the
audio driver is working correctly. I can use aplay to play the audio file
which is created by arecord. To identify audio devices, I am using hw:1 ~
hw:8 dvice description for my audio devices, because hw:0 is the sound card.
In order to make the old application work, I know that ALSA emulates all my
devices to have OSS nodes respectively. I guess that It should have /dev/dsp
to /dev/dsp8, and /dev/dsp is for sound card, and /dev/dsp1 to /dev/dsp8 are
for my audio devices. However, I can not find /dev/dsp8 in my system. I
guess ALSA can only emulate 8 audio device totally. That the reason I can
not see the 8th audio device. Am I right? How can I create the /dev/dsp8
manually?
By the way, if someting is wrong above, please correct me. Thank you.
