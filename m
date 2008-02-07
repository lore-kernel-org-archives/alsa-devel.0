From: Aldrin Martoq <amartoq@dcc.uchile.cl>
Subject: Re: [PATCH] SND_SEQ_BLOCK and
	SND_SEQ_PORT_CAP_NONE	defines
Date: Thu, 07 Feb 2008 19:19:14 -0300
Message-ID: <1202422754.26320.32.camel@localhost>
References: <17eedd8a0801310942g48245675k4a96162e810fd21a@mail.gmail.com>
	<Pine.LNX.4.61.0802061040270.8113@tm8103.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fk-out-0910.google.com (fk-out-0910.google.com [209.85.128.188])
	by alsa0.perex.cz (Postfix) with ESMTP id E2DF3243D3
	for <alsa-devel@alsa-project.org>; Thu,  7 Feb 2008 23:19:36 +0100 (CET)
Received: by fk-out-0910.google.com with SMTP id f40so3302113fka.0
	for <alsa-devel@alsa-project.org>; Thu, 07 Feb 2008 14:19:36 -0800 (PST)
In-Reply-To: <Pine.LNX.4.61.0802061040270.8113@tm8103.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wed, 2008-02-06 at 10:51 +0100, Jaroslav Kysela wrote:
> On Thu, 31 Jan 2008, Aldrin Martoq wrote:
> > While developing pyalsa sequencer API, I found that sometimes 0 is
> > used instead of a #defined value or constant.
> > In my opinion, given that the alsa API is opaque (hides internal
> > structure and provides methods for accessing them), we should define
> > those missing "constants" for being consistent. So far I found:
> > SND_SEQ_BLOCK 0 (blocking mode)
> > SND_SEQ_PORT_CAP_NONE (the port defines no access capabilites)
> Note that SND_SEQ_NONBLOCK is flag (bitmask). Also SND_SEQ_PORT_CAP_* 
> defines are bitmasks. I don't see usage to have defined for 0 because it 
> always mean "off state" rather than a direct value. Correct tests are:
> val&SND_SEQ_NONBLOCK		- nonblocking behaviour
> (val&SND_SEQ_NONBLOCK)==0	- blocking behaviour

Yup, I was sorry for my mistake; I'm fixing (removing) this in my
current python binding.

I think my mistake originated because there is no snd_seq_set_mode
function API. The snd_seq_nonblock method is inconsistent with the flag
behaivor. So, I'm sticking with changing the mode of a Sequencer
instance through Sequencer.mode attribute.

> Regarding python. I think that we need to settle naming scheme. I just 
> moved my code to follow standard python rules (only class names have upper 
> letters and constants).

Yeah, I think we should follow current python PEP's:
a) Naming conventions
http://www.python.org/dev/peps/pep-0008/
b) Doc strings
http://www.python.org/dev/peps/pep-0257/

a) Says basically:
- Class names are CapsWords; like in SeqEvent or SequencerError.
- method names are lowercase and _ separated, like in
get_mixer_controls().
- members of classes lowercase and _ separated.
- There are no strict rules, so this are recommended practices.
Sometimes, some modules follow other rules (ex: st_mode).

However, I couldn't find anything regarding constant naming in PEPs. I
suggest:
- keeping names all uppercase and _ separated. Must follow or imitate
original C naming; like in SND_SEQ_NONBLOCK.
- I'm not sure if keeping constants "inside" the module or make them
exportable ("from alsaseq import *"). In the first way, we may follow
python-gtk naming scheme (ex: gtk.gdk.AXIS_IGNORE); in the second way,
we may stick to something like alsaseq.SND_SEQ_NONBLOCK or
alsaseq.SEQ_NONBLOCK.

http://www.pygtk.org/docs/pygtk/gdk-constants.html


Jaroslav, What do you prefer?



> I also chose a different organization for constants in my code to have 
> possibility to enumerate all related bitmasks or numbers using 
> dictionaries. See my python modules.
> It meas to define SEQ_ADDRESS_* like:
> seq_address = {'BROADCAST': 0xff, 'SUBSCRIBERS': 0xfe, 'UNKNOWN': 0xfd}
> open_mode = {'NONBLOCK': 1}
> etc...

I like your idea, and I'm thinking to change to that.

I first created the Constant class to force use them instead of an
integer... The method was, raise a Warning error if the user didn't
provide a Constant instance for some argument. That's why I implemented
the NumProtocol for Constant: it returns a Constant for a bitwise
between Constants... Then I realised this was too much strict type
checking (like java) and not the python way, so I'm thinking of removing
the numeric protocol for Constant. Note that the current code doesn't
throw any warning.

However, I think a Constant class is useful, if you call __repr__ or
__str__ to an instance it will return the name instead of looking
through a dictionary.



Thanks for all your help, I'm still working for completing the full
sequencer API. I'll be done/happy if a cover 80% of it: I've realized
that open_lconf will need a new python binding for the Configuration
API.

-- 
Aldrin Martoq <amartoq@dcc.uchile.cl>
