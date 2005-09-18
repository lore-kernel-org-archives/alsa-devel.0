From: Thomas Hood <jdthood@yahoo.co.uk>
Subject: Best default values for "External Amplifier" and "Audigy Analog/Digital
 Output Jack"
Date: Sun, 18 Sep 2005 10:45:02 +0200
Message-ID: <432D290E.4010506@yahoo.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
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

Hello.  I am one of those responsible for packaging ALSA for Debian.

Does anyone have documentation of which machines require "External Amplifier"
to be on and which ones require EA to be off in order for sound to be emitted
in the simplest or most common machine configuration?

I have the same question about the "Audigy Analog/Digital Output Jack".

In Debian and Ubuntu we get complaints from users that sound "doesn't
work".  After some investigation it turns out that either EA or
AADOJ is set incorrectly.  Unlike other controls, it seems that there
is no one setting for these that is a "sane" value for all machines.  So
it seems that when our script is asked to set sane values, the script
will have to choose a value depending on the computer model.  But we have no
list of which models require the one setting and which models require the
other.  We thought that perhaps the ALSA developers have such a list.

What we would actually prefer is that the driver do this work and initialize
EA and AADOJ to "sane" values---if necessary depending on the computer model.
-- 
Thomas Hood


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
