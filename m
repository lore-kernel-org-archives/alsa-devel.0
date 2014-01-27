From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: External sound card issue
Date: Mon, 27 Jan 2014 13:48:23 +0100
Message-ID: <52E65597.6040602@ladisch.de>
References: <CAEiHY5j=K874m_Jk7ws4eOqts855oSHqY0HUrp_A5WwxFoDr=Q@mail.gmail.com>	<52DD1A66.9050909@ladisch.de>	<CAN8cciYR_9Le-tX-CLBjfnYQ1+CuexKzxpxberVkkV6jR_c50A@mail.gmail.com>	<1390398693.24097.YahooMailNeo@web162304.mail.bf1.yahoo.com>	<52E54D7B.3040408@ladisch.de>	<1390765545.16173.YahooMailNeo@web162301.mail.bf1.yahoo.com>
 <s5ha9ehkdk5.wl%tiwai@suse.de>
 <1390824843.46971.YahooMailNeo@web162301.mail.bf1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id D3933261B35
 for <alsa-devel@alsa-project.org>; Mon, 27 Jan 2014 13:48:24 +0100 (CET)
In-Reply-To: <1390824843.46971.YahooMailNeo@web162301.mail.bf1.yahoo.com>
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
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Ionica Bizau wrote:
> When I run the first command:
>
> $ rmmod snd-usb-audio
> rmmod: ERROR: Module snd_usb_audio is in use

Exit all programs (such as PulseAudio) that might be using the device.

Alternatively, add the line

  options snd-usb-audio ignore_ctl_error=1

to some .conf file in /etc/modprobe.d/, and reboot.


Regards,
Clemens
