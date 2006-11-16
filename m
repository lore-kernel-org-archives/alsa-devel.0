From: "Giovanni Maruzzelli" <gmaruzz.lists@gmail.com>
Subject: Celliax LiveCD released (Asterisk managing cellular
	phones, and Skype calls to/from cellphones, via chan_celliax,
	ALSA based)
Date: Thu, 16 Nov 2006 21:07:10 +0100
Message-ID: <7c5010d60611161207p57d89f1dg24912a9265212d41@mail.gmail.com>
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

Celliax development and download site: www.celliax.org

Celliax is a channel driver for the Asterisk Free PBX that manages GSM
and CDMA cellular phones through an adapter, composed by a datacable
(for commands) and an audiocable (for the voice) interfacing the
computer soundcard. Runs on Linux and Windows with cygwin (see below for more).

chan_celliax is also capable of making and receiving Skype calls
through the cellphone, and has an app like app_directory that let you
choose which one of your Skype contacts you want to call.

Celliax runs on Asterisk 1.2 on Linux and Windows (with cygwin and a
little modification to the compilation of Asterisk to avoid the calls
to sigkill), and on Asterisk 1.4 only in Linux (because Asterisk 1.4
itself does not build on Windows, at date).

Together with chan_celliax is distributed the Celliax LiveCD, with a
working installation of Asterisk, chan_celliax, and configuration
utilities based on Knoppix. The Celliax LiveCD contains also all is
needed to run Celliax on Windows:the cygwin installer and the tgz with
the asterisk-celliax stuff to be untarred in a basic cygwin
installation.

Celliax development and download site: www.celliax.org

What's New in 0.0.32:

  * LiveCD:
        o Now you can save all your configuration between reboots
(Celliax, Skype, Language, etc). You can save all of them on a regular
file on your hard disk (or on a USB key) and have all of it
automatically reloaded at next boot. No more need to "retrain" Skype
at each reboot!
        o Linux support for all kind of datacables in the Celliax Devkits
        o New kernel 2.6.17.14 with ark3116 and working wireless
ipw2200 modules
        o Headless Celliax, cellphones, Asterisk and Skype (without
X)! Booting in console mode you find a script
(/usr/local/asterisk/usr/sbin/celliax_server) that automatically
launch Xvfb (the fake X11 server), Skype and Celliax. Also via ssh!
Isn't that cute?
        o Graphic configuration for Celliax
        o Automatically download the latest sources with an svn
script (/usr/local/asterisk/usr/sbin/svn_celliax, now's working)
        o Contains the Windows XP drivers for the Celliax DevKit datacables

  * Celliax (both Linux and Windows):
        o Asterisk 1.2.13
        o New configuration file format
        o Better interaction with Skype (no more stuck in skype_dir,
much faster skype_dir on Windows)
        o Source code is more readable (but will be much cleaned,
refactored and polished in the future ;) ) and beginning of Doxygen
documentation
  * And many more minor things...

_____________________

>From the "Detailed description" of the chan_celliax's Doxygen documentation:

Celliax, audio-serial driver for cellular phones (Skype calls
supported) and ALSA voicemodems (no Skype calls).

General overview

The Celliax channel(s) interact with the outside world via audio
device(s) and (optional) serial port(s).

The original purpose of Celliax was the recycling of old cellular
phones floating around the world, using them as "base station" devices
for Asterisk.

As additional feature, Celliax makes a bridge between the cellphone
and the Skype client running on the same computer Asterisk is running,
enabling the cellphone to "put you through" Skype calls.

Another additional feature is the management of ALSA voicemodems, in
which case Skype calls are not supported.

Cellular phones management is operated through audio-datacable, serial
commands and soundcard. Voicemodems through ALSA driver. Skype calls
to/from cell phones are managed via Skype client API (X11 or Windows)
and audiocable.

Hardware managed

For testing purposes, you can operate a Celliax channel without
additional hardware, just headset and microphone. This way you will
have an experience similar to the one you got from chan_oss or
chan_alsa, with the additional feature of Skype calls management, see
below for more details on operating Celliax with headset and
microphone.

A "base station" cellular phone is connected to the computer running
Asterisk with:

  * an audiocable (that brings the audio from the headset output of
the cellphone handsfree connector to the mic input of the soundcard,
and from the speaker output of the soundcard to the mic input of the
handsfree connector of the cellphone)
  * and a datacable (that brings AT or FBUS2 commands and messages
back and forth from a serial port of the computer to the serial
connector of the cellphone).

