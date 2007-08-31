From: "John Utz" <john.utz@dmx.com>
Subject: Re: Dealing with 'siamesed' DAC sample rates
Date: Fri, 31 Aug 2007 09:37:14 -0700
Message-ID: <20070831093714.1bd9a91e@jutz-gnto64>
References: <20070830115112.02820301@jutz-gnto64>
	<Pine.LNX.4.58.0708301212410.18152@shell4.speakeasy.net>
	<20070830124210.7b8411c0@jutz-gnto64> <s5hlkbseyrm.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.dmxmusic.com (mail.dmxmusic.com [199.201.237.35])
	by alsa0.perex.cz (Postfix) with ESMTP id 13D512433E
	for <alsa-devel@alsa-project.org>;
	Fri, 31 Aug 2007 18:37:34 +0200 (CEST)
In-Reply-To: <s5hlkbseyrm.wl%tiwai@suse.de>
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
Cc: ALSA Developers <alsa-devel@alsa-project.org>, Trent Piepho <xyzzy@speakeasy.org>
List-Id: alsa-devel@alsa-project.org

Hi Takashi;

tnx so much for your suggestion, however, 'tis a bit more complicated
methinks....

On Fri, 31 Aug 2007 13:20:29 +0200
"Takashi Iwai" <tiwai@suse.de> wrote:

> At Thu, 30 Aug 2007 12:42:10 -0700,
> John Utz wrote:
> > 
> > > It seems like the right thing to do would be to check if any other
> > > DACs are in use.
> > 
> > perhaps, but i dont think that there is a 'DAC IN USE' function. Are
> > you aware of one?
> 
> Not in the ac97_codec side.
> Usually the rate-lock over streams is implemented in the controller
> side.

Ok, but in the case of the VT1618 it's implemented on the codec itself
and i have no choice.

With that in mind, is the fact that it's usually done on the controller
side relevant? Does this chip fact modify your thoughts?

So, by controller, do you mean the via8237 (via82xx) side?

I had pondered doing it there, but that would require the via82xx code
to know something about the codec that it's controlling and that code
at present seems to know nothing about the child codecs, how would i
get the codec ID value back to the via82xx code in order for it to do
any decision making?


>  The driver knows which PCM (sub)stream is opened, so you can
> add hw_params constraint appropriately.

This seems like a very good hint that i will pursue.

But it will be difficult to implement at this moment because i am
completely clueless as to how to let the via82xx stuff know that it's
controlling a vt1618 (all the other codecs (vt1617, vt1616) evidently
dont have this little idiosyncracy.

Dang. 


> 
> Takashi
> 
