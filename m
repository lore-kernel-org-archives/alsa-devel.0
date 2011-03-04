From: David Cohen <dacohen@gmail.com>
Subject: Re: [GIT PULL FOR 2.6.39] Media controller and OMAP3 ISP driver
Date: Sat, 5 Mar 2011 00:49:04 +0200
Message-ID: <AANLkTi=2S2FUJmafdgz--ujKLXdyBZ4DVz1nbFzkU2DL@mail.gmail.com>
References: <201102171606.58540.laurent.pinchart@ideasonboard.com>
	<4D7164C6.9080503@redhat.com>
	<AANLkTi=p6S0CYv6=E51LHJprp1AZpd+ZymiVywaaUWOy@mail.gmail.com>
	<4D716B15.6090609@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <4D716B15.6090609@redhat.com>
Sender: linux-media-owner@vger.kernel.org
To: Mauro Carvalho Chehab <mchehab@redhat.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>, alsa-devel@alsa-project.org, Sakari Ailus <sakari.ailus@retiisi.org.uk>
List-Id: alsa-devel@alsa-project.org

On Sat, Mar 5, 2011 at 12:43 AM, Mauro Carvalho Chehab
<mchehab@redhat.com> wrote:
> Em 04-03-2011 19:33, David Cohen escreveu:
>> Hi Mauro,
>>
>> On Sat, Mar 5, 2011 at 12:16 AM, Mauro Carvalho Chehab
>> <mchehab@redhat.com> wrote:
>>> Hi Laurent,
>>>
>>> Em 17-02-2011 13:06, Laurent Pinchart escreveu:
>>>> Hi Mauro,
>>>>
>>>> The following changes since commit 85e2efbb1db9a18d218006706d6e4fb=
eb0216213:
>>>>
>>>> =C2=A0 Linux 2.6.38-rc5 (2011-02-15 19:23:45 -0800)
>>>>
>>>> are available in the git repository at:
>>>> =C2=A0 git://linuxtv.org/pinchartl/media.git media-0005-omap3isp
>>>
>>> I've added the patches that looked ok on my eyes at:
>>>
>>> http://git.linuxtv.org/mchehab/experimental.git?a=3Dshortlog;h=3Dre=
fs/heads/media_controller
>>>
>>> There are just a few small adjustments on a few of them, as I've co=
mmented.
>>> I prefer if you do them on separate patches, to save my work of not=
 needing
>>> to review the entire series again.
>>>
>>> The ones still pending on my quilt tree are:
>>>
>>> 0030-v4l-subdev-Generic-ioctl-support.patch
>>> 0040-omap3isp-OMAP3-ISP-core.patch
>>> 0041-omap3isp-Video-devices-and-buffers-queue.patch
>>> 0042-omap3isp-CCP2-CSI2-receivers.patch
>>> 0043-omap3isp-CCDC-preview-engine-and-resizer.patch
>>> 0044-omap3isp-Statistics.patch
>>> 0045-omap3isp-Kconfig-and-Makefile.patch
>>> 0046-omap3isp-Add-set-performance-callback-in-isp-platfor.patch
>>>
>>> with the following diffstat:
>>>
>>> =C2=A0Documentation/video4linux/v4l2-framework.txt =C2=A0 =C2=A0 =C2=
=A0 | =C2=A0 =C2=A05 +
>>> =C2=A0MAINTAINERS =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A06 +
>>> =C2=A0drivers/media/video/Kconfig =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 13 +
>>> =C2=A0drivers/media/video/Makefile =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A02 +
>>> =C2=A0drivers/media/video/omap3-isp/Makefile =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 | =C2=A0 13 +
>>> =C2=A0drivers/media/video/omap3-isp/cfa_coef_table.h =C2=A0 =C2=A0 =
| =C2=A0 61 +
>>> =C2=A0drivers/media/video/omap3-isp/gamma_table.h =C2=A0 =C2=A0 =C2=
=A0 =C2=A0| =C2=A0 90 +
>>> =C2=A0drivers/media/video/omap3-isp/isp.c =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 2220 +++++++++++++++++++
>>> =C2=A0drivers/media/video/omap3-isp/isp.h =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0428 ++++
>>> =C2=A0drivers/media/video/omap3-isp/ispccdc.c =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0| 2268 ++++++++++++++++++++
>>> =C2=A0drivers/media/video/omap3-isp/ispccdc.h =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0| =C2=A0219 ++
>>> =C2=A0drivers/media/video/omap3-isp/ispccp2.c =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0| 1173 ++++++++++
>>> =C2=A0drivers/media/video/omap3-isp/ispccp2.h =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0| =C2=A0 98 +
>>> =C2=A0drivers/media/video/omap3-isp/ispcsi2.c =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0| 1317 ++++++++++++
>>> =C2=A0drivers/media/video/omap3-isp/ispcsi2.h =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0| =C2=A0166 ++
>>> =C2=A0drivers/media/video/omap3-isp/ispcsiphy.c =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0| =C2=A0247 +++
>>> =C2=A0drivers/media/video/omap3-isp/ispcsiphy.h =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0| =C2=A0 74 +
>>> =C2=A0drivers/media/video/omap3-isp/isph3a.h =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 | =C2=A0117 +
>>> =C2=A0drivers/media/video/omap3-isp/isph3a_aewb.c =C2=A0 =C2=A0 =C2=
=A0 =C2=A0| =C2=A0374 ++++
>>> =C2=A0drivers/media/video/omap3-isp/isph3a_af.c =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0| =C2=A0429 ++++
>>> =C2=A0drivers/media/video/omap3-isp/isphist.c =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0| =C2=A0520 +++++
>>> =C2=A0drivers/media/video/omap3-isp/isphist.h =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0| =C2=A0 40 +
>>> =C2=A0drivers/media/video/omap3-isp/isppreview.c =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 | 2113 ++++++++++++++++++
>>> =C2=A0drivers/media/video/omap3-isp/isppreview.h =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 | =C2=A0214 ++
>>> =C2=A0drivers/media/video/omap3-isp/ispqueue.c =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 | 1153 ++++++++++
>>> =C2=A0drivers/media/video/omap3-isp/ispqueue.h =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 | =C2=A0187 ++
>>> =C2=A0drivers/media/video/omap3-isp/ispreg.h =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 | 1589 ++++++++++++++
>>> =C2=A0drivers/media/video/omap3-isp/ispresizer.c =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 | 1693 +++++++++++++++
>>> =C2=A0drivers/media/video/omap3-isp/ispresizer.h =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 | =C2=A0147 ++
>>> =C2=A0drivers/media/video/omap3-isp/ispstat.c =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0| 1092 ++++++++++
>>> =C2=A0drivers/media/video/omap3-isp/ispstat.h =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0| =C2=A0169 ++
>>> =C2=A0drivers/media/video/omap3-isp/ispvideo.c =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 | 1255 +++++++++++
>>> =C2=A0drivers/media/video/omap3-isp/ispvideo.h =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 | =C2=A0202 ++
>>> =C2=A0drivers/media/video/omap3-isp/luma_enhance_table.h | =C2=A0 4=
2 +
>>> =C2=A0drivers/media/video/omap3-isp/noise_filter_table.h | =C2=A0 3=
0 +
>>> =C2=A0drivers/media/video/v4l2-subdev.c =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A02 +-
>>> =C2=A0drivers/media/video/videobuf-dma-contig.c =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0| =C2=A0 =C2=A02 +-
>>> =C2=A0include/linux/Kbuild =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0=
 =C2=A01 +
