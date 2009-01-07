From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: alsa-lib-1.0.18 doesn't build
	with	option	'--with-softfloat'
Date: Wed, 7 Jan 2009 11:34:27 +0000
Message-ID: <20090107113421.GE16772@sirena.org.uk>
References: <da1989290901060152t2ce35849i1da6872552a07754@mail.gmail.com>
	<da1989290901070102k41904cf1pbcb10b228a692ec@mail.gmail.com>
	<s5hk597scct.wl%tiwai@suse.de>
	<20090107110123.GA16772@sirena.org.uk>
	<s5hk597v06l.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 517A01037E3
	for <Alsa-devel@alsa-project.org>; Wed,  7 Jan 2009 12:34:28 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hk597v06l.wl%tiwai@suse.de>
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
Cc: Alsa-devel@alsa-project.org, Cliff Cai <cliffcai.sh@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Jan 07, 2009 at 12:13:22PM +0100, Takashi Iwai wrote:
> Mark Brown wrote:
> > On Wed, Jan 07, 2009 at 10:18:42AM +0100, Takashi Iwai wrote:

> > OpenEmbedded has been carrying the following patch for a while,
> > cooindcidentally I was actually looking at their ALSA packaging last
> > night and thinking about pushing this to you - it forces liking with
> > libm which is more important when using softfloat.

> Well, when softfloat option is chosen, basically alsa-lib should be
> built without floating operations, thus libm shouldn't be needed.  (So
> in that sense, the option is named wrongly...)

Yeah, looking at the code I had kind of suspected that or I'd have
pushed it last night.  It's probably worth renaming the option to
"float" or something to reduce confusion?
