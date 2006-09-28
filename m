From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Default soundcard (UDEV?)
Date: Thu, 28 Sep 2006 18:00:41 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0609281743310.9381@tm8103.perex-int.cz>
References: <6.2.1.2.2.20060928013552.16a4b928@mailone.real.com>
	<s5hhcys2kr2.wl%tiwai@suse.de> <1159454460.7086.23.camel@mindpipe>
	<s5h64f82gm8.wl%tiwai@suse.de>
	<Pine.LNX.4.61.0609281654230.9381@tm8103.perex-int.cz>
	<s5hd59g57w5.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hd59g57w5.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: Alsa Developement <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Thu, 28 Sep 2006, Takashi Iwai wrote:

> At Thu, 28 Sep 2006 17:06:08 +0200 (CEST),
> Jaroslav Kysela wrote:
> > 
> > On Thu, 28 Sep 2006, Takashi Iwai wrote:
> > 
> > > BTW, for the secondary card, you can use like the style like
> > > "default:1".  This will choose the default PCM of the secondary card.
> > 
> > Note that perhaps we should change what the default card means. In the 
> > sense of udev mechanism, devices should be detected and enumerated in 
> > system. We have actually no way (and it will be very problematic) to 
> > change the soundcard number in the ALSA driver. Fortunately, we have extra 
> > card id (which is not very much used) which can be perfectly used for this 
> > purpose and it can be also changed at runtime (so udev rules can reassing 
> > for example the default card).
> > 
> > I would propose that "default" will refer always to a card with id 
> > "default" (and if no card will have this id, first soundcard will be used 
> > as now). At driver initialization, first card becomes as "default", then 
> > user or udev can rename it to something else.
> > 
> > Also, extra udev support should be added to match devices from longname or 
> > shortname (see control API and SYSFS{}).
> > 
> > Opinions (except that we should learn users to use "logical 
> > identification" not card numbers)?
> 
> The logical id (aka persistent name) is a good invention, but actually
> it forces apps to change its code.  This is not easy.  Thus, we can
> never drop the style like "hw:1" while we may provide the new support
> of logical id.

I do not propose to change the current behaviour. We do not require any 
changes in alsa-lib except changing "defaults.pcm.card 0" to 
"defaults.pcm.card "default"" (and handle fallback to first soundcard).

> That is, we'd need eventually an internal map between the logical id
> and the numerical id.  Currently it's in the driver side, but this
> could be in alsa-lib once if the device connection is moved to the
> persistent device-file names.

I am against any kind of remapping based on the card index. It would be 
more confusing.

> (BTW, I very much agree with changing the semantics of "default:1".
>  Originally I proposed to use a different name, but we didn't get
>  consensus to a solid name, so "default" was chosen as compromise.)

Note that "default:Intel" (or replace Intel with your card id) works now.
I don't see any collision. You may refer device using logical or 
physical name.

> IMO, the first thing we have to do above the things above is to
> provide an easy-to-use device enumeration API.  This must be as simple
> as possible, just let apps to choose a device.  No more, no less.
> 
> We have already some framework for enumeration, but it's unfortunately
> useless right now.  Partly because it requires extra work (to call
> alsactl names), and partly because it's incomplete.

We all know that the problem with right enumeration is that we have 
virtual names and arguments, so we have basically unlimited number of 
choices.

I would propose to return a list of devices consisting from:

a) basic devices on top of hardware (default:X, hw:X, surround...)
b) user selectable list (from asoundrc or global configuration)

If we merge these two lists, we can offer to applications something basic 
for standard users. Of course, all apps should have a possibility to 
enter another device name.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
