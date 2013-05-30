From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: aplay lists both Playback and Capture devices
Date: Thu, 30 May 2013 13:23:50 +0200
Message-ID: <51A736C6.2060500@ladisch.de>
References: <CAOMZO5Cq8xSj3fGoZEO+K5xxJNfHotC2PiuX62q+p+yw1-i9Ng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id E4FFD265121
 for <alsa-devel@alsa-project.org>; Thu, 30 May 2013 13:23:54 +0200 (CEST)
In-Reply-To: <CAOMZO5Cq8xSj3fGoZEO+K5xxJNfHotC2PiuX62q+p+yw1-i9Ng@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: =?windows-1252?Q?Marek_Va=9Aut?= <marex@denx.de>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

Fabio Estevam wrote:
> When running 'aplay -l' and 'arecord -l' I see the following output on
> a mx28evk running a 3.10-rc kernel:
>
> $ aplay -l
> card 0: mxssgtl5000 [mxs_sgtl5000], device 0: Playback sgtl5000-0 []
> card 0: mxssgtl5000 [mxs_sgtl5000], device 1: Capture sgtl5000-1 []
> $ arecord -l
> card 0: mxssgtl5000 [mxs_sgtl5000], device 0: Playback sgtl5000-0 []
> card 0: mxssgtl5000 [mxs_sgtl5000], device 1: Capture sgtl5000-1 []
>
> I would expect to see only the Playback entry in aplay and only the
> Record entry in arecord.

Please show the contents of /proc/asound/devices.


Regards,
Clemens
