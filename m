From: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
Subject: Re: [PATCH] ASoC: Add delay quirk for H650e/Jabra 550a
	USB headsets
Date: Wed, 23 Aug 2017 10:52:31 +0000
Message-ID: <1503485549.11111.9.camel@infinera.com>
References: <20170822063353.3612-1-joakim.tjernlund@infinera.com>
 <s5ha82st12u.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-cys01nam02on0040.outbound.protection.outlook.com [104.47.37.40])
 by alsa0.perex.cz (Postfix) with ESMTP id 07F672664EB
 for <alsa-devel@alsa-project.org>; Wed, 23 Aug 2017 12:52:37 +0200 (CEST)
In-Reply-To: <s5ha82st12u.wl-tiwai@suse.de>
Content-Language: en-US
Content-ID: <6E7F2E1E7AA15A47A69FEE2683313E6E@infinera.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "tiwai@suse.de" <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 2017-08-22 at 11:15 +0200, Takashi Iwai wrote:
> On Tue, 22 Aug 2017 08:33:53 +0200,
> Joakim Tjernlund wrote:
> > 
> > These headsets reports a lot of: cannot set freq 44100 to ep 0x81
> > and need a small delay between sample rate settings, just like
> > Zoom R16/24. Add both headsets to the Zoom R16/24 quirk for
> > a 1 ms delay between control msgs.
> > 
> > Signed-off-by: Joakim Tjernlund <joakim.tjernlund@infinera.com>
> 
> Applied (with the correction of subject) now.  Thanks.
> 

Thank you

I have noticed though that the microphone stops working after a some seconds of 
audio chat in pidgin for all my USB headsets.
Any pointers how to debug this would be greatly appreciated.

 Jocke
