From: "Ivica Bukvic" <ico@fuse.net>
Subject: [ANN] RTMix software interactive multimedia interface version 0.7 released (3/10/03)
Date: Sun, 9 Mar 2003 16:07:31 -0500
Sender: linux-audio-announce-admin@music.columbia.edu
Message-ID: <000001c2e67f$e6a715a0$ac1f830a@ICO>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-audio-announce-admin@music.columbia.edu>
Errors-To: linux-audio-announce-admin@music.columbia.edu
List-Help: <mailto:linux-audio-announce-request@music.columbia.edu?subject=help>
List-Post: <mailto:linux-audio-announce@music.columbia.edu>
List-Subscribe: <http://music.columbia.edu/mailman/listinfo/linux-audio-announce>,
	<mailto:linux-audio-announce-request@music.columbia.edu?subject=subscribe>
List-Unsubscribe: <http://music.columbia.edu/mailman/listinfo/linux-audio-announce>,
	<mailto:linux-audio-announce-request@music.columbia.edu?subject=unsubscribe>
List-Archive: <http://music.columbia.edu/pipermail/linux-audio-announce/>
To: linux-audio-dev@music.columbia.edu, linux-audio-announce@music.columbia.edu, linux-audio-user@music.columbia.edu, pd-announce@iem.kug.ac.at, pd-list@iem.kug.ac.at, osc_dev@create.ucsb.edu, icma-post@umich.edu, SEAMUS-L@LISTSERV.LSU.EDU, alsa-devel@lists.sourceforge.net, alsa-user@lists.sourceforge.net
Cc: matt@cnmat.berkeley.edu
List-Id: alsa-devel@alsa-project.org

Hello fellow musicians, composers, multimedia sculptors, and developers!

It is my pleasure to announce to you the newest release of RTMix version
0.7.

New improvements include:

*Internal error widget has been removed.
*External Error Log now became a general purpose Console.
*Added visuals for monitoring of data flow at the bottom of the external
Console.
*Sped-up the start-up time by 300-400% (literally :-)
*Fixed bug where global transport events did not execute on a local
client causing many scripts to fail.
*Reordered Tabs on the main widget.
*Made External resizable widgets resizable only when performance was not
in session (in order to minimize cpu-utilization by RTMix during the
performance settings).
*Fixed Metronome weird resizing bug. Now when the meter is changed, the
widget resizes appropriately.
*Fixed color coding errors for the notification interface.
*Re-arranged the settings saving routines.
*Added new parameters to the config file.
*Added networking authentication code and made it configurable in the
settings tab.
*Added filter for events in order to disable potentially malicious
sys-calls to be executed.
*Fixed gazillion (literally :-) bugs in the parsing engine.
*Standardized error and logging output messages.
*Color-coded Console messages.
*Added "go-to-error" feature.
*Implemented MIDI protocol as a separate thread. Users can now use MIDI
for real-time events, as well as MIDI routing.
*Provided new tabs in the settings menu that enable user to specify the
appropriate MIDI port.
*Implemented OSC (Open Sound Control) for inter-app communication.
*Implemented generic OSC network communication.
*Implemented OSC routing for the purpose of sharing the MIDI port.
*Enabled variables to be included in notification interface messages.
*Enabled multiple instance of variables and MIDI parameters to be
included in functions, assigns, and events (sys calls and others).
*Fixed metronome's inconsistent resizing.
*Fixed bug where BPM's  on the metronomes 2-4 were corrupt.
*Jump events now interpret events they jump to in a proper fashion.
*Added full-fledged HTML documentation (Yay!)
*Included more tutorials and provided better annotations for the older
ones.
*Made apply button disabled in the settings menu, unless something was
changed.
*Made MIDI monitoring and MIDI logging buttons disabled by default,
unless the real-time monitoring is enabled.
*Added color-coding and more verbose descriptions of the real-time
events in the table.
*Enabled differentiation between keyboard presses and releases and their
mappings to the real-time events.
*Added line-number tool for the editor.
*Fixed behavior of the probability parameters.
*Annotated more parser's warnings.
*Implemented protection against infinite recursion scripts.
*Other stuff that I cannot think of at this moment.

---------------------------------------------------------------

RTMix is downloadable here:

http://meowing.ccm.uc.edu/~ico/rtmix-latest.tar.gz

(approx. file size is 4.8MB).

For more info, see the included HTML docs, or visit the author's webpage
at 

http://meowing.ccm.uc.edu/~ico/

RTMix currently runs only on Linux, although the transparency of code
should make it easily portable to other Unix platforms supporting Qt
toolkit.

---------------------------------------------------------------

If you are not familiar with RTMix, here's a quick overview:

What is RTMix?

RTMix is an open-source (GPL-licensed) software application designed to
provide stable, user-friendly, standardized, and efficient performance
interface that enables performer(s) to interact with both the computer
and each other in the least obtrusive fashion. What this means is that
RTMix offers an array of visual stimuli that can be utilized on-stage in
order to coordinate various performing forces utilizing diverse media.

What do I need it for?

How many times have you witnessed an interactive work that requires
coordination between the composer and performer, composer usually being
off-stage and posing as an aircraft navigator sending out all kinds of
signals with waving hands and other distracting (perhaps even comical)
physical gestures?

Have you ever questioned computer's off-stage presence when it has an
important role in generating the resulting sonic landscape (or even a
multimedia setting)?

Did you ever wish to have an elegant on-stage interface that is easy to
use and furthermore provides the least amount of distraction for the
performer(s) -- an interface that offers standardization,
transportability, and most importantly low cpu-footprint, therefore
enabling user to utilize majority of processor cycles for the stuff that
matters the most -- the content-generation, processing and reproduction?

Have you ever wished to have your work more "transportable", to have it
more accessible and more easily performable in settings where you were
not physically available to provide technical support to the
not-so-computer-literate performer?

Did you ever write a chamber acoustic work that required considerate
amount of coordination but you did not want to use a conductor? How
about a work for a large performing groups?

Do you use powerful Music-N languages for real-time work but do not have
an elegant interface for real-time performance settings?

Are you a PD/Max/MSP/jMax object-oriented multimedia composer, but do
not want to deal with designing the user-interface for your
contraptions, nor with the lack of standardization such interfaces
impose on end-users (i.e. performers other than the composer
themselves)?

Did you ever feel like using only one multimedia tool at a time was
limiting your creativity (i.e. Csound, RTcmix, Supercollider, Pd,
Max/MSP, etc.) and that you always wanted to have multiple audio
applications to coexist in your work?

If you have answered any of these questions positively, then RTMix just
might be the answer to your needs :-).

---------------------------------------------------------------

RTMix is going to be showcased next week at SEAMUS2003 conference at the
Arizona State University. Should you have any additional questions,
please do not hesitate to contact me. Thank you!

Sincerely,

Ivica Ico Bukvic, multimedia sculptor
http://meowing.ccm.uc.edu/~ico

P.S. Apologies for cross-posting!
