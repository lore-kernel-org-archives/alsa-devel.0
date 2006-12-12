From: "James Courtier-Dutton" <james.dutton@gmail.com>
Subject: Re: what is the differenct between the mixer simple
	control and control?
Date: Tue, 12 Dec 2006 09:58:48 +0000
Message-ID: <ad2655cb0612120158s66dd10cbs4cab4de6fb3dbfde@mail.gmail.com>
References: <001701c71d91$29e119f0$9b01a8c0@LiYong>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.229])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id B3A5814C
	for <alsa-devel@alsa-project.org>; Tue, 12 Dec 2006 10:58:49 +0100 (MET)
Received: by wr-out-0506.google.com with SMTP id i11so794690wra
	for <alsa-devel@alsa-project.org>; Tue, 12 Dec 2006 01:58:48 -0800 (PST)
In-Reply-To: <001701c71d91$29e119f0$9b01a8c0@LiYong>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: YongLi <sdliyong@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> numid=6,iface=MIXER,name='Radio Volume'
>   ; type=INTEGER,access=rw---,values=1,min=0,max=127,step=0
>   : values=-1026031472
> numid=8,iface=MIXER,name='Record Switch'
>   ; type=INTEGER,access=rw---,values=1,min=0,max=3,step=0
>   : values=-1026028812

See the values are not initialised correctly.
They should be in a range of 0 to 3.

> However, in the device driver, all these controls are the same settings:
> {
>   .ctl  = &snd_tlv320aic23_ctl,
>   .name  = "Record Switch",
>   .index  = RecordSource,

The index value is wrong. Leave it out, so that it defaults to 0.
The index is used if you have more that one control with the same
name, but if the index does not start at zero, the simple mixer will
not process it.

>   .reg  = TLV320AIC23_ANALOGPATH,
>   .def  = 0,
>   .shift  = 6,
>   .mask  = TLV320AIC23_APATH_SIDETONE15dB,
>   .min  = 0,
>   .max  = 3,
>  },
>  {
>   .ctl  = &snd_tlv320aic23_ctl,
>   .name  = "Sound Effect",
>   .index  = SoundEffect,
>   .reg  = TLV320AIC23_ANALOGPATH,
>   .def  = 1,
>   .shift  = 4,
>   .mask  = TLV320AIC23_APATH_DACEN,
>   .min  = 0,
>   .max  = 3,
>  },
>
> How to change this setting to simple control?
>
> Thank you
>
> Tyler Li
>

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
