From: Pieter Palmers <pieter.palmers@student.kuleuven.ac.be>
Subject: building a mixer
Date: Tue, 28 Jan 2003 00:45:55 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E35C4B3.5000004@student.kuleuven.ac.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi all,

is it possible to support multiple mixers in one card?
I have the following situation:
The card consists of a Maestro2E PCI controller with AC97 codec. On the 
expansion port of the maestro is a SAM9707 device. I'd like separate 
mixers for the AC97 and the SAM, because the control names can be very 
confusing otherwise (i.e. Master volume of Codec does not change Master 
volume of any SAM output).
The card is routed pretty strange: the 2channel codec output is 
re-sampled and this digital signal is fed into the SAM device for 
further processing. From it can be output to 2 stereo pairs of outputs 
(ie 4 mono). But there are also 6 other mono inputs that are routed 
directly to the SAM device, and can be HW monitored on the SAM's outputs.

To make things even more complex: the digital stereo signal is 
multiplexed with an SPDIF input and two other mono inputs. You can 
choose which one you want (only one).

I'd like the codec mixer separate from the other controls, as this 
reflects internal structure best. Apart from that, the codec controls 
are rarely used, because I always use the SAM channels which are better 
quality.

Thanks,

Pieter



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