The audio is phisycally shared between the Skype client, chan_celliax
and the cellphone because all of them use the same soundcard for input
and output (but the mic and speaker are inverted between the cellphone
and the Skype client by the audiocable. So, the Skype client sound
output originally directed to the soundcard speaker output actually
goes to the microphone input of the cellphone handsfree connector, and
viceversa). This audio sharing works with ALSA and win32 audio (for
OSS you would have to use some mixing OSS device, a la skypehijack or
oss2jack for overcoming the OSS limitation of one only program opening
a particular sound device).

An ALSA voicemodem is managed directly by celliax as an audio device,
no additional hardware required (but Skype calls are not managed with
voicemodems, because the voicemodem and the Skype client can't have
the mic and speaker inverted between them)

Usage with headset and microphone (for testing purposes)

      * put "controldevprotocol=NO_SERIAL" in configuration
      * celliax monitors the soundcard (for incoming sounds)
      * a call is activated by an incoming "ring" noise on the
soundcard (just yell in the mic)
      * during a call, you can type the "dial" and "hangup" console
commands to simulate the incoming DTMFs and hangups you would have
from a real (cell)phone call. The "console" console command is useful
if you use more than one celliax channel concurrently (requires more
than one soundcard)
      * during the call, incoming silence and DTMF tones are
recognized through dsp.c analysis
      * the caller's hangup is signaled by the "hangup" console
command or by a period of continued silence
      * if hangup is detected, or when an hang up command is
generated by the dialplan (eg. "press # to hangup"), celliax close the
call

Overview of the handling of an incoming phone call ("answer" app)

      * put "controldevprotocol=" one of AT FBUS2 ALSA_VOICEMODEM in
configuration
      * celliax monitors both the soundcard (for incoming sounds)
and the serial control device if available (for AT or FBUS2 messages)
      * an incoming call is signaled on the serial control device
("RING" on AT cellphones, proprietary Nokia hex on FBUS2 cellphones)
      * celliax wait for the caller id to be signaled on the serial
control device
      * the caller id arrives
      * on Nokia 3310 and compatibles cellphones (and with
ALSA_VOICEMODEM protocol) the incoming call is detected by the
soundcard that detects the "ring" noise (so, no caller id)
      * celliax picks up the call with serial commands to the
cellphone or with off-hook ALSA mixer command to the ALSA voicemodem
      * during the call, incoming silence and DTMF tones are
recognized through dsp.c analysis
      * the caller's hangup is signaled by incoming serial messages
or by a period of continued silence (when no serial control device is
available)
      * when remote party hangs up, or when an hang up command is
generated by the dialplan (eg. "press # to hangup"), celliax hangs up
the line with serial commands to the cellphone or "on hook" ALSA mixer
commands to ALSA voicemodems

Overview of the handling of an outgoing phone call ("dial" app)

      * put "controldevprotocol=" one of AT FBUS2 ALSA_VOICEMODEM in
configuration
      * celliax monitors both the soundcard (for incoming sounds)
and the serial control device if available (for AT or FBUS2 messages)
      * celliax place an outgoing call with serial commands to the
cellphone or (in case of ALSA_VOICEMODEM protocol) with a "off hook"
ALSA mixer command to the ALSA voicemodem, followed by the playing of
the DTMF digits on the voicemodem ALSA device
      * the remote party's hangup is signaled by incoming serial
messages or by a period of continued silence (when no serial control
device is available)
      * when remote party hangs up, or when an hang up command is
generated by the celliax user, celliax hangs up the line with serial
commands to the cellphone or "on hook" ALSA mixer commands to ALSA
voicemodems

Overview of the handling of an incoming Skype call ("skype2celliax" app)

      * put "skype=yes" in configuration
      * celliax monitors the Skype client for incoming Skype API
messages (X11 or Windows messages)
      * when an incoming Skype call is signaled by the Skype client,
if a phone call is already active on the celliax channel the Skype
call is dropped with Skype API commands to the Skype client
      * else (no phone call is active on the celliax channel) the
Skype call is accepted and picked up with Skype API commands to the
Skype client
      * celliax sets the context to "skype" and activate an
"INCOMING_RING" on the channel
      * in the "skype" context on the dialplan (extensions.conf),
following the "answer" there is the "skype2celliax" command, that
makes an outgoing cellphone call to the configured phone number
      * the Skype caller hangup is detected by incoming Skype API messages
      * when the Skype caller hangs up, or the remote phone party
hangs up, the Skype call is closed by Skype API messages and the
celliax call is hanged up

Overview of the handling of an outgoing Skype call ("celliax2skype" app)

      * put "skype=yes" in configuration
      * celliax monitors the Skype client for incoming Skype API
messages (X11 or Windows messages)
      * the application "celliax2skype" activates a Skype call to
the desired Skype user by sending Skype API messages to the Skype
client
      * the Skype caller hangup is detected by incoming Skype API messages
      * if the Skype caller hangs up the control comes back to the
