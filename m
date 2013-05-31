From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: No headphone control for ALC892 on Zotac
	Motherboard D2550ITXS-B-E
Date: Fri, 31 May 2013 13:06:54 +0000
Message-ID: <CAN8ccia1XM_p-kNQMMhSBUZsbb-D_Ae8CoEP4wQs00qzN6qhJw@mail.gmail.com>
References: <20130531114710.GA5636@gentoo.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ie0-f172.google.com (mail-ie0-f172.google.com
 [209.85.223.172])
 by alsa0.perex.cz (Postfix) with ESMTP id 99BA1265496
 for <alsa-devel@alsa-project.org>; Fri, 31 May 2013 15:06:55 +0200 (CEST)
Received: by mail-ie0-f172.google.com with SMTP id 17so3864057iea.17
 for <alsa-devel@alsa-project.org>; Fri, 31 May 2013 06:06:54 -0700 (PDT)
In-Reply-To: <20130531114710.GA5636@gentoo.local>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Halim Sahin <halim.sahin@freenet.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> Hi,
> Attached is output of alsa-info.
> Updated to Alsa-driver 1.0.25 running with 2.6.34 kernel.
> Frontpanel of my case has mic and headphone output connectors.
> front mic works but no headphones.
> Card works except headphones
> Can you please help?
>

Try hda-jack-retask the front line out to front headphone

Node 0x1b [Pin Complex] wcaps 0x40058f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-In vals:  [0x00 0x00]
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x0001373e: IN OUT HP EAPD Detect Trigger
    Vref caps: HIZ 50 GRD 80 100
  EAPD 0x2: EAPD
  Pin Default 0x02014c20: [Jack] Line Out at Ext Front
    Conn = 1/8, Color = Green
    DefAssociation = 0x2, Sequence = 0x0
  Pin-ctls: 0x20: IN VREF_HIZ
  Unsolicited: tag=00, enabled=0
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
  Connection: 5
     0x0c* 0x0d 0x0e 0x0f 0x26
