From: Felix Kuehling <felix.kuehling@amd.com>
Subject: Re: [PATCH 01/12] drm/amdgpu: add amd_gnb_bus support
Date: Fri, 7 Aug 2015 16:03:08 -0400
Message-ID: <55C50EFC.4050407@amd.com>
References: <1438871112-25946-1-git-send-email-alexander.deucher@amd.com>
 <1438871112-25946-2-git-send-email-alexander.deucher@amd.com>
 <20150807102508.GL20873@sirena.org.uk>
 <CADnq5_NihZCFEaL150Kt0LWCUBp6eQzne-O0JcCFE0-vHj7ZBQ@mail.gmail.com>
 <55C4D9C3.1070504@amd.com> <20150807182401.GK10301@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0110095364=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20150807182401.GK10301@sirena.org.uk>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Mark Brown <broonie@kernel.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, maruthi.bayyavarapu@amd.com, lgirdwood@gmail.com, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, perex@perex.cz, Alex Deucher <alexander.deucher@amd.com>
List-Id: alsa-devel@alsa-project.org

--===============0110095364==
Content-Type: multipart/alternative;
	boundary="------------020601090802060501080100"

--------------020601090802060501080100
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit

On 15-08-07 02:24 PM, Mark Brown wrote:
> Like I say this just sounds like exactly the sort of thing we handle
> with an MFD, it's a very common pattern. 

OK, the MFD documentation in Documentation/devicetree/bindings/mfd/
seemed to imply a dependency on a devicetree. It took me a moment to
realize that's just the most common scenario.

In our case we don't have a devicetree, we're talking about a PC
platform. The GPU (GNB) is a PCIe device. Does the following sound like
proper use of the MFD framework for our case?

 1. GPU driver gets initialized, detects a GPU with audio co-processor (ACP)
 2. GPU driver registers mfd_cell for the ACP device using
    mfd_add_hotplug_devices
      * It's not really hot-plug, but the mem_base, irq_base, irq_domain
        parameters don't make sense for us
 3. Platform_data in the MFD cell contains audio driver-specific data,
    function pointers, etc. for the audio driver to use
 4. Audio driver binds to platform device created by
    mfd_add_hotplug_devices based on driver name

Or do we have to convert our GPU device to be an MFD cell itself, a peer
of the ACP cell?

Thanks,
  Felix

-- 
F e l i x   K u e h l i n g
SMTS Software Development Engineer | Vertical Workstation/Compute
1 Commerce Valley Dr. East, Markham, ON L3T 7X6 Canada
(O) +1(289)695-1597
   _     _   _   _____   _____
  / \   | \ / | |  _  \  \ _  |
 / A \  | \M/ | | |D) )  /|_| |
/_/ \_\ |_| |_| |_____/ |__/ \|   facebook.com/AMD | amd.com


--------------020601090802060501080100
Content-Type: text/html; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
  <head>
    <meta content=3D"text/html; charset=3Dwindows-1252"
      http-equiv=3D"Content-Type">
  </head>
  <body bgcolor=3D"#FFFFFF" text=3D"#000000">
    On 15-08-07 02:24 PM, Mark Brown wrote:<br>
    <blockquote cite=3D"mid:20150807182401.GK10301@sirena.org.uk"
      type=3D"cite">
      Like I say this just sounds like exactly the sort of thing we
      handle
      with an MFD, it's a very common pattern.
    </blockquote>
    <br>
    OK, the MFD documentation in Documentation/devicetree/bindings/mfd/
    seemed to imply a dependency on a devicetree. It took me a moment to
    realize that's just the most common scenario.<br>
    <br>
    In our case we don't have a devicetree, we're talking about a PC
    platform. The GPU (GNB) is a PCIe device. Does the following sound
    like proper use of the MFD framework for our case?<br>
    <ol>
      <li>GPU driver gets initialized, detects a GPU with audio
        co-processor (ACP)<br>
      </li>
      <li>GPU driver registers mfd_cell for the ACP device using
        mfd_add_hotplug_devices</li>
      <ul>
        <li>It's not really hot-plug, but the mem_base, irq_base,
          irq_domain parameters don't make sense for us<br>
        </li>
      </ul>
      <li>Platform_data in the MFD cell contains audio driver-specific
        data, function pointers, etc. for the audio driver to use</li>
      <li>Audio driver binds to platform device created by
        mfd_add_hotplug_devices based on driver name<br>
      </li>
    </ol>
    Or do we have to convert our GPU device to be an MFD cell itself, a
    peer of the ACP cell?<br>
    <br>
    Thanks,<br>
    =A0 Felix<br>
    <pre class=3D"moz-signature" cols=3D"72">--=20
F e l i x   K u e h l i n g
SMTS Software Development Engineer | Vertical Workstation/Compute
1 Commerce Valley Dr. East, Markham, ON L3T 7X6 Canada
(O) +1(289)695-1597
   _     _   _   _____   _____
  / \   | \ / | |  _  \  \ _  |
 / A \  | \M/ | | |D) )  /|_| |
/_/ \_\ |_| |_| |_____/ |__/ \|   facebook.com/AMD | amd.com</pre>
  </body>
</html>

--------------020601090802060501080100--

--===============0110095364==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHA6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwK

--===============0110095364==--
