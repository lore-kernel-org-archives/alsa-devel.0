From: Gerrit Niestijl <g.niestijl@rijndam.nl>
Subject: Utility for recording audio track with midi clock
Date: Thu, 01 Jul 2004 13:35:24 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <ufz8c0xkz.fsf@rijndam.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

A friend of mine owns a Roland vs-1680 harddiskrecorder. It has a
feature that allows for recording and playing back a midi clock signal
alongside the audio tracks. This makes it possible to create a tempo
map with a (hardware) sequencer, record it on the vs-1680, and use it
to keep the sequencer in sync with subsequently recorded audio tracks .

We work together on a project, and i would like to be able to record
and play back the audio mix from the vs-1680 to my computer together
with the midi clock data (he takes his machine home to work on the
audio part). That way i can work on the sequences on my mpc1000, and
play back the audio whith the sequences synced  midi clock slave.

I believe there is currently no linux app that can do that, so i am
considering to try to create a utility for it. But i have little
programming experience and none regarding alsa and jack, so i would
like feedback on my ideas.

My plan is to write a little program that opens 2 midi ports (in and
out) and 2 jack ports (in and out). The program wil monitor the midi
input port for midi clock messages. It will write zero's to the jack
output port but when it recieves a midi clock message it will write a
value of 1 to the jack port. This way i can store the midi clock
signal in a audio file, for example with ecasound. I know, this is
ugly! For playback i would have the program monitor the jack input port and
output a midi clock message when a sample value of 1 passes by.

I hope this explains my plan clear enough. I have looked at the
example programs for alsa and jack and to me it looks like i could
copy and paste something together, that could be my lack of
experience. What do you think? Is this possebly going to work or do i
overlook major difficulties?

Any advice would be very welcome!

-- 
Greetings, Gerrit



-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
