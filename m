From: Lollul <lollul@wp.pl>
Subject: Re: Audiotrak Maya U5 mixer
Date: Tue, 24 Jul 2012 09:30:10 +0200
Message-ID: <500E4F02.8010102@wp.pl>
References: <500D6A52.5080400@wp.pl> <500D6C37.5050001@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx3.wp.pl (mx3.wp.pl [212.77.101.7])
 by alsa0.perex.cz (Postfix) with ESMTP id A6D9B264FBB
 for <alsa-devel@alsa-project.org>; Tue, 24 Jul 2012 09:30:11 +0200 (CEST)
In-Reply-To: <500D6C37.5050001@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 23.07.2012 17:22, Daniel Mack wrote:
> On 23.07.2012 17:14, Lollul wrote:
>> Hello,
>> I'm using an Audiotrak Maya U5 USB card. As far as I can tell it is
>> based on VIA EnvyUSB VT1728A chip. Running on fresh 3.5-rc7 or an old
>> 2.6.32.27 (on openwrt) kernel I have similar problems with the mixer:
>> 1.
>> The controls PCM and PCM 1 are stuck on lowest level. It can play mp3s
>> fine so I guess PCM is initialized somehow on proper levels but I would
>> expect there should be a way to control PCM volume (other than by
>> controlling Speaker volume).
>> 2.
>> I'm unable to achieve a 'loop' between SPDIF input and the Speakers. It
>> works fine with Line-In. But with SPDIF input I have to either use
>> "arecord | aplay" or alsaloop. Since Windows7 is able to turn on
>> 'Listen' mode on SPDIF input on standard drivers I hope hardware can do
>> it but somehow there is no control for this in alsamixer.
> Why are you so sure the audio is looped internally?
>
> If there is such a mode and that functionality is not exported as
> standard USB mixer unit control, there is most probably a vendor
> specific command the Windows driver sends to the device. In that case,
> you would need to install some USB sniffer tool and trace the
> communication. Once you found out what's happening under the hood, it
> should be easy to add that feature to the Linux driver.
>
> You could also try and just ask the vendor about this specific detail,
> but usually that won't bring you anywhere.
>
>
> Daniel
>
I've played with USB sniffer under Windows7 and XP with standard driver 
and the one supplied by the vendor. Turns out that in fact there is no 
"Wave" (PCM) mixer control. Also, the 'loop' from SPDIF input to 
Speakers is achieved in software by Windows sound server. Same thing I 
can achieve with the wonderful alsaloop.
Overall I'm not impressed with this hardware...

Thanks for help!
Rafal
