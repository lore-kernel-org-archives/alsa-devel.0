From: Manuel Reimer <Manuel.Spam@nurfuerspam.de>
Subject: Re: Microphone does not longer work on Lenovo N581
Date: Wed, 02 Oct 2013 16:54:55 +0200
Message-ID: <l2hc35$42d$1@ger.gmane.org>
References: <l28nen$jns$1@ger.gmane.org> <s5h1u44uh1m.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from plane.gmane.org (plane.gmane.org [80.91.229.3])
 by alsa0.perex.cz (Postfix) with ESMTP id AF67B265495
 for <alsa-devel@alsa-project.org>; Wed,  2 Oct 2013 16:54:51 +0200 (CEST)
Received: from list by plane.gmane.org with local (Exim 4.69)
 (envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1VRNpC-0006SN-2x
 for alsa-devel@alsa-project.org; Wed, 02 Oct 2013 16:54:50 +0200
Received: from p5dd560a0.dip0.t-ipconnect.de ([93.213.96.160])
 by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Wed, 02 Oct 2013 16:54:50 +0200
Received: from Manuel.Spam by p5dd560a0.dip0.t-ipconnect.de with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Wed, 02 Oct 2013 16:54:50 +0200
In-Reply-To: <s5h1u44uh1m.wl%tiwai@suse.de>
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

On 10/02/2013 12:02 PM, Takashi Iwai wrote:
> First off, take alsa-info.sh output on 3.8.8 kernel where the internal
> mic works.  Run the script with --no-upload option, and keep the
> output.

Nice script. I did so and used "diff" to compare the two.

This way, I saw, that not only "Microphone" disappeared but "Capture" 
was added.

So I pushed "Capture" to maximum volume and unmuted the channel and... 
now my microphone works!

IMHO it is a bit confusing if "Microphone" is renamed to "Capture" ;)

And another thing, that seems to be misnamed, is the "Internal 
microphone boost" setting. If an external microphone is plugged in, then 
this setting also applies to this microphone. So maybe it would be 
better to name it "Microphone boost"?

Thank you for your help.

Greetings,

Manuel
