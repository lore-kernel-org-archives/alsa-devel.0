From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: How to put 16bit none audio PCM data stream into a 32bit none audio S/P-DIF transport stream?
Date: Tue, 08 Apr 2003 10:28:09 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E192u0x-0007pF-00@sc8-sf-list1.sourceforge.net>
References: <20030408140230.GA1987@ulima.unil.ch>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Tue, 08 Apr 2003 16:02:30 +0200."
             <20030408140230.GA1987@ulima.unil.ch>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Gregoire Favre <greg@ulima.unil.ch>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>I have an AC3 receiver which uses the bit flags of the S/P-DIF transport
>stream for identifying none audio, and I use the cs46xx driver for my
>Hercules Digifire 7.1 (under windows, using the included DVD player I
>could have a real 5.1).
>
>Under linux using ALSA, all I get is a cliking sound... does anyone know
>how I could solve this (without changing my hardware of course)?
>
>I have looked at the source, but it's far too complicated for me...

define a new plughw PCM device in ~/.asoundrc, and use
that. unfortunately, i don't know how to do that, i just know that you
can do it.

--p


-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
