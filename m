From: "Champ, Andy" <andycham@amazon.co.uk>
Subject: Playing mono files on a stereo only device
Date: Fri, 18 Mar 2016 16:34:21 +0000
Message-ID: <1458318844851.58479@amazon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com
 [207.171.189.228])
 by alsa0.perex.cz (Postfix) with ESMTP id E3C772625EE
 for <alsa-devel@alsa-project.org>; Fri, 18 Mar 2016 17:34:45 +0100 (CET)
Received: from ex10-hub-7002.ant.amazon.com (pdx1-ws-svc-lb16-vlan3.amazon.com
 [10.239.138.214])
 by email-inbound-relay-64011.pdx4.amazon.com (8.14.7/8.14.7) with ESMTP id
 u2IGYXHA029085
 (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL)
 for <alsa-devel@alsa-project.org>; Fri, 18 Mar 2016 16:34:43 GMT
Content-Language: en-GB
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

Hi All,


I'm new to this area, so please forgive any too-obvious questions.


I'm working on a device driver for an SOC. The audio device is connected via an I2S bus, which is inherently stereo. The driver code that I've inherited (from a similar, but not the same, chip) claimed to support mono - but didn't. I've changed the configuration in the device's snd_soc_dai_driver structure to stereo only (channels_min=channels_max=2) and everything works fine when playing a stereo file.


AIUI an Alsa plug should be able to take a mono file, convert it on the fly to stereo, and play that out. I've spent a couple of days playing with it, and not really got anywhere.


Does anyone have an example where this is being done on an SOC?


Currently the error I am having indicates that it's a problem with access. An IOCTL is being sent by the ALSA code to the kernel, of type SNDRV_PCM_IOCTL_HW_REFINE, requesting an access. This fails.


I've not even been able to decide if an access is meant to be a mask or a value. The type is

typedef int __bitwise snd_pcm_access_t;

which would tend to say it's mask (bitwise?) though I am guessing here, but the values are 0 1 2 3 4 - which says it isn't. Just to really confuse me the mask is logged as 7.


Is there anything which explains what this snd_pcm_access_t is?


Thanks