>>> =C2=A038 files changed, 19769 insertions(+), 2 deletions(-)
>>>
>>> I used quilt for all patches, except for the one patch with some gi=
fs, where I did a
>>> git cherry-pick. So, the imported patches should be ok. Of course, =
it doesn't hurt
>>> do double check.
>>>
>>> The main issue with the omap3isp is due to the presence of private =
ioctl's that
>>> I don't have a clear idea about what they are really doing.
>>>
>>> I couldn't see any documentation about them on a very quick look. W=
hile I suspect
>>> that they are used only for 3A, I have no means of being sure about=
 that.
>>>
>>> Also, as I've said several times, while I don't like, I have nothin=
g against
>>> having some ioctls that would be used by a vendor to implement thei=
r own 3A software
>>> algorithms that he may need to hide for some reason or have any pat=
ents applied to
>>> the algorithm, but only if:
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A01) such algorithms are implemented on us=
erspace;
>>
>> Yes.
>>
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A02) the userspace API used by them is ful=
ly documented, in order
>>> to allow that someone else with enough motivation and spare time ma=
y
>>> want to implement his own algorithm (including an open-source one);
>>
>> The API is pretty close to what is found on public OMAP3 TRM. I'd sa=
y
>> it's almost to fill registers through a userspace API.
>
> Ok, so a simple patch adding a txt file documenting those private ioc=
tls
> to Documentation/video4linux explaining how to use them and pointing =
to
> OMAP3 TRM documentation is enough.

Ok. I'll provide a patch for it.

>
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A03) there are no patents denying or charg=
ing for the usage and/or
>>> distribution/redistribution of the Kernel with the provided kernel =
driver;
>>
>> I'd say there's no patent / charge for usage or redistribution. But
>> that's lawyer stuff. :/
>>
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A04) if the device works with a reasonable=
 quality without them
>>> (by reasonable I mean like a cheap webcam, where libv4l could use h=
is
>>> set of 3A algorithms to provide a good quality).
>>
>> It depends on the sensor as well, but in general should work with a
>> reasonable quality without using statistic modules.
>>
>>>
>>> Assuming that all those private ioctl's are really for 3A, it is ok=
 for me
>>> to accept such ioctls after being sure that the above applies. I'm =
not sure
>>> how to check (4), as, while I have 2 omap boards here (a Beagleboar=
d and a
>>> gumstix), none of them have any sensor.
>>
>> The private ioctl are used mostly on statistic modules (3A and
>> Histogram). But it's used for CCDC and Preview modules configuration
>> too.
>
> The issue here is: what if no CCDC and no Preview initialization ever=
 happen?

Currently the driver does not support such situation. Either all
modules successfully initialize or ISP driver doesn't probe correctly.

Regards,

Davd

>
> Cheers,
> Mauro
>
