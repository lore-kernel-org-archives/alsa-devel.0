From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: alsa return codes
Date: Thu, 18 Apr 2019 09:23:19 +0200
Message-ID: <d2b6b40a-3988-f00a-9d88-ab2d263cda86@perex.cz>
References: <CAAKx_3C1S0Y_pCv5e_EkhD7U+KOG2SiOquvNFEuWPNH5rGyEuw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4B323F896E2
 for <alsa-devel@alsa-project.org>; Thu, 18 Apr 2019 09:23:21 +0200 (CEST)
In-Reply-To: <CAAKx_3C1S0Y_pCv5e_EkhD7U+KOG2SiOquvNFEuWPNH5rGyEuw@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Hector Valdez <h.e.valdez3@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Dne 16. 04. 19 v 22:53 Hector Valdez napsal(a):
> Hi, I am trying to figure out what the error/return codes are for ALSA
> (advanced linux sound architecture). I have had no luck searching the web.
> I am seeing the below messages:
> 
> 
> arecord0 has exited with return code -12.
> arecord1 has exited with return code -12.
> aplay has exited with return code -12.

aplay/arecord utilities should return only codes 0 (ok) or 1 (fail).
It seems that the problem is somewhere else (caller?).

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
