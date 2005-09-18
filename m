From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: Best default values for "External Amplifier" and
 "Audigy Analog/Digital Output Jack"
Date: Sun, 18 Sep 2005 12:44:18 +0100
Message-ID: <432D5312.1000506@superbug.co.uk>
References: <432D290E.4010506@yahoo.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <432D290E.4010506@yahoo.co.uk>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Thomas Hood <jdthood@yahoo.co.uk>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Thomas Hood wrote:
> Hello.  I am one of those responsible for packaging ALSA for Debian.
> 
> Does anyone have documentation of which machines require "External Amplifier"
> to be on and which ones require EA to be off in order for sound to be emitted
> in the simplest or most common machine configuration?
> 
> I have the same question about the "Audigy Analog/Digital Output Jack".
> 
> In Debian and Ubuntu we get complaints from users that sound "doesn't
> work".  After some investigation it turns out that either EA or
> AADOJ is set incorrectly.  Unlike other controls, it seems that there
> is no one setting for these that is a "sane" value for all machines.  So
> it seems that when our script is asked to set sane values, the script
> will have to choose a value depending on the computer model.  But we have no
> list of which models require the one setting and which models require the
> other.  We thought that perhaps the ALSA developers have such a list.
> 
> What we would actually prefer is that the driver do this work and initialize
> EA and AADOJ to "sane" values---if necessary depending on the computer model.

Thomas,

There is no real answer to your question. All motherboards and sound 
cards that might contain the same sound chips, do not have the same 
connections with the outside world. So, for some, setting EA to 1 
enables sound, for others setting EA to 0 enables sound etc.
The only way we can overcome this is on a case by case basis. We add 
code to the driver so that it recognises a particular motherboard, and 
set it correctly for that particular motherboard.
So, the best way to fix this problem will be to raise an ALSA bug on 
https://bugtrack.alsa-project.org/alsa-bug/ or on the kernel bug tracker 
with full details of the motherboard and the sound chips involved, and 
it will eventually be fixed.

We would need the following:
The default settings, when not working:
amixer contents
cat /proc/asound/card0/codec97#0/ac97#0-0
cat /proc/asound/card0/codec97#0/ac97#0-0+regs

The settings when working correctly:
amixer contents
cat /proc/asound/card0/codec97#0/ac97#0-0
cat /proc/asound/card0/codec97#0/ac97#0-0+regs
lspci -vvn

James


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
