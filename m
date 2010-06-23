From: Pavel Hofman <pavel.hofman@ivitera.com>
Subject: Re: IEC switch issues
Date: Wed, 23 Jun 2010 10:55:52 +0200
Message-ID: <4C21CC18.3030200@ivitera.com>
References: <AANLkTinpl5hs7NRAm38uF7FbGCOuIOxCvohD70jOQxam@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cable.insite.cz (upc-plzen.insite.cz [84.242.100.8])
	by alsa0.perex.cz (Postfix) with ESMTP id 68A7C243AE
	for <alsa-devel@alsa-project.org>;
	Wed, 23 Jun 2010 10:55:54 +0200 (CEST)
In-Reply-To: <AANLkTinpl5hs7NRAm38uF7FbGCOuIOxCvohD70jOQxam@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: pl bossart <bossart.nospam@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org



pl bossart napsal(a):
> If I play my AC3 data on my HDAudio/SPDIF output using the hw:0,1
> device, I can use alsamixer/amixer to mute/unmute.
> 
> [ume@plb PassThough]$ amixer cset numid=12 on
> numid=12,iface=MIXER,name='IEC958 Playback Switch'
>   ; type=BOOLEAN,access=rw------,values=1
>   : values=on
> [ume@plb PassThough]$ amixer cset numid=12 off
> numid=12,iface=MIXER,name='IEC958 Playback Switch'
>   ; type=BOOLEAN,access=rw------,values=1
>   : values=off
> 
> Now if I use the iec958: plugin, I can't control the mute switch any longer:
> [ume@plb PassThough]$ amixer cset numid=12 off
> amixer: Control default element write error: Operation not permitted
> 
> [ume@plb PassThough]$ amixer cset numid=12 on
> amixer: Control default element write error: Operation not permitted
> 
> What could possibly cause this issue? the IEC plugin relies on the
> device 1, am I missing something here?
> Thanks for your help
> - Pierre

Hi Pierre,

Check the config files in /usr/share/alsa/cards, probably HDA-Intel.conf
in your case, specifically the hooks section of its iec958 device
definition. It reads:

hooks.0 {
                        type ctl_elems
                        hook_args [
                        {
                                name "IEC958 Playback Default"
                                lock true
                                preserve true
                                value [ $AES0 $AES1 $AES2 $AES3 ]
                        }
                        {
                                name "IEC958 Playback Switch"
                                lock true
                                preserve true
                                value true
                        }
                        ]
                }


You can play with the "lock" directive.

Best regards,

Pavel.
