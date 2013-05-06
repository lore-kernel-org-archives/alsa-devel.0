From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: [PATCH] ALSA: hda - delay resume haswell hdmi
 codec in system resume
Date: Mon, 6 May 2013 09:48:59 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F881E9A6@SHSMSX102.ccr.corp.intel.com>
References: <1364321572-2634-1-git-send-email-mengdong.lin@intel.com>
 <F46914AEC2663F4A9BB62374E5EEF8F83789F5@SHSMSX101.ccr.corp.intel.com>
 <5163B90C.20107@canonical.com>	<s5hhajg175u.wl%tiwai@suse.de>
 <F46914AEC2663F4A9BB62374E5EEF8F837A47F@SHSMSX101.ccr.corp.intel.com>
 <5163DC21.9020702@canonical.com>	<s5hmwt8xdf2.wl%tiwai@suse.de>
 <5164F8CF.6040905@canonical.com>	<s5h7gkb0wfa.wl%tiwai@suse.de>
 <5165006F.5070207@canonical.com>	<s5hzjx6zxld.wl%tiwai@suse.de>
 <5165412C.7050306@canonical.com>
 <F46914AEC2663F4A9BB62374E5EEF8F83826C6@SHSMSX101.ccr.corp.intel.com>
 <516BA618.5050104@canonical.com>
 <F46914AEC2663F4A9BB62374E5EEF8F8382D3B@SHSMSX101.ccr.corp.intel.com>
 <516E3873.5020507@canonical.com> <s5h61zld6s6.wl%tiwai@suse.de>
 <F46914AEC2663F4A9BB62374E5EEF8F839C586@SHSMSX101.ccr.corp.intel.com>
 <5183653D.90003@canonical.com>
 <F46914AEC2663F4A9BB62374E5EEF8F839C5C8@SHSMSX101.ccr.corp.intel.com>
 <F46914AEC2663F4A9BB62374E5EEF8F881C713@SHSMSX102.ccr.corp.intel.com>
 <518756DC.8030900@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
 by alsa0.perex.cz (Postfix) with ESMTP id AC644261AA2
 for <alsa-devel@alsa-project.org>; Mon,  6 May 2013 11:49:07 +0200 (CEST)
In-Reply-To: <518756DC.8030900@canonical.com>
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
To: David Henningsson <david.henningsson@canonical.com>
Cc: Takashi Iwai <tiwai@suse.de>, "Li, Jocelyn" <jocelyn.li@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Wang,
 Xingchao" <xingchao.wang@intel.com>, "Girdwood, Liam
 R" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: alsa-devel-bounces@alsa-project.org
> [mailto:alsa-devel-bounces@alsa-project.org] On Behalf Of David Henningsson
> Sent: Monday, May 06, 2013 3:08 PM
> To: Lin, Mengdong
> Cc: Takashi Iwai; Li, Jocelyn; alsa-devel@alsa-project.org; Girdwood, Liam R;
> Wang, Xingchao
> Subject: Re: [alsa-devel] [PATCH] ALSA: hda - delay resume haswell hdmi codec
> in system resume
> 
> The core of the problem is that the DDI port can sometimes be connected to a
> transcoder that in turn is connected to an audio codec pin which default pin
> config is set to "not connected". In this case, audio will not work correctly. (It
> might sometimes work by accident.)
> 
> The solution is that DDI to transcoder connection cannot change, it must always
> be connected to the audio codec pin which is marked as "jack".

Hi David,

The gfx driver will decide which pipe is used for a DDI port. And the connection can change by hot plug events.
The gfx driver will always try to use the 1st pipe if it's free, because the 1st pipe is not affected by the power down well.
Thus the user can get display while the other parts are turned off for power saving.

I think if everything is properly configured, the pin to DDI port mapping should not change even if the port is connected to a different transcoder.
There may be something wrong or missing in current audio or gfx driver.

> 
> Btw, even if all audio codec pins are marked as "jack", it would be a bad habit to
> change the connection, because people will be confused when we show these
> pins to the user as e g "HDMI 1", "HDMI 2" and "HDMI 3", and which one is
> corresponding to the physical output is varying.

Yes. This would confuse users.

Thanks
Mengdong
