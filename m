From: Arnaud Patard <apatard@mandriva.com>
Subject: Re: AD1986a
Date: Wed, 11 Jan 2006 14:15:30 +0100
Message-ID: <m3k6d6vrbh.fsf@anduin.mandrakesoft.com>
References: <m34q4jx38i.fsf@anduin.mandrakesoft.com>
	<s5hlkxpgzb4.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hlkxpgzb4.wl%tiwai@suse.de> (Takashi Iwai's message of "Mon,
	09 Jan 2006 17:07:27 +0100")
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai <tiwai@suse.de> writes:

> At Wed, 04 Jan 2006 19:22:21 +0100,
> Arnaud Patard wrote:
>> 
>> Hi,
>> 
>> 
>> I have the same problem as
>> https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1678
>> 
>> I though that it was only a matter of how the hda verbs were initialised
>> so I made a patch allowing to change the channel configuration
>> (http://people.mandriva.com/~apatard/ad1986a_2channel_mode_fix.patch).
>> Unfortunately, this was not enough. 
>
> This patch looks fine.

okay. I'll probably wait for the noise bug to be fixed before sending it
for inclusion.

>
>> Today, I've added this patch
>> http://people.mandriva.com/~apatard/dont_copy_front.patch which is
>> working but it's rather something ugly.
>> 
>> Moreover, I'm only able to test this with two speakers, so I don't know
>> if these patches are working with 4 or 6 channels setups.
>
> Surely won't work since you disabled the signal to surrounds :)

hm.. so, I'm probably wrong but I though that this patch was only
preventing to send front signal to others DACs when a stereo sound is
playing (thus playing 5.1 sound on 5.1 systems should still work).

>
>> Any hint on how to debug and fix this bug ?
>
> What is the exact status on your board?  Is only the front left
> channel noisy or silence?  I still don't figure out how the latter
> patch fixes the problem...

Only the front left is noisy. The front right is fine. About how this is
fixing the bug, I have only guesses. I think it's a matter of codec
setup and doing this fixes it for unknown reasons. I've even noticed
that loading a module with this patch and then replacing it with the
original module was working too. It's weird :(

Arnaud



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
