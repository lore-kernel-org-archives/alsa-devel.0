From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: emu10k1 mute problems.
Date: Sat, 09 Dec 2006 01:28:54 +0000
Message-ID: <457A1156.4000002@superbug.co.uk>
References: <000e01c7165d$ceeebaf0$dedde354@dwnze>	<20061203183433.GA14091@inferno.domain.actdsltmp>
	<4579B9F8.4020109@schinagl.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <4579B9F8.4020109@schinagl.nl>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Oliver Schinagl <oliver@schinagl.nl>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Oliver Schinagl wrote:
> Hi,
> 
> I am wondering if there's a bugzilla or some place to drop a bugreport 
> for my SBLive! (emu10k1)?

Please report this but to the ALSA bug tracker.
https://bugtrack.alsa-project.org/alsa-bug/
See the link from
http://alsa-project.org/

I think the problem you describe is that the emu10k1 has a single mute 
control for both channels, so you do not have the left/right mute.
You need to do a test first to find out if the is separate left/right 
mute or if they are separate. If there is only one, the 
"SND_MIXER_SCHN_FRONT_LEFT" controls both channels.
Maybe it would be sensible to change the alsa-lib api so either 
SND_MIXER_SCHN_FRONT_LEFT or SND_MIXER_SCHN_FRONT_RIGHT will control 
both left/right is the mute control is shared.

> 
> Now they both are working but there's one thing that seems to be going 
> wrong. Since it only happens on the SBLive (the via onboard works as it 
> should) it must be a bug in the emu10k1 driver.
> 
> I use the following code to mute the left resp. right channels.
> 
>     snd_mixer_selem_set_playback_switch(elem, SND_MIXER_SCHN_FRONT_LEFT, 0);
>     snd_mixer_selem_set_playback_switch(elem, 
> SND_MIXER_SCHN_FRONT_RIGHT, 0);
> 
> However, when muting the left channel, both channels get muted. When 
> muting the the right channel, none get muted. It's not just my app that 
> shows this behavious, gkrellm-volume plugin for instance does the same 
> thing (wrong).
> 
> 
> Since there aren't really much mixers that do balance properly, there 
> isn't much other volume controls I can test this with. I do however 
> notice in alsamixer, that below the bar, it says [MM] or [OO] on the 
> SBLive!, but with the Via, I get all possibilities done, including [MO] 
> or [OM].
> 
> Thanks,
> 
> Oliver
> 


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
