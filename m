From: Andrew Udvare <ddrtist@gmail.com>
Subject: HDMI output with headphone jack sense possible on
	Conexant CX20561?
Date: Thu, 18 Mar 2010 11:09:02 -0400
Message-ID: <201003181109.02063.audvare@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.154])
	by alsa0.perex.cz (Postfix) with ESMTP id 1EAA224542
	for <alsa-devel@alsa-project.org>; Thu, 18 Mar 2010 16:09:10 +0100 (CET)
Received: by fg-out-1718.google.com with SMTP id l26so91361fgb.2
	for <alsa-devel@alsa-project.org>; Thu, 18 Mar 2010 08:09:09 -0700 (PDT)
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

My audio codec is Conexant CX20561 (Hermosa) (haven't been able to find 
anything about 'Hermosa' on the Wiki).

I'd like to be able to do a few things which I have not been able to do with 
tutorials I found on the web:

- Whenever I plug in headphones, HDMI output is muted and headphones are 
enabled
  - Right now, the way I do this is by manually editing /etc/asound.conf to 
have the following (commented out makes headphones work, not commented makes 
HDMI work without any headphone/laptop speaker output)

/etc/asound.conf:
defaults.pcm.card 0
defaults.pcm.device 3

where 3 is my HDMI (IEC958 2; no idea what IEC958 1 is for) output. So I have 
a switcher script that does the commenting and uncommenting. Would be nice if 
this could be automatic (even if alsa had to run such a script on detecting 
headphones).

- Route audio output (PCM) to input (for mixer recording) (Intel HDA cannot do 
this apparently by default (thanks DRM), needs some hacking around?)

Information from alsa-info.sh: http://www.alsa-
project.org/db/?f=107f3f6012e68f04d3562d5e11aeb052a1454884

Are my model options correct?

And if it's important to know, I build ALSA in-kernel. Is this not 
recommended? I know at the very least it makes it such that I have to reboot 
to make any new options to take effect.

Thanks all
-- 
Andrew Udvare
audvare@gmail.com
978-870-5908
www.andyudvare.com
