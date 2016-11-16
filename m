From: Hermes Zhang <chenhui.zhang@axis.com>
Subject: Alsa io plugin crash question
Date: Wed, 16 Nov 2016 07:52:22 +0000
Message-ID: <644abd4f8a344e6a86cbc80807f935d1@XBOX03.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
 by alsa0.perex.cz (Postfix) with ESMTP id D6EE22614A0
 for <alsa-devel@alsa-project.org>; Wed, 16 Nov 2016 08:52:24 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by bastet.se.axis.com (Postfix) with ESMTP id 0FC941818D
 for <alsa-devel@alsa-project.org>; Wed, 16 Nov 2016 08:52:24 +0100 (CET)
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
 by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 3Rn0XicEwCCn for <alsa-devel@alsa-project.org>;
 Wed, 16 Nov 2016 08:52:23 +0100 (CET)
Received: from boulder02.se.axis.com (boulder02.se.axis.com [10.0.8.16])
 by bastet.se.axis.com (Postfix) with ESMTPS id F1E6518153
 for <alsa-devel@alsa-project.org>; Wed, 16 Nov 2016 08:52:22 +0100 (CET)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D6AC11A082
 for <alsa-devel@alsa-project.org>; Wed, 16 Nov 2016 08:52:22 +0100 (CET)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CB8B21A07F
 for <alsa-devel@alsa-project.org>; Wed, 16 Nov 2016 08:52:22 +0100 (CET)
Received: from seth.se.axis.com (unknown [10.0.2.172])
 by boulder02.se.axis.com (Postfix) with ESMTP
 for <alsa-devel@alsa-project.org>; Wed, 16 Nov 2016 08:52:22 +0100 (CET)
Received: from XBOX04.axis.com (xbox04.axis.com [10.0.5.18])
 by seth.se.axis.com (Postfix) with ESMTP id BFB42375
 for <alsa-devel@alsa-project.org>; Wed, 16 Nov 2016 08:52:22 +0100 (CET)
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

Hi all,

I am try to write a plugin in alsa io plugin mode

static snd_pcm_sframes_t
my_read (snd_pcm_ioplug_t * io,
     const snd_pcm_channel_area_t * areas,
     snd_pcm_uframes_t offset, snd_pcm_uframes_t size)
{

 }

In above function, I will copy the audio data to areas with calculate the offset like this:

memcpy((char *) areas->addr + (areas->first + areas->step * offset) / 8, data, size);

But after serveral calls, the application crash, and I print the "offset" value, it seem always increase, when reach one number (e.g. 66560) it crash. So my question is: is the "offset" value always increase is expected? Or does it should like a ring buffer, so it should start from begin again? I see there is hw_pointer and app_pointer, but they are both read_only, right? How could we adjust the read pointer? Thanks.

BTW, I test the plugin in this way:

arecord -D my_plug -c 1 -f S16_LE raw

Best Regards,
Hermes
