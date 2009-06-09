From: Gernot Kohlhaas <gernot.kohlhaas@googlemail.com>
Subject: Re: SB X-Fi driver fixes (Re: Testers wanted: New SB
 X-Fi	driver)
Date: Tue, 09 Jun 2009 07:44:29 +0200
Message-ID: <4A2DF6BD.6060004@googlemail.com>
References: <1244140942.4550.2.camel@polo-desktop>	<s5hbpp1zpt9.wl%tiwai@suse.de>	<1244376026.6985.5.camel@polo-desktop>	<s5hk53oowhz.wl%tiwai@suse.de>	<s5hbpoz3pbj.wl%tiwai@suse.de>	<4A2D56C7.2090505@googlemail.com>	<s5hws7m7cfd.wl%tiwai@suse.de>	<4A2D7181.3040108@googlemail.com>	<s5h63f6f8qo.wl%tiwai@suse.de>	<4A2DF1EC.9060104@googlemail.com>
	<s5hab4ix8wo.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f218.google.com (mail-fx0-f218.google.com
	[209.85.220.218])
	by alsa0.perex.cz (Postfix) with ESMTP id A45EA244FD
	for <alsa-devel@alsa-project.org>;
	Tue,  9 Jun 2009 07:44:30 +0200 (CEST)
Received: by fxm18 with SMTP id 18so3641679fxm.32
	for <alsa-devel@alsa-project.org>; Mon, 08 Jun 2009 22:44:30 -0700 (PDT)
In-Reply-To: <s5hab4ix8wo.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai schrieb:
> At Tue, 09 Jun 2009 07:23:56 +0200,
> Gernot Kohlhaas wrote:
>> Takashi Iwai schrieb:
>>> Also, do you mean that the default output works without 1/3 second
>>> distortion?  Or, the distortion happens regardless of your PCM device
>>> setup?
>>>
>>> I'd like to concentrate on debugging the default setup at first,
>>> so better to reduce the risk of brokenness of ladspa plugin.
>>> If you get any severe problems with the default setup, please let me
>>> know more details.
>>>
>>>
>>> thanks,
>>>
>>> Takashi
>>>
>> No, this distortion happens "everywhere" when I compile the module with
>> --debug=full.
> 
> That's weird.  Do you get any kernel messages?
> 
Unfortunately not. Just the "standard" ones (when loading the module).

>> For the crashes: They only happen when I use the LADSPA low pass filter
>> AND when I am fast forwarding in xmms. When I don't use fast forwarding,
>> everything works fine. But I will try use_system_timer=1 when I get back
>> from work today.
>> It really seems like the plug-in is doing some weird stuff.
> 
> But the plugin itself cannot lead to a system crash.  It's the driver.
> 
> Do I understand correctly that your system locks up when this happens,
> right?  If yes, the cause might be the mmap mode access.
> 
Yes, it locks up. No kernel panic or something like that. A "hard"
lock-up/freeze.
> 
> Takashi
> 
> 


-- 
http://www.gnupp.de/verschluesselung/warum.html
Key ID: 0x4C0B2250
Key: http://home.arcor.de/mr_maniac/ANDERES/public.gpg
