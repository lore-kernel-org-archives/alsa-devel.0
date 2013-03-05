From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH] ALSA: usb: Work around CM6631 sample rate
 change bug
Date: Tue, 05 Mar 2013 08:55:03 +0100
Message-ID: <5135A4D7.2050301@ladisch.de>
References: <20130302130403.GD4452@pvv.ntnu.no> <5131FAC1.30007@gmail.com>
 <20130303192922.GE4452@pvv.ntnu.no> <s5hlia3ilzx.wl%tiwai@suse.de>
 <5134781F.4050607@ladisch.de> <20130304213311.GG4452@pvv.ntnu.no>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 345E9264FFF
 for <alsa-devel@alsa-project.org>; Tue,  5 Mar 2013 08:55:09 +0100 (CET)
In-Reply-To: <20130304213311.GG4452@pvv.ntnu.no>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Torstein Hegge <hegge@resisty.net>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

Torstein Hegge wrote:
> On Mon, Mar 04, 2013 at 11:31:59AM +0100, Clemens Ladisch wrote:
>>>>> On 02.03.2013 14:04, Torstein Hegge wrote:
>>>>>> +	case USB_ID(0x0d8c, 0x0304): /* C-Media - Schiit USB Interface */
>>>>>> +	case USB_ID(0x0d8c, 0x0309): /* C-Media CM6631 */
>>
>> There are other CM6631-based devices.
>
> Most CM6631 devices with sample rate change problems reported has one of those
> two ids, as far as I can see. The Asus Xonar Essence One uses the CM6631, but
> it is listed in the wiki as supported, without any comments about any such
> issue.

I vaguely remember some such report.  Better add this (0b05:17a8).

> I don't know what vendor/product id the Emotiva XDA-2 reports.

>From that driver's .inf file:

%CMUACWO.DeviceDesc%=CMUACWO,USB\VID_0D8C&PID_0301&MI_00
%CMUACWO.DeviceDesc%=CMUACWO,USB\VID_0D8C&PID_0302&MI_00
%CMUACWO.DeviceDesc%=CMUACWO,USB\VID_0D8C&PID_0304&MI_00
%CMUACWO.DeviceDesc%=CMUACWO,USB\VID_0D8C&PID_0305&MI_00
%CMUACWO.DeviceDesc%=CMUACWO,USB\VID_0D8C&PID_0306&MI_00
%CMUACWO.DeviceDesc%=CMUACWO,USB\VID_0D8C&PID_0309&MI_00
%CMUACWO.DeviceDesc%=CMUACWO,USB\VID_0D8C&PID_0310&MI_00
%CMUACWO.DeviceDesc%=CMUACWO,USB\VID_0D8C&PID_0311&MI_00	;CM6610A
%CMUACWO.DeviceDesc%=CMUACWO,USB\VID_0D8C&PID_0312&MI_00	;CM6620A
%CMUACWO.DeviceDesc%=CMUACWO,USB\VID_0D8C&PID_0313&MI_00	;CM6630A
%CMUACWO.DeviceDesc%=CMUACWO,USB\VID_0D8C&PID_0314&MI_00	;CM6631A
%CMUACWO.DeviceDesc%=CMUACWO,USB\VID_0D8C&PID_0319&MI_00	;CM6631A
%CMUACWO.DeviceDesc%=CMUACWO,USB\VID_0D8C&PID_0315&MI_00	;CM6632A
%CMUACWO.DeviceDesc%=CMUACWO,USB\VID_200C&PID_1030&MI_00
%CMUACWO.DeviceDesc%=CMUACWO,USB\VID_054C&PID_06CF&MI_00

(200c = Reloop, 054c = Sony)


Regards,
Clemens
