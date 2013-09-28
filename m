From: Clemens Ladisch <cladisch@googlemail.com>
Subject: Re: [alsa-devel] hdmi sound rerouted?
Date: Sun, 29 Sep 2013 00:32:40 +0200
Message-ID: <52475908.1060705@googlemail.com>
References: <20130927185045.47660@gmx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-user-bounces@lists.sourceforge.net>
In-Reply-To: <20130927185045.47660@gmx.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=alsa-user>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
Errors-To: alsa-user-bounces@lists.sourceforge.net
To: Dagg Stompler <daggs@gmx.com>
Cc: alsa-user@lists.sourceforge.net, Alex Deucher <alexander.deucher@amd.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Dagg Stompler wrote:
>> daggs@gmx.com wrote:
>>> card 0: PCH [HDA Intel PCH], device 3: HDMI 0 [HDMI 0]
>>> card 1: Generic [HD-Audio Generic], device 3: HDMI 0 [HDMI 0]
>>> card 2: HDMI [HDA ATI HDMI], device 3: HDMI 0 [HDMI 0]
>>
>> The second one is called "Generic" because your kernel does not (yet)
>> know the hardware.
>>
>>> 01:00.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] Cedar HDMI Audio [Radeon HD 5400/6300 Series]
>>> 06:00.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] RV635 HDMI Audio [Radeon HD 3600 Series]
>>
>> These are the HDMI outputs of *two* graphics cards. The first one's
>> model is so new that the driver doesn't know it.
>
> the 3600 doesn't have hdmi socket so I think it is irrelevant for my issue.

The RV635 chip does support HDMI outputs (even if none are actually
connected), so the corresponding PCI device shows up here.

>>> If you update the kernel, you will get two devices named "HDA ATI HDMI".
>
> upgrade to where?

Oops.  Even the latest driver lacks the PCI IDs of many HDMI HDA devices
(aa50/aa58/aa60/aa68/aa80/aa88/aa90/aa98: Cypress/Juniper/Redwood/Cedar/
Cayman+Antilles/Barts/Turks/Caicos).

Alex, are these devices that require disabling snooping?


Regards,
Clemens

------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60133471&iu=/4140/ostg.clktrk
