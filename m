From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Surround and SPDIF on STAC9277
Date: Sat, 24 May 2008 14:29:27 -0400
Message-ID: <9e4733910805241129g784fd7a2k7b33f1a154a92584@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.183])
	by alsa0.perex.cz (Postfix) with ESMTP id 73287243AF
	for <alsa-devel@alsa-project.org>;
	Sat, 24 May 2008 20:29:29 +0200 (CEST)
Received: by py-out-1112.google.com with SMTP id a29so704876pyi.36
	for <alsa-devel@alsa-project.org>; Sat, 24 May 2008 11:29:28 -0700 (PDT)
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
To: ALSA-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

How are you supposed to get 5.1 audio out of your PC? When I hook the
SPDIF device from my STAC9227/HDA audio up to pulse, pulse says that
the SPDIF channel only supports stereo.

So I go digging around the in STAC9227 datasheet.
http://www.idt.com/?genID=STAC9227

STAC9227 codec only supports 192Khz SPDIF with 4/1*48Khz channels. It
doesn't support 384Khz with 8/1*48Khz channels.

So there are two problems, first the existing Intel HDA/STAC9227
driver is not exposing the 4 channel SPDIF support. Or I can't figure
out how to get to it.

Second, the hardware doesn't seem to support any way to get digital
5.1 audio out of the codec and into my Sony amp. STAC9227 does have
six channel analog out, but my Sony amp doesn't have 6 channel analog
in. Sony amp supports 384Khz 8-channel SPDIF in.

-- 
Jon Smirl
jonsmirl@gmail.com
