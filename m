From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: [PATCH 4/4] ALSA: dice: force to add two pcm
 devices for listed models
Date: Sat, 9 Apr 2016 18:34:27 +0200
Message-ID: <20160409183427.00a59f1b@kant>
References: <1457179087-27604-1-git-send-email-o-takashi@sakamocchi.jp>
 <1457179087-27604-5-git-send-email-o-takashi@sakamocchi.jp>
 <20160305160733.6306be3f@kant> <56DC2514.2010101@sakamocchi.jp>
 <20160306235521.7aabff60@kant> <20160307012442.6935bc04@kant>
 <56DCEF78.2080107@sakamocchi.jp> <20160307144306.39f60537@kant>
 <56DD8D1B.5040903@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from einhorn.in-berlin.de (einhorn.in-berlin.de [192.109.42.8])
 by alsa0.perex.cz (Postfix) with ESMTP id 9EACC261685
 for <alsa-devel@alsa-project.org>; Sat,  9 Apr 2016 18:34:46 +0200 (CEST)
In-Reply-To: <56DD8D1B.5040903@sakamocchi.jp>
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
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, clemens@ladisch.de, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

On Mar 07 Takashi Sakamoto wrote:
> On Mar 7 2016 22:43, Stefan Richter wrote:
> > On Mar 07 Takashi Sakamoto wrote:
> >>   * Dice II units
> >>    * TC Electronic ImpactTwin
> >>    * TC Electronic Konnekt24D
> >>    * TC Electronic Konnekt8
> >> * Dice Jr. units
> >>    * TC Electronic DesktopKonnect6
> >> * Dice Mini units
> >>    * Focusrite Saffire Pro 26  
> > 
> > FWIW, Saffire PRO 24 and 40 are based on Dice Junior according to FFADO's
> > device database.  If desired I could open up my 24 and 40 to check.  
> 
> If you don't mind it, please.
> (Because once opening your unit, usually, you cannot get repair service
> from sellers.)
> 
> And I wrote wrong for Dice Jr./Mini units. Correctly:
>  * Dice Jr. units
>   * TC Electronic DesktopKonnect6
>   * Focusrite Saffire Pro 26
>  * I have no units with Dice Mini (Oh...).
> 
> Anyway, all of my units with Dice Jr. works fine. So we can judge that
> Pro 40 has its own quirk which we don't know.

Written on the Dice chip in my Saffire PRO 24, purchased in 2010:

	TCD2210
	K34FAAB
	C0906

So that's a DICE Mini.

And the Saffire PRO 40, purchased in early 2015:

	TCD2220
	K8GVUF
	A1246

i.e. DICE JR.
-- 
Stefan Richter
-======----- -=-- -=--=
http://arcgraph.de/sr/
