From: Ash <hashbrown100@hotmail.com>
Subject: Re: Issue with Alsa and PulseAudio
Date: Tue, 26 Aug 2008 17:08:32 +0000
Message-ID: <BAY102-W254533A08D3B13E0989D028A660@phx.gbl>
References: <BAY102-W3417CC50075C3DE003B2F68A660@phx.gbl>
	<g9171a$jko$1@ger.gmane.org>	<s5hd4jvlrlr.wl%tiwai@suse.de>
	<48B423AD.4090601@colin.guthr.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bay0-omc2-s30.bay0.hotmail.com (bay0-omc2-s30.bay0.hotmail.com
	[65.54.246.166]) by alsa0.perex.cz (Postfix) with ESMTP id 015842436D
	for <alsa-devel@alsa-project.org>;
	Tue, 26 Aug 2008 19:08:33 +0200 (CEST)
In-Reply-To: <48B423AD.4090601@colin.guthr.ie>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


Thanks Colin, Takashi.
 =

The thing is, I've noticed other applications such as aplay or amarok call =
the same function and not exhibit the same behavior. That's why I am  not s=
ure what I am doing wrong.
 =

Also intersetingly enough, if I do not use the "default" ALSA_DEVICE_DEFAUL=
T, and instead use "front" (which I believe is direct access to alsa driver=
, whereas "default" goes through pulseaudio), strange things happen. For ex=
ample, setting a rate or channels returns -22 Invalid Argument.
 =

I am not sure if I need to change or upgrade alsa. I just want to get to th=
e bottom of this with existing pulseaudio/alsa since other players seem to =
work.> To: alsa-devel@alsa-project.org> From: gmane@colin.guthr.ie> Date: T=
ue, 26 Aug 2008 16:39:25 +0100> CC: alsa-devel@alsa-project.org; hashbrown1=
00@hotmail.com> Subject: Re: [alsa-devel] Issue with Alsa and PulseAudio> >=
 Takashi Iwai wrote:> > There is no alsa-lib code that returns -EPERM by it=
self.> > Usually this error comes from the ioctl, but in this case, it must=
 be> > from pulse plugin. And, pcm_pulse.c contains no EPERM, it must come>=
 > from the pulseaudio itself.> > > > So, my rough guess is that PA is runn=
ing by a different user> > (e.g. root) that doesn't allow you to connect it=
.> > Interesting analysis, thanks Takashi.> > Ash, if you want me to help w=
ith debugging, I am usually on > #mandriva-cooker and #pulseaudio on IRC (n=
ick coling).> > If I don't answer after a ping it means I'm not there!> > >=
 Of course, first I'd do is to upgrade alsa-lib and alsa-plugins.> > 1.0.16=
 is fairly old.> > Ash, if you think this would help, I can backport these =
two packages on > Mandriva for the 2008.1 version but the driver will have =
to remain at > 1.0.16. (actually a current backport would get the 1.0.18rc2=
's).> > And Takashi, do you age faster than most humans? 1.0.17 only went f=
inal > few weeks ago!!! (although I accept there have been several good > b=
ugfixes since!!)> > > Cheers> > Col> > > -- > > Colin Guthrie> gmane(at)col=
in.guthr.ie> http://colin.guthr.ie/> > Day Job:> Tribalogic Limited [http:/=
/www.tribalogic.net/]> Open Source:> Mandriva Linux Contributor [http://www=
.mandriva.com/]> PulseAudio Hacker [http://www.pulseaudio.org/]> Trac Hacke=
r [http://trac.edgewall.org/]> > __________________________________________=
_____> Alsa-devel mailing list> Alsa-devel@alsa-project.org> http://mailman=
.alsa-project.org/mailman/listinfo/alsa-devel
_________________________________________________________________
Be the filmmaker you always wanted to be=97learn how to burn a DVD with Win=
dows=AE.
http://clk.atdmt.com/MRT/go/108588797/direct/01/
