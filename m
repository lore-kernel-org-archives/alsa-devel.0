From: Rene Herman <rene.herman@gmail.com>
Subject: Re: [Alsa-user] ALSA Newbie - Getting Ensoniq
	SoundscapeVivo to work?
Date: Sat, 28 Apr 2007 11:54:18 +0200
Message-ID: <463319CA.4040309@gmail.com>
References: <d382e1990704272206y9712a84x1e07d07eda58fb18@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <d382e1990704272206y9712a84x1e07d07eda58fb18@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Cody Jung <funkycat32@gmail.com>
Cc: alsa-devel@alsa-project.org, alsa-user@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 04/28/2007 07:06 AM, Cody Jung wrote:

> As it suggests in the subject, I'm both a Linux-newbie and an
> ALSA-newbie. I have an old clunker of a machine running Ubuntu Feisty
> that I built out of parts left on curbs during spring cleanup, and that's
> how I came across my sound card. It's an Ensoniq SoundscapeVivo (Not a 
> Vivo90, AFAIK).

As far as I'm aware, there are no other VIVO's than the VIVO90.

> I've gone through install and troubleshooting guides galore, but I can't
> seem to get ALSA to recognize my card, and I'm confused and rather tired
> of it all.
> 
> Do you think you can help, and if so, what information do you need from
> me?

I probably can; I have both a Soundscape VIVO90 and a much older Soundscape 
S-2000. My VIVO90 is an ISA-PnP card and has a Ensoniq MARK5-RO, an OTTOR2C 
and a Analog Devices AD1845 codec:

http://en.wikipedia.org/wiki/Ensoniq_Soundscape_VIVO90

I tested that when I acquired it a while ago and if I remember correctly, it 
just worked... mmm. come to think of it, it might be the case that I needed 
to add its PnP ID to the driver. Not sure anymore. Could you confirm whether 
or not your Soundscape is an ISA-PnP card and if so (that's also a way to 
find out if you don't know if it is) run "pnpdump" with it installed and 
look for a PnP-ID for the card in it? Something of the form "ENSxxxx".

If your card is one of the older non-PnP soundscapes it's going to be a bit 
harder; they also need firmware and all that and I haven't tested that card 
myself yet.

(please use the @alsa-project.org list addresses by the way; in the case of 
alsa-devel, the sourceforge one is gone even).

Rene.
