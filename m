From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Analog/Digital Output Jack [Off]
Date: Wed, 23 Jun 2004 14:57:09 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <40D98C35.6010903@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
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

Analog/Digital Output Jack [Off] ??

What does [On/Off] mean here?

I think it would be better if we changed this control from an on/off 
switch to an enum. So, instead of the two options being:
1) Analog/Digital Output Jack
2) Analog/Digital Output Jack [Off]

the options would be:
1) Analog
2) Digital

It would use a method similar to the current "Mic Select" and "Mono 
Output Select"

I think this would make things clearer for the user.

I will make this change to my AudigyLS driver, but it would make sense 
to make the same change to all sound cards that implement the 
"Analog/Digital Output Jack". e.g. SB Live, SB Audigy, emu10k1x etc.

Comments ?

James


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
