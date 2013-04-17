From: Mike Looijmans <mike.looijmans@topic.nl>
Subject: Sample rates above 192000
Date: Wed, 17 Apr 2013 10:21:20 +0200
Message-ID: <516E5B80.804@topic.nl>
References: <516688D4.9040700@zonque.org> <5166959E.7010008@metafoo.de>
 <5166A649.2030509@gmail.com> <5166B247.807@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from atl4mhob08.myregisteredsite.com
 (atl4mhob08.myregisteredsite.com [209.17.115.46])
 by alsa0.perex.cz (Postfix) with ESMTP id 7305A265B7B
 for <alsa-devel@alsa-project.org>; Wed, 17 Apr 2013 10:21:22 +0200 (CEST)
Received: from mail.hostingplatform.com ([10.30.71.208])
 by atl4mhob08.myregisteredsite.com (8.14.4/8.14.4) with ESMTP id
 r3H8LLCu029557
 for <alsa-devel@alsa-project.org>; Wed, 17 Apr 2013 04:21:21 -0400
In-Reply-To: <5166B247.807@metafoo.de>
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

I'm trying to use "my" hardware at a 204800 sample rate. I've changed 
the DAI and codec limits to match. If I limit them to anything below 
192kHz, everything behaves as expected and I can record at up to that 
rate, also if that rate is not a multiple of 48k or 44k1 (using 
"SNDRV_PCM_RATE_KNOT" constant).

When I specifiy anything over 192000, I bump onto some ceiling, and I 
cannot figure out what's causing it. I patched alsa-utils to allow 
 >192000 already (there is a silly check on that in aplay.c which bails 
out early without asking the driver).

# arecord -D hw:ADC8 --duration=5 -f S32_LE -c 2 -r 204800 
/tmp/recording.wav
Recording WAVE '/tmp/recording.wav' : Signed 32 bit Little Endian, Rate 
204800 Hz, Stereo
Warning: rate is not accurate (requested = 204800Hz, got = 192000Hz)
          please, try the plug plugin
#
# arecord -D hw:ADC8 --duration=5 -f S32_LE -c 2 -r 192000 
/tmp/recording.wav
Recording WAVE '/tmp/recording.wav' : Signed 32 bit Little Endian, Rate 
192000 Hz, Stereo
#


I also tried a "grep" on the kernel (i'm still on 2.3.7 though) source 
files on "192000" but found nothing that would limit the sample rate to 
that. I'm running out of ideas. How can I break this limit? Or where in 
the kernel can I find the part that calculates the max rate?

Mike.
