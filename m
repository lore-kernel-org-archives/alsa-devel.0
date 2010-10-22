From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Alsamixertest
Date: Fri, 22 Oct 2010 09:53:09 +0800
Message-ID: <AANLkTinXbE9RQ5k4+nSPjdOC=HMvc7+yxH3VGgV7NhRD@mail.gmail.com>
References: <4C9F6409.6010400@aknet.ru> <20100927005858.GD21247@sirena.org.uk>
	<4CA0221D.6030208@aknet.ru> <i7qltg$bph$1@dough.gmane.org>
	<AANLkTi=9gcs0A6s55wSS-RP4NucvUqkxCoYynezdF+5g@mail.gmail.com>
	<4CA306CB.1090305@canonical.com>
	<AANLkTi=h+ZKXNdhmC1BtTbBaGF6_V+uD2ZO7sx4WMJMW@mail.gmail.com>
	<4CA9877F.7060009@canonical.com> <4CA9C22A.2010104@ladisch.de>
	<4CA9C7BE.7020804@canonical.com>
	<AANLkTinJnCQvQmQL16-pWBhmaZjW1_nUayHVa-yaC3FO@mail.gmail.com>
	<4CBFF0BB.5060900@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 4B126103ACD
	for <alsa-devel@alsa-project.org>;
	Fri, 22 Oct 2010 03:53:10 +0200 (CEST)
Received: by bwz9 with SMTP id 9so907215bwz.38
	for <alsa-devel@alsa-project.org>; Thu, 21 Oct 2010 18:53:10 -0700 (PDT)
In-Reply-To: <4CBFF0BB.5060900@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2010/10/21 David Henningsson <david.henningsson@canonical.com>

> On 2010-10-21 06:36, Raymond Yau wrote:
> > 2010/10/4 David Henningsson<david.henningsson@canonical.com>
> >
> >>
> >>
> >> Exactly, this is a test tool that checks whether the mixer control names
> >> and dB information live up to PulseAudio's expectations. That's the
> >> tool's purpose.
> >>
> >> What's PulseAudio' s expectation ?
> >
> > PA 's developer seem expect max_dB of all HDA codec are 0dB
> >
> > Your alsamixertest program does not test any dB range above 0dB
>
> That's correct, I don't really know how to deal with that, and I'm not
> sure how PA deals with that either. I assume it goes above 0 dB on one
> of the volume controls when a user wants it to.
>
>
alsamixertest-48.11 does allow user to specify a negative step to allow test
volume over 0dB , but your program seem go to infinite loop




DEBUG:root:Run subprocess: ('amixer', '-D', 'hw:0', '--', 'sset',
"'Master',0", '3.000000dB', 'unmute')
DEBUG:root:Run subprocess: ('amixer', '-D', 'hw:0', 'sget', "'Master',0")
DEBUG:root:dB = 3.000000 get 0.000000 gives pstate = {'Front Left':
{'muted': False, 'dB': 0.0, 'value': 31}, 'Front Right': {'muted': False,
'dB': 0.0, 'value': 31}}
DEBUG:root:Run subprocess: ('amixer', '-D', 'hw:0', '--', 'sset',
"'Master',0", '4.500000dB', 'unmute')
DEBUG:root:Run subprocess: ('amixer', '-D', 'hw:0', 'sget', "'Master',0")
DEBUG:root:dB = 4.500000 get 0.000000 gives pstate = {'Front Left':
{'muted': False, 'dB': 0.0, 'value': 31}, 'Front Right': {'muted': False,
'dB': 0.0, 'value': 31}}
DEBUG:root:Run subprocess: ('amixer', '-D', 'hw:0', '--', 'sset',
"'Master',0", '6.000000dB', 'unmute')
DEBUG:root:Run subprocess: ('amixer', '-D', 'hw:0', 'sget', "'Master',0")
DEBUG:root:dB = 6.000000 get 0.000000 gives pstate = {'Front Left':
{'muted': False, 'dB': 0.0, 'value': 31}, 'Front Right': {'muted': False,
'dB': 0.0, 'value': 31}}
DEBUG:root:Run subprocess: ('amixer', '-D', 'hw:0', '--', 'sset',
"'Master',0", '7.500000dB', 'unmute')
DEBUG:root:Run subprocess: ('amixer', '-D', 'hw:0', 'sget', "'Master',0")
DEBUG:root:dB = 7.500000 get 0.000000 gives pstate = {'Front Left':
{'muted': False, 'dB': 0.0, 'value': 31}, 'Front Right': {'muted': False,
'dB': 0.0, 'value': 31}}
DEBUG:root:Run subprocess: ('amixer', '-D', 'hw:0', '--', 'sset',
"'Master',0", '9.000000dB', 'unmute')
DEBUG:root:Run subprocess: ('amixer', '-D', 'hw:0', 'sget', "'Master',0")
DEBUG:root:dB = 9.000000 get 0.000000 gives pstate = {'Front Left':
{'muted': False, 'dB': 0.0, 'value': 31}, 'Front Right': {'muted': False,
'dB': 0.0, 'value': 31}}
DEBUG:root:Run subprocess: ('amixer', '-D', 'hw:0', '--', 'sset',
"'Master',0", '10.500000dB', 'unmute')
