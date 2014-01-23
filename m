From: LANGLOIS Olivier PIS -EXT <olivier.pis.langlois@transport.alstom.com>
Subject: Re: [ISSUE] rtl8192ce appears to
	interfere	with	ALSA	playback
Date: Thu, 23 Jan 2014 16:36:45 +0000
Message-ID: <89F8E4011FD7234ABFE48744E300CBC206BCE7C6@041-DB3MPN1-092.041d.mgd.msft.net>
References: <1389767820.2436.45.camel@Wailaba2>
 <52D6BEEF.5050705@lwfinger.net>	<52D76D56.6060906@trillion01.com>
 <20140116055547.GU19393@us.netrek.org>	<1390464800.2436.111.camel@Wailaba2>
 <s5htxcvt718.wl%tiwai@suse.de>
 <89F8E4011FD7234ABFE48744E300CBC206BCE732@041-DB3MPN1-092.041d.mgd.msft.net>
 <89F8E4011FD7234ABFE48744E300CBC206BCE752@041-DB3MPN1-092.041d.mgd.msft.net>
 <s5h38keu0h8.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from as-smtp3.itc.alstom.com (as-smtp3.itc.alstom.com
 [159.245.16.38])
 by alsa0.perex.cz (Postfix) with ESMTP id 31E4C265253
 for <alsa-devel@alsa-project.org>; Thu, 23 Jan 2014 17:37:11 +0100 (CET)
In-Reply-To: <s5h38keu0h8.wl%tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: Olivier Langlois <olivier@trillion01.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "daniel@zonque.org" <daniel@zonque.org>
List-Id: alsa-devel@alsa-project.org

> > As small unrelated sidenote,
> >
> > If I let aplay choose the hw params itself, how comes it ends up with 16
> periods when it calculates the period time to have 4 periods?
>
> How 4 periods come up...?
> period_time = period_size / rate.
>
>
I was referring to this code in aplay.c:set_params():

        if (period_time == 0 && period_frames == 0) {
                if (buffer_time > 0)
                        period_time = buffer_time / 4;
                else
                        period_frames = buffer_frames / 4;
        }

and I think that usually periods_num ~= buffer_time/period_time or buffer_size/period_size

aplay -Dhw:0,0 sine_48000.wav

I have:

  buffer_size  : 24000
  period_size  : 6000
  period_time  : 125000

but with the default dmix setup: aplay -v sine_48000.wav:

  buffer_size  : 16384
  period_size  : 1024
  period_time  : 21333


________________________________
CONFIDENTIALITY : This e-mail and any attachments are confidential and may be privileged. If you are not a named recipient, please notify the sender immediately and do not disclose the contents to another person, use it for any purpose or store or copy the information in any medium.
