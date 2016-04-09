From: Joe Perches <joe@perches.com>
Subject: Re: Checkpatch warnings on switch case fallthru
Date: Sat, 09 Apr 2016 12:45:10 -0700
Message-ID: <1460231110.1800.38.camel@perches.com>
References: <D32C47F6.1E2FD%ryan.harvey@cirrus.com>
 <s5hfuuvcfsr.wl-tiwai@suse.de> <570928CC.6030404@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtprelay.hostedemail.com (smtprelay0161.hostedemail.com
 [216.40.44.161])
 by alsa0.perex.cz (Postfix) with ESMTP id 556722617BB
 for <alsa-devel@alsa-project.org>; Sat,  9 Apr 2016 21:45:16 +0200 (CEST)
In-Reply-To: <570928CC.6030404@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>, Takashi Iwai <tiwai@suse.de>, "Harvey, Ryan" <Ryan.Harvey@cirrus.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Sat, 2016-04-09 at 18:07 +0200, Lars-Peter Clausen wrote:
> On 04/09/2016 11:06 AM, Takashi Iwai wrote:
> > =

> > On Fri, 08 Apr 2016 00:23:03 +0200,
> > Harvey, Ryan wrote:
> > > =

> > > =

> > > Hello,
> > > =

> > > I receive a set of checkpatch warnings against my switch fallthru
> > > structure in readable_registers().=A0=A0I=B9m able to eliminate these=
 warnings
> > > with a preceding comment, but that does messy the code.=A0=A0Is there=
 a method
> > > better than switch for accomplishing this?
> > > =

> > > static bool cs43130_readable_register(struct device *dev, unsigned in=
t reg)
> > > {
> > > =A0=A0=A0=A0=A0=A0=A0=A0switch (reg) {
> > > =A0=A0=A0=A0=A0=A0=A0=A0case CS43130_DEVID_AB ... CS43130_SYS_CLK_CTL=
_1:
> > > =A0=A0=A0=A0=A0=A0=A0=A0case CS43130_PWDN_CTL:
> > > =A0=A0=A0=A0=A0=A0=A0=A0case CS43130_PLL_SET_1 ... CS43130_PLL_SET_6:
> > > =A0=A0=A0=A0=A0=A0=A0=A0case CS43130_PLL_SET_7:
> > > =A0=A0=A0=A0=A0=A0=A0=A0case CS43130_PLL_SET_8:
> > > =A0=A0=A0=A0=A0=A0=A0=A0case CS43130_PLL_SET_9:
> > > =A0=A0=A0=A0=A0=A0=A0=A0case CS43130_PLL_SET_10:
> > > =A0=A0=A0=A0=A0=A0=A0=A0case CS43130_CLKOUT_CTL:
> > > =A0=A0=A0=A0=A0=A0=A0=A0case CS43130_ASP_NUM_1 ... CS43130_ASP_FRAME_=
CONF:
> > > =A0=A0=A0=A0=A0=A0=A0=A0case CS43130_HP_OUT_CTL_1:
> > > =A0=A0=A0=A0=A0=A0=A0=A0case CS43130_PCM_FILT_OPT ... CS43130_PCM_PAT=
H_CTL_2:
> > > =A0=A0=A0=A0=A0=A0=A0=A0case CS43130_CLASS_H_CTL:
> > > =A0=A0=A0=A0=A0=A0=A0=A0case CS43130_HP_DETECT ... CS43130_HP_STATUS:
> > > =A0=A0=A0=A0=A0=A0=A0=A0case CS43130_HP_LOAD_1:
> > > =A0=A0=A0=A0=A0=A0=A0=A0case CS43130_HP_LOAD_STAT:
> > > =A0=A0=A0=A0=A0=A0=A0=A0case CS43130_INT_MASK_1 ... CS43130_INT_MASK_=
5:
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return true;
> > > =A0=A0=A0=A0=A0=A0=A0=A0default:
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return false;
> > > =A0=A0=A0=A0=A0=A0=A0=A0}
> > > }
> > > =

> > > =

> > > 140: [WARNING] Possible switch case/default not preceeded by break or
> > > fallthrough comment
> > > +	case CS43130_PLL_SET_7:
> > > 141: [WARNING] Possible switch case/default not preceeded by break or
> > > fallthrough comment
> > > +	case CS43130_PLL_SET_8:
> > > 142: [WARNING] Possible switch case/default not preceeded by break or
> > > fallthrough comment
> > > +	case CS43130_PLL_SET_9:
> > > 143: [WARNING] Possible switch case/default not preceeded by break or
> > > fallthrough comment
> > > +	case CS43130_PLL_SET_10:
> > > 144: [WARNING] Possible switch case/default not preceeded by break or
> > > fallthrough comment
> > > +	case CS43130_CLKOUT_CTL:
> > > 152: [WARNING] Possible switch case/default not preceeded by break or
> > > fallthrough comment
> > > +	case CS43130_HP_OUT_CTL_1:
> > > 154: [WARNING] Possible switch case/default not preceeded by break or
> > > fallthrough comment
> > > +	case CS43130_CLASS_H_CTL:
> > > 156: [WARNING] Possible switch case/default not preceeded by break or
> > > fallthrough comment
> > > +	case CS43130_HP_LOAD_1:
> > > 160: [WARNING] Possible switch case/default not preceeded by break or
> > > fallthrough comment
> > > +	case CS43130_HP_LOAD_STAT:
> > You may ignore the warnings.=A0=A0The purpose of checkpatch is to impro=
ve
> > the code readability, and what it suggests is exactly opposite.
> It's a bug in checkpatch. It seems to get confused by the "...". The
> best approach to solving those warnings is to create a fix for checkpatch.

Can you send me the checkpatch.pl file you are using please?
