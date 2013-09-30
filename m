From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: Re: [Alsa-user]  hdmi sound rerouted?
Date: Mon, 30 Sep 2013 02:23:22 +0000
Message-ID: <A3397C8B8B789E45844E7EC5DEAD89D02E80B231@satlexdag05.amd.com>
References: <20130927185045.47660@gmx.com> <52475908.1060705@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe005.messaging.microsoft.com [207.46.163.28])
 by alsa0.perex.cz (Postfix) with ESMTP id 47B6D2616CB
 for <alsa-devel@alsa-project.org>; Mon, 30 Sep 2013 04:23:36 +0200 (CEST)
In-Reply-To: <52475908.1060705@googlemail.com>
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
To: Clemens Ladisch <cladisch@googlemail.com>, Dagg Stompler <daggs@gmx.com>
Cc: "alsa-user@lists.sourceforge.net" <alsa-user@lists.sourceforge.net>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Clemens Ladisch [mailto:cladisch@googlemail.com]
> Sent: Saturday, September 28, 2013 6:33 PM
> To: Dagg Stompler
> Cc: alsa-user@lists.sourceforge.net; Deucher, Alexander; alsa-devel@alsa-
> project.org
> Subject: Re: [Alsa-user] [alsa-devel] hdmi sound rerouted?
> 
> Dagg Stompler wrote:
> >> daggs@gmx.com wrote:
> >>> card 0: PCH [HDA Intel PCH], device 3: HDMI 0 [HDMI 0]
> >>> card 1: Generic [HD-Audio Generic], device 3: HDMI 0 [HDMI 0]
> >>> card 2: HDMI [HDA ATI HDMI], device 3: HDMI 0 [HDMI 0]
> >>
> >> The second one is called "Generic" because your kernel does not (yet)
> >> know the hardware.
> >>
> >>> 01:00.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] Cedar
> HDMI Audio [Radeon HD 5400/6300 Series]
> >>> 06:00.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] RV635
> HDMI Audio [Radeon HD 3600 Series]
> >>
> >> These are the HDMI outputs of *two* graphics cards. The first one's
> >> model is so new that the driver doesn't know it.
> >
> > the 3600 doesn't have hdmi socket so I think it is irrelevant for my issue.
> 
> The RV635 chip does support HDMI outputs (even if none are actually
> connected), so the corresponding PCI device shows up here.
> 
> >>> If you update the kernel, you will get two devices named "HDA ATI
> HDMI".
> >
> > upgrade to where?
> 
> Oops.  Even the latest driver lacks the PCI IDs of many HDMI HDA devices
> (aa50/aa58/aa60/aa68/aa80/aa88/aa90/aa98:
> Cypress/Juniper/Redwood/Cedar/
> Cayman+Antilles/Barts/Turks/Caicos).
> 
> Alex, are these devices that require disabling snooping?

Sorry what does snooping mean in this context?

Alex
