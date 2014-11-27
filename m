From: Eli Britstein <Eli.Britstein@audiocodes.com>
Subject: ALSA/ASOC new device and routing
Date: Thu, 27 Nov 2014 09:21:09 +0000
Message-ID: <E0C3DF2A36210C42B1AB4626A0E10F1FD948C13C@aclmbx01.corp.audiocodes.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from incoming.audiocodes.com (mail1.audiocodes.com [195.189.193.19])
 by alsa0.perex.cz (Postfix) with ESMTP id DDD0D265A13
 for <alsa-devel@alsa-project.org>; Thu, 27 Nov 2014 10:21:10 +0100 (CET)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi

I'm a newbie to ALSA.
I'm targeting to use ALSA or ASoC solution in order to route capture/playback streams of a USB headset (that uses ALSA) to/from my own DSP device.
I saw DPCM which is a part of ASoC manages dynamically connections between FE and BE streams.
In my product, I just need them to be connected. No need for the "dynamically" part.

My questions:
1. Can someone please recommend a step by step guide, or an example how to make my DSP "look like" a BE? Do I need to write an ALSA driver for it or a ASOC driver?
2. After I have it as a BE, how can I connect the streams? I want the transfers to be done in kernel level, without need for application interventions for each buffer.
3. I'm using kernel 2.6.10 (quite old, I know). I don't want to port my entire kernel to a new one. As my requirement is not very complex, I don't think I'd encounter too many issues. However, if someone can point the important parts I need to back port, I'd appreciate it. Alternatively, if someone sees a showstopper in this approach, I'd be grateful to be aware of it.


Thanks,
Best regards,

Eli

________________________________

This email and any files transmitted with it are confidential material. They are intended solely for the use of the designated individual or entity to whom they are addressed. If the reader of this message is not the intended recipient, you are hereby notified that any dissemination, use, distribution or copying of this communication is strictly prohibited and may be unlawful.

If you have received this email in error please immediately notify the sender and delete or destroy any copy of this message
