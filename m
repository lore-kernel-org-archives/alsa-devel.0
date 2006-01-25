From: Arnaud Patard <apatard@mandriva.com>
Subject: Re: HDA pin sense and presence detect capability
Date: Wed, 25 Jan 2006 16:50:40 +0100
Message-ID: <m3fyncpar3.fsf@anduin.mandrakesoft.com>
References: <m3k6copbi9.fsf@anduin.mandrakesoft.com>
	<s5hu0bsb9du.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from office.mandriva.com (ezoffice.mandriva.com [84.14.106.134])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 0EB9C18F
	for <alsa-devel@alsa-project.org>; Wed, 25 Jan 2006 16:48:51 +0100 (MET)
In-Reply-To: <s5hu0bsb9du.wl%tiwai@suse.de> (Takashi Iwai's message of "Wed,
	25 Jan 2006 16:43:57 +0100")
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai <tiwai@suse.de> writes:

> At Wed, 25 Jan 2006 16:34:22 +0100,
> Arnaud Patard wrote:
>> 
>> Hi,
>> 
>> 
>> On some laptops with HDA codecs, there are different nids for the
>> Headphones and for the built-in speakers. This results in having sound
>> on speakers and on headphones at the same time. imho, the expected
>> behaviour is to have sound only on headphones (without having to play
>> with the mixer).
>> 
>> This can be achieve with the presence detect capability (0x709,0xf09): When
>> plug/unplugging the headphones, one gets an unsollicited responsed and
>> the driver mute the channels.
>> 
>> Is there something to do that in the code or should I go and code it ?
>> Any opinion/comments about that ?
>
> You can find an example of such unsolicited event in
> patch_sigmatel.c.

okay. Thanks. 

About what's done in patch_sigmatel.c : what's the point of disabling
the output ? imho, you only need to mute the nid. 

Also, if there are several users of similar functions and on others chips than
sigmatel, shouldn't it be better to put something in hda_codec.c ?


Regards,
Arnaud

>
>
> Takashi



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
