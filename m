From: Ricard Wanderlof <ricard.wanderlof@axis.com>
Subject: Re: alsa return codes
Date: Thu, 18 Apr 2019 08:53:16 +0200
Message-ID: <alpine.DEB.2.20.1904180852360.3876@lnxricardw1.se.axis.com>
References: <CAAKx_3C1S0Y_pCv5e_EkhD7U+KOG2SiOquvNFEuWPNH5rGyEuw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 434EDF8065D
 for <alsa-devel@alsa-project.org>; Thu, 18 Apr 2019 08:53:22 +0200 (CEST)
In-Reply-To: <CAAKx_3C1S0Y_pCv5e_EkhD7U+KOG2SiOquvNFEuWPNH5rGyEuw@mail.gmail.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Hector Valdez <h.e.valdez3@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


On Tue, 16 Apr 2019, Hector Valdez wrote:

> Hi, I am trying to figure out what the error/return codes are for ALSA
> (advanced linux sound architecture). I have had no luck searching the web.
> I am seeing the below messages:
> 
> 
> arecord0 has exited with return code -12.
> arecord1 has exited with return code -12.
> aplay has exited with return code -12.

Could these simply be the standard Linux error codes, i.e. -12 would be 
ENOMEM (Out of memory) ?

/Ricard
-- 
Ricard Wolf Wanderlof                           ricardw(at)axis.com
Axis Communications AB, Lund, Sweden            www.axis.com
Phone +46 46 272 2016                           Fax +46 46 13 61 30
