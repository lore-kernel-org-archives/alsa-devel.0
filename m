From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Please do not release ALSA 0.9.0 final yet
Date: Tue, 11 Mar 2003 19:30:57 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0303111929130.1352-100000@pnote.perex-int.cz>
References: <200303111800.SAA05928@koyuki.liam2.demon.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200303111800.SAA05928@koyuki.liam2.demon.co.uk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Will <walsac@liam2.demon.co.uk>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>, "tiwai@suse.de" <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

On Tue, 11 Mar 2003, Will wrote:

> Jaroslav and Iwai,
> 
> I would really like to know your thoughts on the bug I highlighted
> in my earlier messages.  Have either of you got a MIDI keyboard so you
> can verify the bug?  If not, is there anyone at Suse or locally
> who might consider lending you a MIDI keyboard?
> 
> I'm sorry to go on about this but this bug has not been addressed
> for months yet aim #5 of the Alsa Project is to give
> "support for the older OSS API, providing binary compatibility
> for most OSS programs."

I'm working on it. I solved the "timestamp" problem (/dev/sequencer MIDI 
input) and the reset problem for /dev/sequencer. I'm going to test the 
"output silence" problem ASAP.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
