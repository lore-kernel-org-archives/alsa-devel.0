From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 0/6] ALSA: firewire: simplify symbol space
 for local linkage
Date: Wed, 4 Jan 2017 19:36:10 +0900
Message-ID: <387d35ad-0261-689f-8680-af68351d87a6@sakamocchi.jp>
References: <20170103124121.17143-1-o-takashi@sakamocchi.jp>
 <s5hwpecm1c0.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id 4F138266950
 for <alsa-devel@alsa-project.org>; Wed,  4 Jan 2017 11:36:17 +0100 (CET)
In-Reply-To: <s5hwpecm1c0.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, clemens@ladisch.de
List-Id: alsa-devel@alsa-project.org

Hi,

On Jan 4 2016 03:43, Takashi Iwai wrote:
> On Tue, 03 Jan 2017 13:41:15 +0100,
> Takashi Sakamoto wrote:
>>
>> Hi,
>>
>> This patchset is just for code improvements, without adding features.
>>
>> Modules in ALSA firewire stack have some implementations for operation
>> structures which sound subsystem defines. All of them are referred just by
>> each local function to register corresponding operations. In this case, it's
>> better to put them into the function local so that symbol space in local
>> linkage of translation unit is kept to be simple.
>
> Do we see any merit in the resultant binaries by these changes?
> I'm not against this kind of code changes, but just wondered.
> That is, it's not totally clear what you takes as really "better" in
> your context.

Mmm, sorry but my explanation is wrong. I managed to describe the reason 
in an aspect of local linkage, but an aim of this patchset is irrelevant 
to it.

The aim is for identifier space of each translation unit. The merit can 
be described in two points:
  - For readers
   - readers have no concern about where the identifier is referred.
     It's just inner the including function.
  - For identifier space of the file
   - developers are free from name conflict for further work.

If no objections against the aim, I'll resubmit this patchset with 
proper commit comments.


Thanks


Takashi Sakamoto

>>
>> Takashi Sakamoto (6):
>>   ALSA: bebob: simplify symbol space for local linkage
>>   ALSA: fireworks: simplify symbol space for local linkage
>>   ALSA: oxfw: simplify symbol space for local linkage
>>   ALSA: dice: simplify symbol space for local linkage
>>   ALSA: firewire-digi00x: simplify symbol space for local linkage
>>   ALSA: firewire-tascam: simplify symbol space for local linkage
>>
>>  sound/firewire/bebob/bebob_hwdep.c         | 17 +++++-----
>>  sound/firewire/bebob/bebob_midi.c          | 26 +++++++--------
>>  sound/firewire/bebob/bebob_pcm.c           | 51 ++++++++++++++---------------
>>  sound/firewire/dice/dice-midi.c            | 22 ++++++-------
>>  sound/firewire/digi00x/digi00x-hwdep.c     | 17 +++++-----
>>  sound/firewire/digi00x/digi00x-midi.c      | 52 ++++++++++++++----------------
>>  sound/firewire/digi00x/digi00x-pcm.c       | 52 ++++++++++++++----------------
>>  sound/firewire/fireworks/fireworks_hwdep.c | 19 ++++++-----
>>  sound/firewire/fireworks/fireworks_midi.c  | 26 +++++++--------
>>  sound/firewire/fireworks/fireworks_pcm.c   | 52 ++++++++++++++----------------
>>  sound/firewire/oxfw/oxfw-midi.c            | 26 +++++++--------
>>  sound/firewire/tascam/tascam-hwdep.c       | 17 +++++-----
>>  sound/firewire/tascam/tascam-midi.c        | 26 +++++++--------
>>  sound/firewire/tascam/tascam-pcm.c         | 52 ++++++++++++++----------------
>>  14 files changed, 215 insertions(+), 240 deletions(-)
>>
>> --
>> 2.9.3
