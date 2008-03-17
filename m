From: Pavel Hofman <pavel.hofman@insite.cz>
Subject: Re: PATCH - ESI Juli driver
Date: Mon, 17 Mar 2008 16:50:39 +0100
Message-ID: <47DE934F.3060308@insite.cz>
References: <47DD1934.3000003@insite.cz>	<s5hod9du6gb.wl%tiwai@suse.de>	<47DE328D.1080009@insite.cz>	<s5htzj5r9d6.wl%tiwai@suse.de>	<47DE3BD2.5090007@insite.cz>	<s5hwso1pkms.wl%tiwai@suse.de>	<47DE7B70.2040407@insite.cz>
	<s5hd4ptpefs.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from server.insite.cz (cable.insite.cz [84.242.84.93])
	by alsa0.perex.cz (Postfix) with ESMTP id D903B10387C
	for <alsa-devel@alsa-project.org>; Mon, 17 Mar 2008 16:50:52 +0100 (CET)
In-Reply-To: <s5hd4ptpefs.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA development <alsa-devel@alsa-project.org>, Rainer Zimmermann <mail@lightshed.de>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
>> I am afraid I do not understand what to change in 
>> snd_vt1724_pro_internal_clock_get(). It seems fairly logical, I made 
>> only minor changes - is_spdif_master used in other parts of the code, 
>> get_rate_index with a simple meaning.
> 
> Yeah, your change is logical -- simply convert some code snippets to
> callbacks.  But, this isn't really good for maintenance for a long
> term.  I prefer a bit more straight way if we really change
> something.  And, indeed we do need to change the stuff for rate
> settings.

I am afraid I do not have the insight of what needs to be changed. The
code as is seems fairly OK to me, just a bit underdocumented.

> 
>>
>> OK, I will remove the rate_code conversions, the new overhead will be 
>> low and one abstraction will be removed.
>>
>> For the rest, please state you objectives. Either cutting a few of the 
>> callbacks by non-trivial rewrite of the original ice1724 code, or 
>> keeping the remaining callbacks and the well-tested code.
> 
> Don't be too nervous about changing the ice1724 code right now :)
> We would need the rewrite of core codes anyway because of other
> problems in Maya44.  And, I believe we can fix more than we might
> break by such a restructuring in the end.  The current ice1724.c is
> way too complex due to its history, derived from ice1712.c.

Well, to tell the truth, I do not feel knowledgeable enough of the
alsa infrastructure to implement major changes in ice1724 code.

Actually, what is the deal with maya44? Its detailed image shows it has 
standard clocking scheme (no FPGA, PLL etc.), just a couple of Wolfson 
codecs, connection to MI/ODI/O card (fully supported e.g. by 
Prodigy192), switched I2S input between SPDIF-IN/Analog-IN. I just do 
not see a reason to rewrite ice1724 because of maya44 support.

The limitation of capture rate to 96kHz is present in most other ice1724 
cards (including Juli) and nobody has made a big deal of it. It could be 
perhaps tackled in a similar manner we solved the single SPDIF-input rate.

Plus I will have to return the borrowed Juli soon, and will not be able 
to do some qualified testing.

I have another ice1724 card on the way (SndScape Odeum SPDIF interface) 
and really would love to finish Juli soon.


Thanks a lot,

Pavel.
