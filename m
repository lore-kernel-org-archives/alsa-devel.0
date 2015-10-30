From: Rick Mann <rmann@latencyzero.com>
Subject: Re: Noise in tlv320aic3104-based audio system
Date: Thu, 29 Oct 2015 22:45:21 -0700
Message-ID: <4B13BA45-F4A0-43B8-BCB0-B2FDA87CD8A3@latencyzero.com>
References: <2C04C84B-D0DC-40F6-9E5C-0BE659ABD7CA@latencyzero.com>
 <CA+sos79u_usBFsV=w5PKN5xq10E_biFrWWX__Cn4kXqAYcKKPA@mail.gmail.com>
 <D00A3079-506F-4C42-8353-A903208D70AA@latencyzero.com>
 <CAG5mAdwvbBSVsnvYMbh3UJnnT9hZ2nMzvFzUpWb+KPJqummr8g@mail.gmail.com>
 <71E80DDD-A9CF-454B-84F8-3D6A61106678@latencyzero.com>
 <CA+sos7-E8agRg-LhOLo4reZp09BJjV2P_nTfSDWT9_u+2h4dqw@mail.gmail.com>
 <D388183F-A107-4831-AB29-4AC9817BDE4A@latencyzero.com>
 <42AE61D4-AD45-4FF3-B155-C64335968B08@crome.org>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com
 [66.111.4.28]) by alsa0.perex.cz (Postfix) with ESMTP id 6514D265E1A
 for <alsa-devel@alsa-project.org>; Fri, 30 Oct 2015 06:45:24 +0100 (CET)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
 by mailout.nyi.internal (Postfix) with ESMTP id A7D8020A91
 for <alsa-devel@alsa-project.org>; Fri, 30 Oct 2015 01:45:23 -0400 (EDT)
In-Reply-To: <42AE61D4-AD45-4FF3-B155-C64335968B08@crome.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Caleb Crome <caleb@crome.org>
Cc: Alsa-devel <alsa-devel@alsa-project.org>, =?utf-8?Q?Beno=C3=AEt_Th=C3=A9baudeau?= <benoit.thebaudeau.dev@gmail.com>
List-Id: alsa-devel@alsa-project.org


> On Oct 29, 2015, at 20:43 , Caleb Crome <caleb@crome.org> wrote:
> 
> The data sheets for those aic codecs are pretty good I think.  
> 
> Also, routing direct or through a mixer will be a minor difference, not a major one.
> 
> It just occurred to me, the noise could easily be coming from a direct input -> output route, bypassing the adc and dac altogether. Make sure all bypass routes are zeroed out.  The trick is correlating the datasheet routes with the alsa mixer controls that correspond to them .  Enough staring at the aic3x.c files will eventually shed light:-) 

I've zeroed out everything I could find. Nothing had an effect until I got to the DAC muxes, at which point the behavior gets really weird. Changing those gets me to left or right output, but never both again until I reset the CODEC.

None of this affected the hiss.


-- 
Rick Mann
rmann@latencyzero.com
