From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: Which API for MIDI?
Date: Wed, 10 Dec 2003 09:50:32 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200312101450.hBAEoXeN019193@oud.linuxaudiosystems.com>
References: <Pine.HPX.4.33n.0312101523590.776-100000@studcom.urz.uni-halle.de>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Wed, 10 Dec 2003 15:26:43 +0100."
             <Pine.HPX.4.33n.0312101523590.776-100000@studcom.urz.uni-halle.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Tim Goetze <tim@quitte.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>Tim Goetze wrote:
>> * what kind(s) of sync-to-external will you need?
>> * do you want to receive/send MIDI sysex data?
>>
>> last time i checked, the latter was impossible to do via the sequencer
>> API (please correct if things have changed).
>
>Sending/receiving sysex has always been possible AFAIK.  It's
>certainly possible now.

its bounded by size limits that have to (re)set in advance. when i
tried to download new firmware (1MB+) via SYSEX to an Alesis ADAT, it
was very difficult to discover this limitation.


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
