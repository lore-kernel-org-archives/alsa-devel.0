From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: [Sound-open-firmware] Signed firmware availability
	for kbl/cnl
Date: Wed, 31 Jul 2019 14:23:37 +0100
Message-ID: <0059ed8e8f2fbd7ffbc258ca53ce5efbf1885c5b.camel@linux.intel.com>
References: <CAD8Lp45Bp1xVC7NjuNaANA7kAEN2Edshw+cViaTF3tRZEumgZA@mail.gmail.com>
 <cc9fa5b52138daffb09dc5b66ea9248379c9f60e.camel@linux.intel.com>
 <CAD8Lp46GW8n8K7ttOeSje_au06BsyvCp4seVwj2wNbipei5ssA@mail.gmail.com>
 <a4b17a75-d4e0-fc6b-a286-aa6b7b281b7d@linux.intel.com>
 <CAD8Lp444soO1i8mWF73eucT16yAhy2js1byWJCTV5fn=TikHBg@mail.gmail.com>
 <9e8b667f1aa2333dbcc34b5253372d1a8667551e.camel@linux.intel.com>
 <ee34f820-0753-dfbe-09c0-7147cf229cc0@perex.cz>
 <6493f195-eb5a-1a6d-2c31-e3a4123b2ad1@linux.intel.com>
 <7c940d90-297e-19c0-2f74-1843439d5ccf@perex.cz>
 <d41b02286db2a827648d1c1ec793bbd0a55e99c1.camel@linux.intel.com>
 <8dceb60b-35a5-93e9-ce01-1eb852e93f44@perex.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <8dceb60b-35a5-93e9-ce01-1eb852e93f44@perex.cz>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Jaroslav Kysela <perex@perex.cz>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Daniel Drake <drake@endlessm.com>, "Lin, Mengdong" <mengdong.lin@intel.com>
Cc: Jian-Hong Pan <jian-hong@endlessm.com>, ALSA development <alsa-devel@alsa-project.org>, sound-open-firmware@alsa-project.org
List-Id: alsa-devel@alsa-project.org

+ Mengdong

On Wed, 2019-07-24 at 18:23 +0200, Jaroslav Kysela wrote:
> > Yeah, been thinking about this atm. It may be better to package the
> > binaries (firmware and topologies) as part of Linux firmware repo
> > (since the driver expects to load them all from lib/firmware) and
> > package the sources (firmware and topology) via sof tarball ?
> 
> It looks good in my eyes, because topology files are another pieces
> of the
> driver from the user space perspective. The unanswered question is
> the UCM
> configuration which is linked to the topology configuration (if I
> understand
> this correctly). I proposed to place an unique identifier/version to
> the
> topology file and propagate this identifier to the user space, so the
> alsa-lib
> can pick the right UCM configuration when topology changes. The
> component
> string (snd_component_add function / struct snd_ctl_card_info ->
> components)
> can be used for this identification.

Apologizes for the delay, Pierre and I have been discussing this
internally as we have to synchronise the deployment of the topologies
and UCMs alongside the FW.

Current thinking has changed from shipping FW + tplg via linux-firmware 
repo to only shipping FW binaries in the FW repo and using alsa-ucm-
conf.git for UCMs + topologies (since the coupling between UCM and
topology is tighter than the FW coupling).

Any objections to using this repo for topologies too ? I know we
haven't yet used it for UCMs but now is probably a good point to move
(including moving the older UCMs over too).
The "make" rule would compile topologies, whilst the "make install"
rule would install the UCM's and binary topologies in the correct
places ?

Thanks

Liam
