From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: RME Hammerfall HDSP 9652: no configurations available
Date: Sat, 19 Jul 2003 13:06:00 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E19dv4a-0001hF-00@sc8-sf-list1.sourceforge.net>
References: <1085.62.39.221.155.1058599502.squirrel@www.undata.org>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Sat, 19 Jul 2003 09:25:02 +0200."
             <1085.62.39.221.155.1058599502.squirrel@www.undata.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Thomas Charbonnel <thomas@undata.org>
Cc: torger@ludd.luth.se, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>>
>> I'm trying out the HDSP driver from CVS (checked out today), on a RME
>> HDSP 9652 PCI card, but I don't manage to get it to run, with my basic
>> test
>>
>> # aplay -D hw -f S32_LE -c 26 -r 48000 /dev/zero
>>
>> Playing raw data '/dev/zero' : Signed 32 bit Little Endian, Rate 48000
>> Hz, Channels 26
>> aplay: set_params:787: Broken configuration for this PCM: no
>> configurations available
>>
>> The firmware is loaded using hdsploader. Running aplay on another sound
>> card on the machine works.
>>
>
>Note you don't need to run hdsploader with hdsp9652 cards.

why don't you just try it with plughw rather than hw. i'm not sure
that what aplay tries to do with the configuration you've attempted to
provide is actually correct.



-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines at the
same time. Free trial click here: http://www.vmware.com/wl/offer/345/0
