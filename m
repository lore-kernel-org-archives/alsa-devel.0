From: Mauro Carvalho Chehab <mchehab@redhat.com>
Subject: Re: [PATCH v21 1/3] MFD: WL1273 FM Radio: MFD driver for the FM radio.
Date: Wed, 02 Mar 2011 14:42:21 -0300
Message-ID: <4D6E817D.7090500@redhat.com>
References: <1298966450-31814-1-git-send-email-matti.j.aaltonen@nokia.com> <1298966450-31814-2-git-send-email-matti.j.aaltonen@nokia.com> <20110301114353.GA4543@sortiz-mobl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <20110301114353.GA4543@sortiz-mobl>
Sender: linux-media-owner@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: "Matti J. Aaltonen" <matti.j.aaltonen@nokia.com>, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk, hverkuil@xs4all.nl, linux-media@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Em 01-03-2011 08:43, Samuel Ortiz escreveu:
> Hi Matti,
> 
> On Tue, Mar 01, 2011 at 10:00:48AM +0200, Matti J. Aaltonen wrote:
>> This is the core of the WL1273 FM radio driver, it connects
>> the two child modules. The two child drivers are
>> drivers/media/radio/radio-wl1273.c and sound/soc/codecs/wl1273.c.
>>
>> The radio-wl1273 driver implements the V4L2 interface and communicates
>> with the device. The ALSA codec offers digital audio, without it only
>> analog audio is available.
> 
> Acked-by: Samuel Ortiz <sameo@linux.intel.com>
> 
> Mauro, I suppose you're taking this one ?

Yes, I'm taking this patch series. As patch 1/3 didn't seem to change
between v21 and v22, I'm adding your acked-by to the v22 1/3 and committing
it on my tree.

Thanks!
Mauro
