From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 20/21] ASoC: codecs: Enable AB8500 CODEC for Device Tree
Date: Thu, 26 Jul 2012 16:19:33 +0100
Message-ID: <50116005.6050008@linaro.org>
References: <1343298534-13611-1-git-send-email-lee.jones@linaro.org> <1343298534-13611-21-git-send-email-lee.jones@linaro.org> <20120726115055.GD3099@opensource.wolfsonmicro.com> <501150E5.6010503@linaro.org> <20120726144336.GL3099@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120726144336.GL3099@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, STEricsson_nomadik_linux@list.st.com, linus.walleij@stericsson.com, arnd@arndb.de, sameo@linux.intel.com, olalilja@yahoo.se, ola.o.lilja@stericsson.com, alsa-devel@alsa-project.org, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On 26/07/12 15:43, Mark Brown wrote:
> On Thu, Jul 26, 2012 at 03:15:01PM +0100, Lee Jones wrote:
>> Sorry missed this:
>
>>> Why are we doing this?  The MFD cells are a totally Linux specific
>>> thing, there's no reason to represent them in the device tree unles=
s
>>> they're in some way reusable and the "ab8500-codec" name suggests t=
hat's
>>> unlikely.  Just put the properties on the parent node and instantia=
te
>>> the MFD cell as normal.
>
>> We have all of the AB8500 devices into the Device Tree to accurately
>> represent the hardware. We will also be passing configuration
>> information into the AB8500 Codec from Device Tree. The only reason
>> we're still registering them using the MFD API is to overcome
>> addressing issues encountered earlier. Each 'device' still belongs
>> in the 'device' tree.
>
> The device here is the AB8500.  The fact that Linux chooses to repres=
ent
> it as an MFD with a particular set of subdrivers is a Linux specific
> decision and may well change over time.  For example it's likely that
> we'll want to migrate the clocks out of the audio driver and into the
> clock API when that becomes useful.  Similarly currently a lot of the=
se
> devices use ASoC level jack detection but that's going to move over t=
o
> extcon over time.
>
> There's no way you're going to be able to reuse this for anything tha=
t
> isn't an AB8500, there's no abstraction of the SoC integration here. =
 If
> you had clearly identifiable, repeatable IPs which you could reasonab=
ly
> bind to a different bit of silicon then that'd be different but there=
's
> nothing like that here.  We already know that the functionality cover=
ed
> by the driver is going to be present simply by virtue of knowing that
> there's an AB8500 and similarly there's no real way this driver could
> ever be used without the core driver.  All the "device" in the device
> tree is doing is serving as a container to place some of the DT
> properties into, this needs to be separated out from the instantiatio=
n
> of the Linux device driver.  There's nothing stopping the driver from
> looking at the OF node of its parent here.
>
> The goal here isn't just to copy the Linux device model and platform
> data into device tree bindings, the device tree bindings need to thin=
k
> about what the chip actually is so they can be reused by other OSs an=
d
> by future versions of Linux.
>
>> If we were to take this Device Tree and use it on something
>> non-Linux, that OS will still need to know about each of the AB8500
>> devices and every associated configuration option. Only in Linux do
>> we continue to register them though a different API, which doesn't
>> affect any other OS.
>
> Another OS might have a different idea about how it's going to split =
up
> the chip which better fits with the models which that OS has for the
> functions present on the device.  The reason this is a distinct devic=
e
> in Linux is all to do with how Linux models the hardware.

Okay, so your suggestion is to strip out all of the sub-devices under=20
the AB8500. It's doable, but will take some restructuring and thinking=20
about. This is a job for another day. I think it's okay to continue wit=
h=20
the current semantics for the time-being. The line we're discussing doe=
s=20
need to be split out though. I didn't mean to merge it in with the ASoC=
=20
stuff.

--=20
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
