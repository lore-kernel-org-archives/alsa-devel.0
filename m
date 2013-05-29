From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: UCM {Supported,Conflicting}Device confusion
Date: Wed, 29 May 2013 09:12:42 -0600
Message-ID: <51A61AEA.4050602@wwwdotorg.org>
References: <51A5DEAA.4020007@tieto.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
 by alsa0.perex.cz (Postfix) with ESMTP id C7FBC264F00
 for <alsa-devel@alsa-project.org>; Wed, 29 May 2013 17:12:47 +0200 (CEST)
In-Reply-To: <51A5DEAA.4020007@tieto.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: =?ISO-8859-1?Q?Juho_H=E4m=E4l=E4inen?= <juho.hamalainen@tieto.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 05/29/2013 04:55 AM, Juho H=E4m=E4l=E4inen wrote:
> Hello,
> =

> Firstly as a sidenote, Supported/Conflicting is checked only one-way, if
> say devices A and B are enabled and say B has ConflictingDevice "C", and
> device C doesn't list anything, enabling of C is possible (and after
> that disabling C is not possible before B is disabled first).

It's been a long time since I touched the ConflictingDevice stuff, but
IIRC the idea was that every device would include a complete list of
Supported/Conflicting Devices, so there was only a need to check "one way".

> Now, looking at the way SupportedDevice and ConflictingDevice are
> implemented in ucm and I came to following conclusion:
> =

> If no SupportedDevice or ConflictingDevice: All devices and combinations
> are compatible, so implicit "SupportedDevice ALL".
> =

> If SupportedDevice is listed: Device can be enabled as long as at least
> one enabled device is in SupportedDevice list.
> =

> If ConflictingDevice is listed: Device can be enabled if none of active
> devices are in ConflictingDevice list (noting aforementioned limit in
> checking this)
> =

> This is at least how I figured all combinations of multiple devices can
> be defined with only zero or one either SupportedDevice or
> ConflictingDevice entry per device.
> =

> Did I understand this right?

That sounds about right, from my rusty memory.

Oh, the commit log specifies the behaviour:

>     UCM: Implement ConflictingDevices, add device list to devices
>     =

>     Wherever SupportedDevice can appear, also allow ConflictingDevice. On=
ly
>     one or the other (or neither) may be specified. When neither is
>     specified, allow anything. Sometimes, listing ConflictingDevices may
>     result in a shorter list than explicitly listing all SupportedDevices.
>     =

>     Add support for SupportedDevice and ConflictingDevice to SectionDevic=
e.
>     This allows representing devices which are mutually exclusive, e.g. d=
ue
>     to a mux that switches between capturing from two different microphon=
es,
>     without the possibility of mixing.
>     =

>     Enhance is_modifier_supported to allow ignoring SupportedDevice and
>     ConflictingDevice. This is useful when querying values from a
>     SectionModifier; there's no reason we shouldn't be able to query valu=
es
>     just because the current configuration would prevent enabling that
>     device. The new is_device_supported is implemented similarly.
>     =

>     Enhance switch_device to remove the old device from the current device
>     list before querying for the new device, and add it back immediately
>     afterwards. This allows the query for the new device to ignore any
>     conflicts caused solely by the old device.
