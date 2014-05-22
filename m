From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [alsa-devel] [RFC] set up an sync channel between
 audio and display driver (i.e. ALSA and DRM)
Date: Thu, 22 May 2014 10:46:44 +0800
Message-ID: <CAN8cciYSs2Cq08qTx0r3mhqTVhOvy_TYqz+qnu1HD4wYZzECPg@mail.gmail.com>
References: <F46914AEC2663F4A9BB62374E5EEF8F82B447059@SHSMSX101.ccr.corp.intel.com>
 <s5h7g5g6fc7.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0090921655=="
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <s5h7g5g6fc7.wl%tiwai@suse.de>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: "Yang, Libin" <libin.yang@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Nikkanen,
 Kimmo" <kimmo.nikkanen@intel.com>, "Babu, Ramesh" <ramesh.babu@intel.com>, "Koul, Vinod" <vinod.koul@intel.com>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>, "Vetter,
 Daniel" <daniel.vetter@intel.com>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>
List-Id: alsa-devel@alsa-project.org

--===============0090921655==
Content-Type: multipart/alternative; boundary=047d7bdc82c298678c04f9f41f69

--047d7bdc82c298678c04f9f41f69
Content-Type: text/plain; charset=UTF-8

> >
> > This RFC is based on previous discussion to set up a generic
communication channel between display and audio driver and
> > an internal design of Intel MCG/VPG HDMI audio driver. It's still an
initial draft and your advice would be appreciated
> > to improve the design.
> >
> > The basic idea is to create a new avsink module and let both drm and
alsa depend on it.

>
> > 1. Display/Audio Client
> >
> > The avsink core provides APIs to create, register and lookup a
display/audio client.

>
> For HD-audio HDMI, both controller and codec drivers would need the
> avsink access.  So, both drivers will register the own client?

http://nvidia.custhelp.com/app/answers/detail/a_id/2544/~/my-nvidia-graphics-card-came-with-an-internal-spdif-pass-through-audio-cable-to

http://www.intel.com/support/motherboards/desktop/sb/CS-032871.htm

Does it mean that those grpahic card HDMI which use motherboard internal
spdif connector will not be supported any more when  graphic card have no
way to communicate with audio driver ?

https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/sound/pci/hda/hda_auto_parser.c?id=3f25dcf691ebf45924a34b9aaedec78e5a255798

Should alsa regard these kind of digital device as HDMI or SPDIF ?

--047d7bdc82c298678c04f9f41f69
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p><br>
&gt; &gt;<br>
&gt; &gt; This RFC is based on previous discussion to set up a generic comm=
unication channel between display and audio driver and<br>
&gt; &gt; an internal design of Intel MCG/VPG HDMI audio driver. It&#39;s s=
till an initial draft and your advice would be appreciated<br>
&gt; &gt; to improve the design.<br>
&gt; &gt;<br>
&gt; &gt; The basic idea is to create a new avsink module and let both drm =
and alsa depend on it.</p>
<p>&gt;<br>
&gt; &gt; 1. Display/Audio Client<br>
&gt; &gt;<br>
&gt; &gt; The avsink core provides APIs to create, register and lookup a di=
splay/audio client.</p>
<p>&gt;<br>
&gt; For HD-audio HDMI, both controller and codec drivers would need the<br=
>
&gt; avsink access. =C2=A0So, both drivers will register the own client?</p=
>
<p><a href=3D"http://nvidia.custhelp.com/app/answers/detail/a_id/2544/~/my-=
nvidia-graphics-card-came-with-an-internal-spdif-pass-through-audio-cable-t=
o">http://nvidia.custhelp.com/app/answers/detail/a_id/2544/~/my-nvidia-grap=
hics-card-came-with-an-internal-spdif-pass-through-audio-cable-to</a></p>

<p><a href=3D"http://www.intel.com/support/motherboards/desktop/sb/CS-03287=
1.htm">http://www.intel.com/support/motherboards/desktop/sb/CS-032871.htm</=
a></p>
<p>Does it mean that those grpahic card HDMI which use motherboard internal=
 spdif connector will not be supported any more when=C2=A0 graphic card hav=
e no way to communicate with audio driver ?<br></p>
<p><a href=3D"https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/=
commit/sound/pci/hda/hda_auto_parser.c?id=3D3f25dcf691ebf45924a34b9aaedec78=
e5a255798">https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/com=
mit/sound/pci/hda/hda_auto_parser.c?id=3D3f25dcf691ebf45924a34b9aaedec78e5a=
255798</a></p>

<p>Should alsa regard these kind of digital device as HDMI or SPDIF ?</p>

--047d7bdc82c298678c04f9f41f69--

--===============0090921655==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Intel-gfx mailing list
Intel-gfx@lists.freedesktop.org
http://lists.freedesktop.org/mailman/listinfo/intel-gfx

--===============0090921655==--
