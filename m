From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 00/18] ALSA: firewire-motu: new driver for
 MOTU FireWire series
Date: Tue, 28 Mar 2017 22:16:42 +0900
Message-ID: <cbf3ce2d-fcec-3489-4c9e-c2ee0600b35d@sakamocchi.jp>
References: <20170322123028.24148-1-o-takashi@sakamocchi.jp>
 <s5h7f39n0px.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id 3704A26648D
 for <alsa-devel@alsa-project.org>; Tue, 28 Mar 2017 15:16:48 +0200 (CEST)
In-Reply-To: <s5h7f39n0px.wl-tiwai@suse.de>
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
Cc: David Henningsson <diwic@ubuntu.com>, alsa-devel@alsa-project.org, clemens@ladisch.de, ffado-devel@lists.sf.net, Kentaro Hayashi <hayashi@clear-code.com>
List-Id: alsa-devel@alsa-project.org

Hi,

On Mar 28 2017 19:40, Takashi Iwai wrote:
> On Wed, 22 Mar 2017 13:30:10 +0100,
> Takashi Sakamoto wrote:
>>
>> Hi,
>>
>> This patchset updates my previous RFCv2, and go for ALSA upstream.
>> http://mailman.alsa-project.org/pipermail/alsa-devel/2017-January/117211.html
>>
>> This patchset newly adds a driver into ALSA firewire stack, to support for
>> some models in MOTU FireWire series:
>>  - 828mk2
>>  - 828mk3 (FireWire only)
>>  - 828mk3 (Hybrid)
>>
>> The driver supports playbacking/capturing PCM frames and MIDI messages for any
>> sampling transfer frequencies, with current ALSA IEC 61883-1/6 packet streaming
>> engine.
>>
>> Unfortunately, units on MOTU FireWire series have many quirks against
>> IEC 61883-1/6. This brings much commits and descriptions on this patchset.
>> Sorry for reviewers but I'm glad to get your assist for this patchset.
>>
>> As I note in 8th commit, at sampling transfer frequency based on 44.1kHz, the
>> driver handles the units with choppy noises every few seconds. This is an issue
>> which is not resolved yet.
>>
>> Changes from RFCv2:
>>  - drop trial support for 828. If you have interests in development, please
>>    refer to one commit of my previous RFC. It describes v1 protocol.
>>   - http://mailman.alsa-project.org/pipermail/alsa-devel/2017-January/117226.html
>>  - improve commit messages.
>>
>> Takashi Sakamoto (18):
>>   ALSA: firewire-motu: add skeleton for Mark of the unicorn (MOTU)
>>     FireWire series
>>   ALSA: firewire-motu: postpone sound card registration
>>   ALSA: firewire-motu: add a structure for model-dependent parameters.
>>   ALSA: firewire-motu: add an abstraction layer for three types of
>>     protocols
>>   ALSA: firewire-lib: record cycle count for the first packet
>>   ALSA: firewire-lib: add support for source packet header field in CIP
>>     header
>>   ALSA: firewire-lib: enable CIP_DBC_IS_END_EVENT for both directions of
>>     stream
>>   ALSA: firewire-motu: add MOTU specific protocol layer
>>   ALSA: firewire-motu: handle transactions specific for MOTU FireWire
>>     models
>>   ALSA: firewire-motu: add stream management functionality
>>   ALSA: firewire-motu: add proc node to show current statuc of clock and
>>     packet formats
>>   ALSA: firewire-motu: add PCM functionality
>>   ALSA: firewire-motu: add MIDI functionality
>>   ALSA: firewire-motu: add hwdep interface
>>   ALSA: firewire-motu: enable to read transaction cache via hwdep
>>     interface
>>   ALSA: firewire-motu: add support for MOTU 828mk2 as a model with
>>     protocol version 2
>>   ALSA: firewire-lib: add a quirk of packet without valid EOH in CIP
>>     format
>>   ALSA: firewire-motu: add support for MOTU 828mk3 (FireWire/Hybrid) as
>>     a model with protocol version 3
>
> Applied all patches now to for-next branch.

Thanks for your reviewing and applying them. I have ease from the work 
which takes almost two years.

For users and testers, I push the commits into my remote repository to 
backport them to kernel since v4.4 till v4.11. Please refer to README in 
topmost of the file tree.
  * https://github.com/takaswie/snd-firewire-improve/

If using Ubuntu 16.04, deb package is now available in David 
Henningsson's PPA. I appreciate his continuous help for my work, thank you.
  * https://code.launchpad.net/~diwic/+archive/ubuntu/snd-firewire-improve

As I note, a commit for protocol v1 is omitted from this patchset, thus 
it's not supported yet. For anyone has interests in it, I push a remote 
branch with the commit.
  * https://github.com/takaswie/snd-firewire-improve/tree/topic/motu-v1

I wrote libhinawa, a user space library with gobject introspection, to 
communicate audio and music units on IEEE 1394 bus. Soon I'll release 
v0.8.0 with HinawaSndMotu gobject class, to receive asynchronous 
notifications from MOTU units. You can see its initial version in my 
remote repository.
  * https://github.com/takaswie/libhinawa/tree/topic/motu

libhinawa is already packaged for debian/ubuntu. In a few months, I'll 
work to update the package in each repositories with a contributor, 
Kentaro hayashi, who is a package maintainer in debian project.
  * https://tracker.debian.org/pkg/libhinawa
  * https://launchpad.net/ubuntu/+source/libhinawa

By the way, next, I'll post a patchset for snd-fireface, a driver for 
RME FireWire series.


Thanks

Takashi Sakamoto