dialplan, "extensions.conf", and the celliax call goes on
      * if the celliax user hangs up, the Skype call is closed by
Skype API messages and the celliax call is hanged up

Overview of the handling of the Skype Contacts Directory
("celliax_skype_directory" app)

      * put "skype=yes" in configuration
      * celliax monitors the Skype client for incoming Skype API
messages (X11 or Windows messages)
      * when the "celliax_skype_directory" application is
encountered in the dialplan, "extensions.conf", the user is presented
with an interactive dialog similar to the one presented by the
"directory" application
      * first the "celliax_skype_directory" application asks the
Skype client the list of Skype contacts via Skype API messages
      * second the "celliax_skype_directory" writes a configuration
file, "skype_dir.conf" containing the Skype contacts names as
displayed by the Skype client and the corresponding Skype user names
      * for each Skype contact, "celliax_skype_directory" adds
dinamically to the dialplan a corresponding extension in the "default"
context
      * the user is asked to insert the first three letter of the
Skype contact he wants to call, as it is displayed in the Skype client
      * after the user insert and confirm a Skype contact, the
celliax call jumps to the extension that was dinamically added to the
dialplan for that Skype contact
      * at that extension there is a "celliax2skype" application
that activates a call to the desired Skype contact

Special case: Usage for managing a cellphone without using a datacable

      * connect the "base station" cellular phone to the soundcard
through the audiocable
      * put "controldevprotocol=NO_SERIAL" in configuration
      * configure the cellphone to "automatically answer" incoming
calls ("autoanswer" is an "handsfree" feature found in most cellular
phones). With many cellphones you can configure the "autoanswer"
feature only while the handsfree (or the audiocable) is connected to
the cellphone.
      * celliax will not make outgoing cellphone calls, but will
answer incoming calls, and let you make outgoing Skype calls

Dedication

This file has been written during the last two years by Giovanni
Maruzzelli, with a lot of cut and paste from other free software
sourcecode.

This file is dedicated to the people that inspired me in Belgrade, and
particularly to Dejan Nikolic, Milka Jojic, Ivana Jelisavcic, Alexa,
to Dragan Ristic and his Rom band KAL, to SKC, to DjKC, to Taraf de
Haidouks, and more so to the beautyful dancer "bella ballerina"
Francesca Parlagreco.

To all the people that I met there, and to the ones that I will met.

To who introduced me to computers and many things, Mita Vitti, and to
who tried to teach me things he don't knows, Marco Amante.

To who pushed me to distribute it, Anna Pellizzi Moroni.

To my son Rocco Manz Maruzzelli, so patient during the long hours I
stare in some monitor.

Giovanni, Oct 22th, 2006

Credits

In this file you find the results of the work of thousands peoples,
merged here by my intensive source cut'n paste and by the use of tools
and documentation they provided, on top of which is my small
contribution.

I would like to list here the more direct ancestors, but all this is
just part of an history of collaboration and circulation of ideas,
knowledge and a donation of one's own work to the humankind that goes
back in the centuries.

First of all, Richard Stallmann and the Free Software Foundation, and
Linus Torvalds, we all know why.

Then Mark Spencer for creating the whole Asterisk Free PBX and the
chan_iax, chan_modem, chan_oss and app_directory on which this channel
is modeled after.

Steven Underwood and Jim Dixon for dsp management, DTMF and silence
detection, and for the Zapata Telephony Organization.

Kevin Fleming for all his Asterisk contributions.

Luigi Rizzo for enhanced version of chan_oss.

Matthew Fredrickson for chan_alsa.

Olle Johansson for chan_sip.

Takeshi Iwai, for ALSA code examples and tutorials.

Sasha Khapyorsky for slmodemd and ALSA modem driver.

Christopher Faylor and Corinna Vinschen for Cygwin.

Colin Peters, Jan-Jaap van der Heijden, Mumit Khan, Anders Norlander,
Earnie Boyd and Dale Handerson for Mingw, w32api, minires.

Jeff Glatt for Windows wavein waveout functions, and the wonderful
tutorial on audio programming on Windows.

Marcin Wiacek for Gammu.

Hugh Blemings and Pavel Janik for Gnokii.

Itai Nahshon for dtmf-dial.

Justin Karneges for Nokia 61xx SMS send/receive functions.

Peter Hofmann for gsmlib.

Stanislav Karchebny for the X11 Skype API examples.

The unknown (to me) person who wrote the msgapitest.cpp distributed by
Skype as an example of Windows Skype API.

......

For sure I've left out some other direct ancestor...

I would *really really* like that people that recognizes his own (or
someone else's) more or less direct contribution to this file takes
the time to made it known at www.celliax.org and be included in this
list.

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
