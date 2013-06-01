From: Halim Sahin <halim.sahin@freenet.de>
Subject: Re: No headphone control for ALC892 on Zotac
 Motherboard D2550ITXS-B-E
Date: Sat, 1 Jun 2013 14:36:50 +0200
Message-ID: <20130601123650.GA31372@gentoo.local>
References: <20130531114710.GA5636@gentoo.local>
 <CAN8ccia1XM_p-kNQMMhSBUZsbb-D_Ae8CoEP4wQs00qzN6qhJw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from plane.gmane.org (plane.gmane.org [80.91.229.3])
 by alsa0.perex.cz (Postfix) with ESMTP id 97FC126165E
 for <alsa-devel@alsa-project.org>; Sat,  1 Jun 2013 14:36:42 +0200 (CEST)
Received: from list by plane.gmane.org with local (Exim 4.69)
 (envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1Uil33-0005qw-8T
 for alsa-devel@alsa-project.org; Sat, 01 Jun 2013 14:36:41 +0200
Received: from p5b2237f2.dip0.t-ipconnect.de ([91.34.55.242])
 by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Sat, 01 Jun 2013 14:36:41 +0200
Received: from halim.sahin by p5b2237f2.dip0.t-ipconnect.de with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Sat, 01 Jun 2013 14:36:41 +0200
Content-Disposition: inline
In-Reply-To: <CAN8ccia1XM_p-kNQMMhSBUZsbb-D_Ae8CoEP4wQs00qzN6qhJw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,
On Fr, Mai 31, 2013 at 01:06:54 +0000, Raymond Yau wrote:
> > Hi,
> > Attached is output of alsa-info.
> > Updated to Alsa-driver 1.0.25 running with 2.6.34 kernel.
> > Frontpanel of my case has mic and headphone output connectors.
> > front mic works but no headphones.
> > Card works except headphones
> > Can you please help?
> >
> 
> Try hda-jack-retask the front line out to front headphone

Is there a way to do that without using a grphical gui?
The machine doesn't have gtk3 installed.
Thx in advance!
Regards
Halim

> Node 0x1b [Pin Complex] wcaps 0x40058f: Stereo Amp-In Amp-Out
>   Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
>   Amp-In vals:  [0x00 0x00]
>   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>   Amp-Out vals:  [0x80 0x80]
>   Pincap 0x0001373e: IN OUT HP EAPD Detect Trigger
>     Vref caps: HIZ 50 GRD 80 100
>   EAPD 0x2: EAPD
>   Pin Default 0x02014c20: [Jack] Line Out at Ext Front
>     Conn = 1/8, Color = Green
>     DefAssociation = 0x2, Sequence = 0x0
>   Pin-ctls: 0x20: IN VREF_HIZ
>   Unsolicited: tag=00, enabled=0
>   Power states:  D0 D1 D2 D3 EPSS
>   Power: setting=D0, actual=D0
>   Connection: 5
>      0x0c* 0x0d 0x0e 0x0f 0x26

-- 
Halim Sahin
E-Mail:				
halim.sahin (at) t-online.de
