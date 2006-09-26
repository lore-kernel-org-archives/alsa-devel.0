From: Michael Clark <michael@metaparadigm.com>
Subject: Re: 2.6.18: hda_intel: azx_get_response timeout,
 switching to single_cmd mode...
Date: Tue, 26 Sep 2006 09:12:03 +0800
Message-ID: <45187E63.3020200@metaparadigm.com>
References: <451834D0.40304@goop.org> <20060925202644.GB6278@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from gort.metaparadigm.com (gort.metaparadigm.com [203.117.131.12])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 8A0EA197
	for <alsa-devel@alsa-project.org>;
	Tue, 26 Sep 2006 03:12:14 +0200 (MEST)
In-Reply-To: <20060925202644.GB6278@ucw.cz>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Pavel Machek <pavel@suse.cz>, Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Takashi Iwai <tiwai@suse.de>, Andrew Morton <akpm@osdl.org>, alsa-devel@alsa-project.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Pavel Machek wrote:
> Hi!
>
>   
>> I have a ThinkPad X60 which uses the Intel 82801G HDA 
>> audio chip.  This used to work for me, but lately 
>> (sometime during 2.6.18-rcX series) it stopped working - 
>> programs trying to use it tend to just block forever 
>> waiting for /dev/dsp.
>>     
>
> I have x60 here,
>
>   
>> The only obvious symptom is:
>>
>>    hda_intel: azx_get_response timeout, switching to 
>>    single_cmd mode...
>>
>>     

I got similar kernel message relating to an azx_get_response timeout
with an 82801G HDA audio running Debian kernel 2.6.16-2 (happened during
suspend to ram IIRC) - after replacing kernel alsa with alsa-source
1.0.12 (24 Aug release) the problem went away (in addition to making
sound come out when it didn't before).

Not sure if this info helps but trying the alsa-project release and
seeing if that works may help identify what needs fixing in mainline
hda_intel.

~mc

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
