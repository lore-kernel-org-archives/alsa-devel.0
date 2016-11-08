From: Hermes Zhang <chenhui.zhang@axis.com>
Subject: How to transfer data to the endpoint (e.g. .wav file)
 in alsa external I/O plugin
Date: Tue, 8 Nov 2016 06:45:07 +0000
Message-ID: <c4e83708c1c94476809093f5c76ce69e@XBOX03.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bes.se.axis.com (bes.se.axis.com [195.60.68.10])
 by alsa0.perex.cz (Postfix) with ESMTP id C0C7A261A1A
 for <alsa-devel@alsa-project.org>; Tue,  8 Nov 2016 07:45:09 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by bes.se.axis.com (Postfix) with ESMTP id B6DA336368
 for <alsa-devel@alsa-project.org>; Tue,  8 Nov 2016 07:45:08 +0100 (CET)
Received: from bes.se.axis.com ([IPv6:::ffff:127.0.0.1])
 by localhost (bes.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id YyaK8wPvXuex for <alsa-devel@alsa-project.org>;
 Tue,  8 Nov 2016 07:45:07 +0100 (CET)
Received: from boulder03.se.axis.com (boulder03.se.axis.com [10.0.8.17])
 by bes.se.axis.com (Postfix) with ESMTPS id A8F1036367
 for <alsa-devel@alsa-project.org>; Tue,  8 Nov 2016 07:45:07 +0100 (CET)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6A2F11E0A7
 for <alsa-devel@alsa-project.org>; Tue,  8 Nov 2016 07:45:07 +0100 (CET)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5E1301E083
 for <alsa-devel@alsa-project.org>; Tue,  8 Nov 2016 07:45:07 +0100 (CET)
Received: from seth.se.axis.com (unknown [10.0.2.172])
 by boulder03.se.axis.com (Postfix) with ESMTP
 for <alsa-devel@alsa-project.org>; Tue,  8 Nov 2016 07:45:07 +0100 (CET)
Received: from XBOX02.axis.com (xbox02.axis.com [10.0.5.16])
 by seth.se.axis.com (Postfix) with ESMTP id 510E545F
 for <alsa-devel@alsa-project.org>; Tue,  8 Nov 2016 07:45:07 +0100 (CET)
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

Hi,

I'm a new in alsa plugin develop. Now I'm try to implement an I/O plugin for my platform in alsa. I can config the alsa plugin and start it, but when I'm deal with the data in the transfer api, I could not flush the data to the endpoint, e.g. .wav file.

I run below command to test my plugin:

arecord -D my_plug -c 1 -f S16_LE raw

I want to save the audio data to a wav file by my plugin. Then in my code, I try to write the data to the area structure like this:

static snd_pcm_sframes_t
my_read (snd_pcm_ioplug_t * io,
     const snd_pcm_channel_area_t * areas,
     snd_pcm_uframes_t offset, snd_pcm_uframes_t size)
{
     /* I got the audio data from other api here */

memcpy(areas->addr + areas->first + areas->step * offset, my_data, size);

}

But I could not get a correct wav file, there will be a file named "raw" but only with some wav file head, not real data include. Does anyone know anything I'm wrong? Is this the right way to handle the transfer data? Thanks.


Best  Regards,
Hermes
