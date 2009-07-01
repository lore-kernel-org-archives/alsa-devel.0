From: Andreas =?iso-8859-1?q?N=FC=DFlein?= <nutz@unfoog.de>
Subject: Re: No sound with nVidia Corporation MCP79 High
	Definition Audio (rev b1) (Macbook Pro 5, 5)
Date: Wed, 1 Jul 2009 17:00:42 +0200
Message-ID: <200907011700.43178.nutz@unfoog.de>
References: <4A493A56.1050504@gmail.com> <s5heit2i7pi.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx.unfoog.de (dom0kun.ath.cx [78.46.99.229])
	by alsa0.perex.cz (Postfix) with ESMTP id 381A224426
	for <alsa-devel@alsa-project.org>;
	Wed,  1 Jul 2009 17:00:54 +0200 (CEST)
Received: from panama.localnet (port-87-234-90-241.dynamic.qsc.de
	[87.234.90.241])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx.unfoog.de (Postfix) with ESMTPSA id 88CD73AF4F2
	for <alsa-devel@alsa-project.org>;
	Wed,  1 Jul 2009 17:00:43 +0200 (CEST)
In-Reply-To: <s5heit2i7pi.wl%tiwai@suse.de>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


so i tried to find some information in OS X and after a while i stumbled upon a 
document "Info.plist", to which i was pointed by OS X's build-in hardware 
info-utility, somehwere in /System/Library/Extensions/AppleHDA.kext/....  

http://nopaste.org/p/aRCCwdDXqb

also some information right out of the apple tool, eventhough i don't think 
that it's worth anything:
Intel High Definition Audio:                                                                         
  Device ID:    0x10DECB79
  Audio ID:     77        
  Available Devices:      
  Headphone:              
  Connection:   Combo     
  Speaker:                
  Connection:   Internal  
  Line In:                
  Connection:   Combo     
  Internal Microphone:    
  Connection:   Internal  
  S/P-DIF Out:            
  Connection:   Combo     
  External Microphone:    
  Connection:   Combo   


On Tuesday 30 June 2009 07:58:17 Takashi Iwai wrote:
> At Mon, 29 Jun 2009 16:04:06 -0600,
>
> Sean Burke wrote:
> > A quick google shows that the vendor ID is Cirrus Logic. The Boot Camp
> > driver set does include installers for Cirrus audio cards. I don't have
> > Windows installed on here, so I can't check to see if it is indeed the
> > Cirrus drivers that get installed. What can be done to facilitate the
> > implementation of this codec?
>
> I guess it's CS4206 codec.  CS4207 has a different id.

out of the Info.plist:
<string>Cirrus Logic CS4206</string>                          
<key>CodecID</key>


so again: if i can, i'd love to help.


thanks a lot
