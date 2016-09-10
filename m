From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [RFC][PATCH 0/2] ALSA: control: limit life time of
 user-defined element set
Date: Sat, 10 Sep 2016 14:20:22 +0900
Message-ID: <559a57a9-ac1e-1bc4-dc23-f2e16eaf452f@sakamocchi.jp>
References: <1472983616-16254-1-git-send-email-o-takashi@sakamocchi.jp>
 <c05a8424-724d-89a1-7a70-c2365420d7d7@ladisch.de>
 <s5hpoojd3k8.wl-tiwai@suse.de>
 <6cc7e474-64f0-d74e-61bd-e6428929f984@sakamocchi.jp>
 <4d3f5151-6094-b714-b9cb-bedc1222f6cd@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id 8CB4F266702
 for <alsa-devel@alsa-project.org>; Sat, 10 Sep 2016 07:20:27 +0200 (CEST)
In-Reply-To: <4d3f5151-6094-b714-b9cb-bedc1222f6cd@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Takashi Iwai <tiwai@suse.de>, jimmy@spalge.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Clemens,

On Sep 6 2016 15:28, Clemens Ladisch wrote:
> Takashi Sakamoto wrote:
>> When detecting some audio and music units on IEEE 1394 bus, the daemon
>> program adds some element sets and start listening to them. If ALSA
>> control applications changes state of elements in the element sets,
>> the daemon catches the event and configure these units by hardware-
>> specific ways.
> 
> If these controls are removed when the daemon exits, the normal alsactl
> mechanism of saving/restoring does not work.

Yes, because many of supported audio and music units on IEEE 1394 have
on-board non-volatile memory to restore current state every at
rebooting. I have a plan to utilize it in the daemon. In this case,
restoring from alsactl is conflicts to the feature.

Besides, the rest of units mostly have no feature corresponding to
control elements.

In detail:
 - With control elements and on-board non-volatile memory
   - DM1000/1100/1500 with BeBoB firmware:
   - Dice:
   - Fireworks board module:
- With control elements and non on-board memory
 - OXFW
- No control elements (controlled via MIDI messages)
 - firewire-tascam:
- Unknown
 - firewire-digi00x (certainly have some control elements)
 - firewire-motu (not yet)
 - firewire-rme (not yet)

> I guess the reason for removing the controls is to avoid the case that
> they are non-functional if the daemon is not running?

Yes. For the case, I plan to restart the daemon by 'Restart' directive
of systemd service unit file. Then, in current ALSA control
implementation, elements remains.

In ALSA control core, the maximum number of user-defined element sets is
limited up to 32. So left elements causes an issue that the daemon
cannot add more element sets in a half of way to start.

Of course, I can program the daemon to check the name of adding/added
elements. But to avoid the cumbersome, I simply hope to constrain life
time of element set to file descriptors.

However I have a hesitation for this direction; a daemon for control
service. It might be more huge than what I require, and larger work
against rest of my free time. In short, most of what I need are
satisfied with the combination of libhinawa/hinawa-utils, just to
control the units. I don't prefer over-specification[0]. But I hear
users seem to hope to control their units via ALSA control interface.

Well, this patchset is for more generic issues discussed longer term.
I'd get your comments regardless of an idea of the server.

[0] ffado-dbus-server/ffado-mixer is this kind of software.


Regards

Takashi Sakamoto
