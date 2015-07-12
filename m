From: Jonathan Woithe <jwoithe@just42.net>
Subject: Re: [FFADO-devel] [RFC][PATCH 00/37] ALSA: firewire:
 support AMDTP variants
Date: Sun, 12 Jul 2015 18:16:09 +0930
Message-ID: <20150712084609.GB30791@marvin.atrad.com.au>
References: <1436623968-10780-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from server.atrad.com.au (server.atrad.com.au [150.101.241.2])
 by alsa0.perex.cz (Postfix) with ESMTP id B7208260688
 for <alsa-devel@alsa-project.org>; Sun, 12 Jul 2015 10:46:15 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1436623968-10780-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: alsa-devel@alsa-project.org, Robin Gareus <robin@gareus.org>, Yoshifuji Hideaki <yoshfuji@linux-ipv6.org>, Damien Zammit <damien@zamaudio.com>, clemens@ladisch.de, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Hi Takashi

On Sat, Jul 11, 2015 at 11:12:11PM +0900, Takashi Sakamoto wrote:
> This patchset is for three new drivers and related modification to
> firewire-lib module.
> :
>  * Patch 29-37: for firewire-motu, a new driver for MOTU FireWire series
> :
>  * firewire-motu:
>   * experimental, for preview to developers

A few general comments about the MOTU driver.

1) Unlike the FFADO driver (where I imagine much of the detail has been
   taken) there are a lot of magic numbers in this driver both in terms of
   the registers being written to and the values written to those registers. 
   I appreciate that ALSA may have different coding conventions, but I think
   it would make sense to use defines to document what these magic values
   are, especially since in a vast majority of cases we do know what the
   relevant bits and registers are doing.

2) As has been mentioned before, the streaming drivers for firewire devices
   in ALSA are a successor to those in the FFADO project.  In the case of
   some of the other firewire drivers (DICE etc) I understand that the ALSA
   code is predominantly a reimplementation based on published standards. 
   However, given the structure and terminology used within the the
   experimental MOTU driver, it seems to be based fairly heavily on my FFADO
   MOTU driver which itself has come about due to a significant time
   investment on my part over many years to decode and analyse the protocol
   used by these interfaces.  I have no problem with this reuse of knowledge
   since this is precisely how open source should work.  However, it would
   be appreciated if this prior work by myself within FFADO was at least
   acknowledged in some way in the ALSA MOTU driver files.

   Similarly, knowledge of the requirements of many MOTU devices have been
   contributed by others as a result of directed experimentation.  Those
   individuals are acknowledged in FFADO source code and in our repo.  Where
   this information has been utilised in the ALSA code I think it is fair
   that their contribution is noted somehow.  I don't know what the ALSA
   convention is with regard to such things - such as single-line comments
   to this effect within the code.

As mentioned earlier I will continue to work through the patchset and
provide comments and suggestions as time allows over the coming few days.

Regards
  jonathan
