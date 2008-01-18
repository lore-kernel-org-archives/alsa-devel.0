From: Eduardo Pereira Habkost <ehabkost@raisama.net>
Subject: Re: HDA codec graphing
Date: Fri, 18 Jan 2008 10:02:18 -0200
Message-ID: <20080118120218.GC7338@blackpad>
References: <5f52f6d70801170424o4682381fhc12416125a1b66a8@mail.gmail.com>
	<s5hwsq8ecgt.wl%tiwai@suse.de>
	<5f52f6d70801171018g334caca6k6d7bd49b9b1ef2@mail.gmail.com>
	<1200630493.5011.141.camel@razman.gruemaster.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from spunkymail-a12.g.dreamhost.com
	(sd-green-bigip-177.dreamhost.com [208.97.132.177])
	by alsa0.perex.cz (Postfix) with ESMTP id 3A7542485C
	for <alsa-devel@alsa-project.org>; Fri, 18 Jan 2008 13:05:17 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1200630493.5011.141.camel@razman.gruemaster.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Tobin Davis <tdavis@dsl-only.net>
Cc: Takashi Iwai <tiwai@suse.de>, Claudio Matsuoka <cmatsuoka@gmail.com>, ALSA Developers <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 17, 2008 at 08:28:13PM -0800, Tobin Davis wrote:
> I ran this on my home system (Intel DP965LT - STAC9227).  Attached is
> the graph to add to your samples.
> 
> I also am submitting the first (of possibly many) patches.  This one
> will also look in the $PWD for the codecgraph.py file, so users who
> don't wish to install this can just download and run it in place.
> 
> I noticed a few output errors as well:
> 
>         6: Unknown item: No Modem Function Group found
>         10: Unknown item: Default PCM:

It is just a warning because the script doesn't know what those lines
mean. But those lines are simply ignored and it shouldn't cause problems.

I have just changed the script to not give a warning on those cases.

-- 
Eduardo
