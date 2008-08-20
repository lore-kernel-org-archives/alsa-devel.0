From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: PATCH - vt1618 7.1 Audio
Date: Wed, 20 Aug 2008 20:21:22 +0100
Message-ID: <20080820192121.GA26994@sirena.org.uk>
References: <op.uf5sfuct647oa9@jutz-gnto64> <s5h1w0knl8o.wl%tiwai@suse.de>
	<op.uf646zdn647oa9@jutz-gnto64>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 7A5C02432C
	for <alsa-devel@alsa-project.org>;
	Wed, 20 Aug 2008 21:21:17 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <op.uf646zdn647oa9@jutz-gnto64>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "John L. Utz III" <john.utz@dmx.com>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Developers <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Aug 20, 2008 at 10:50:49AM -0700, John L. Utz III wrote:
> On Wed, 20 Aug 2008 01:28:39 -0700, Takashi Iwai <tiwai@suse.de> wrote:

> > They must be consistent -- usually 0 = disable, 1 = enable.
> > In general, the controls like "XXX Disable" is bad.  A switch should
> > be to turn on, not to turn off.  If the register bit is to disable
> > something, implement the control element in a reverse way.

> OK.

> note that it makes the code more complex in some places because the chip  
> is inconsistent.

ASoC does this by having a flag in the control specific data saying if
the control is inverted which works pretty well for dealing with this
situation.

> > Avoid too long lines (also in other places).

> OK. 80 column?

Yes.  See Documentation/CodingStyle (and checkpatch).

> > Also, a Windows style variable name should be avoided.  People tend to
> > hate it.

> Why would you call this 'Windows Style?' Is that supposed to be a  
> perjorative comment?

This style is used throughout the Windows API documentation and is
therefore frequently encounterd in Windows code but it's rarely
encountered anywhere else.  It's called Hungarian notation, though in
the form it's normally seen it's very far from what was originally
intended by that.

> Having variable type decorations provides valuable context and (IMHO)  
> makes the code more maintainable.

Many people have forcefuly held views in the opposite direction - google
will turn up a bunch.  I have the following in my fortune database:

prepAs nounOthers verbHave verbNoted, pronThis nounStyle verbIs
verbCalled adjHungarian nounNotation.  pronI verbFind pronIt
advCompletely adjUseless.  pronI verbHope pronYou verbCan verbSee
possMy nounPoint -- verbEspecially nounWhen possThe advPrefixes
conjBecome verbUtterly adjWrong. :-)
                -- Chris Torek <nospam@elf.eng.bsdi.com>
