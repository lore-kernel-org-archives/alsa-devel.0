From: "Sam Revitch" <sam.revitch@gmail.com>
Subject: stateful reconnect with snd-usb-audio
Date: Mon, 12 Jun 2006 14:05:15 -0700
Message-ID: <8d4807d50606121405n51edef2au3de163b01029aaf5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi everybody,

I'd like to solicit the ALSA brain trust for tips and opinions on how
one might go about implementing a new feature.  With some (most?) of
the ALSA driver code base, it is possible, or at least someone
intended for it to be possible to leave an MP3 player or such running
across a suspend-to-RAM or suspend-to-disk operation, and have it pick
up exactly where it left off on resume.  To see this in action is just
cool, there's no getting around it.  A notable exception to this  is
the snd-usb-audio driver, under which devices seem to be disconnected
and re-enumerated as entirely new cards, rather than having their
state explicitly backed up and restored with the assumption that the
hardware will be present on resume.

I searched hard and couldn't find any prior efforts to address this
problem, so it seemed worthwhile to ask about.

There are two possibilities that seem promising:

1. Rework snd-usb-audio to support a timely reconnect operation.  If a
card is unplugged and reconnected within some period of time, its
prior state will be restored and it will be reassociated with open
file handles.  Active playback/capture operations may continue without
reopening the device, with only the reconnection/reconfiguration
delay.

2. Support reconnection at the alsa-lib layer.  I couldn't find
anything that does this already.  Somehow all playback/capture file
descriptors would need to be closed on command and
reopened/reconfigured when a replacement device is identified.
Anybody know of an easy way to do this with dmix?  Otherwise it seems
like alsa-lib would be stuck funneling playback through an
aserver/jackd process and that would be undesirable.

Opinions?  Does one seem like it would be more robust, more reusable,
or more work than the other?

As another individual pointed out a few months ago, there are some
other problems with snd-usb-audio similar to those described above.
If a certain usb audio device has open file handles and is
disconnected or the system is suspended,
snd_usb_audio_disconnect()->snd_card_free() will block in the khubd
context while ALSA waits for the file handles to be closed, preventing
khubd from doing anything else useful like processing probe requests.
Using snd_card_free_in_thread() can be just as bad as it uses
schedule_work() and blocks one of the "events" threads.  A hang in
either context can cause problems for a resume-from-RAM operation.

Thanks.
-Sam Revitch
