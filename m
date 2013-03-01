From: Michal Bachraty <michal.bachraty@streamunlimited.com>
Subject: Re: [PATCH v3] davinci-mcasp: Add support for
	multichannel playback
Date: Fri, 01 Mar 2013 15:42:07 +0100
Message-ID: <1751937.m7T84ofGdH@ganymedes>
References: <1362064028-12666-1-git-send-email-michal.bachraty@streamunlimited.com>
 <5130AFA1.7000808@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx.inode.at (mx14.lb01.inode.at [62.99.145.16])
 by alsa0.perex.cz (Postfix) with ESMTP id 6B9B72650C1
 for <alsa-devel@alsa-project.org>; Fri,  1 Mar 2013 15:42:11 +0100 (CET)
In-Reply-To: <5130AFA1.7000808@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, broonie@opensource.wolfsonmicro.com, lgirdwood@gmail.com, Vaibhav Bedia <vaibhav.bedia@ti.com>, linux-kernel@vger.kernel.org, "Hebbar,
 Gururaja" <gururaja.hebbar@ti.com>
List-Id: alsa-devel@alsa-project.org

Hi Daniel,

Thanks for testing.

> One thing that has to be considered by users of the driver is that the
> 'serial-dir' DT property has to contain enough '1' entries for
> multichannel playback (or enough '2's for multichannel record). So this
> information is not actually something that describes the hardware, but
> rather some resource that can be and should be allocated dynamically by
> the driver at run-time. Should we consider dropping this property?

Not really, ' serial-dir' also  configures specific serializer binded with 
certain AXR pin . That means, when you have harware, which do not have aviable 
AXR0, you can enable other ARX pin.  

example:

serial-dir = <  1 0 0 0 >; /* 0: INACTIVE, 1: TX, 2: RX */ 
// activate serializer 0, active pin ARX0 in Transmit mode, first audio 
// channels are played on ARX0 pin 

serial-dir = < 0 1 1 2 >; /* 0: INACTIVE, 1: TX, 2: RX */ 
// activate serializer 1,2,3 active pin ARX1 in TX mode, ARX2, in TX mode, 
// ARX3 in RX mode

In this case, if you are using TDM mode with 2 slots, first two channels will 
be played on ARX1 and second two on ARX2. 

McAsp fills data for serializers in loop (receive and playback has separate 
loop), so if you have configuration:

serial-dir = < 1 2 0 1 >; /* 0: INACTIVE, 1: TX, 2: RX */ 
// first two channels are played on ARX0 pin, and second two on ARX3

Best,
Michal
