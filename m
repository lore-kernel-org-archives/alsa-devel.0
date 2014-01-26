From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: External sound card issue
Date: Sun, 26 Jan 2014 19:01:31 +0100
Message-ID: <52E54D7B.3040408@ladisch.de>
References: <CAEiHY5j=K874m_Jk7ws4eOqts855oSHqY0HUrp_A5WwxFoDr=Q@mail.gmail.com>	<52DD1A66.9050909@ladisch.de>
 <CAN8cciYR_9Le-tX-CLBjfnYQ1+CuexKzxpxberVkkV6jR_c50A@mail.gmail.com>
 <1390398693.24097.YahooMailNeo@web162304.mail.bf1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id BD0F2261A09
 for <alsa-devel@alsa-project.org>; Sun, 26 Jan 2014 19:01:46 +0100 (CET)
In-Reply-To: <1390398693.24097.YahooMailNeo@web162304.mail.bf1.yahoo.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ionica Bizau <bizauionica@yahoo.com>
Cc: Raymond Yau <superquad.vortex2@gmail.com>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Ionica Bizau <bizauionica@gmail.com>
List-Id: alsa-devel@alsa-project.org

Ionica Bizau wrote:
> $ amixer -c1 cget name='PCM Capture Source'
> numid=7,iface=MIXER,name='PCM Capture Source'
>   ; type=ENUMERATED,access=rw------,values=1,items=2
>   ; Item #0 'Unit 22'
>   ; Item #1 'Unit 22'
> amixer: Control hw:1 element read error: Broken pipe

The device's firmware does not allow reading this mixer control for some
reason; this is probably a bug.

Please try the following commands:
  rmmod snd-usb-audio
  modprobe snd-usb-audio ignore_ctl_error=1

This makes the driver ignore errors, but cannot prevent the errors from
happening in the first place.  Please check if you get the desired
effect when you write this control.


Regards,
Clemens
