From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: List of control parameters needed
Date: Mon, 22 Mar 2004 12:19:04 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200403221719.i2MHJ4w6000838@dhin.linuxaudiosystems.com>
References: <405F053D.2040801@superbug.demon.co.uk>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Mon, 22 Mar 2004 15:24:45 GMT."
             <405F053D.2040801@superbug.demon.co.uk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: pavans@india.ti.com, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>> Where can I get the complete list of controls which an audio codec has to
>> support.

there is no such list.

and lets get the terminology straightened out here before this goes
any further.

"codec" comes (in this context) from "coder/decoder". that maps
roughly to what is more properly referred to as an analog-to-digital
or digital-to-analog converter (or both). these days, it could also
include devices that convert from one digital format (e.g. ADAT
LightPipe) to another (e.g. S/PDIF or T/DIF). 

thus, the list you offered actually to do with audio codecs, but is in
fact a description of the types of controls you might find on a
*mixer*.

however, given that there are cards without a mixer at all, plus cards
with radically different mixer designs, plus cards with extremely
simple mixers plus cards with extremely complex designs, there cannot
be a list of controls that any mixer will support. Even the idea of a
microphone input is h/w specific, as is the idea of a master volume
control. 

the best you could probably hope for is to first see if the mixer you
have has support for a "standard mixer API", then use that API. but no
such API exists at this time, and you would still have to have a
fallback position if you are using h/w that has no mixer or a mixer
than cannot support a "standard mixer API".

--p


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
