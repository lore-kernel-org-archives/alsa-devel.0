From: "Rui Nuno Capela" <rncbc@rncbc.org>
Subject: Re: [PATCH]snd-usb-usx2y 0.7.1 against cvs head:      
              please test it!
Date: Wed, 14 Jul 2004 22:23:20 +0100 (WEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <32795.192.168.1.5.1089840200.squirrel@192.168.1.5>
References: <s5h1xjeaat2.wl@alsa2.suse.de> <2606.1089819200@www56.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <2606.1089819200@www56.gmx.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Martin Langer <martin-langer@gmx.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net, annabellesgarden@yahoo.de, ws@seh.de
List-Id: alsa-devel@alsa-project.org

> Martin Langer wrote:
>> Rui Nuno Capela wrote:
>>> Takashi Iwai wrote:
>>>> Rui Nuno Capela wrote:
>>>>>
>>>>> Erm... I get the following while modprobing snd-usb-usx2y:
>>>>>
>>>>> WARNING: Error inserting snd_hwdep
>>>>> (/lib/modules/2.6.7-cko6.0smp/kernel/sound/acore/snd-hwdep.ko):
>>>>> Unknown symbol in module, or unknown parameter (see dmesg)
>>>>> FATAL: Error inserting snd_usb_usx2y
>>>>> (/lib/modules/2.6.7-cko6.0smp/kernel/sound/snd-usb-usx2y.ko):
>>>>> Unknown symbol in module, or unknown parameter (see dmesg)
>>>>>
>>>>> Then the relevant dmesg says:
>>>>>
>>>>> snd_hwdep: Unknown symbol snd_kcalloc
>>>>> snd_usb_usx2y: Unknown symbol snd_hwdep_new
>>>>
>>>> Did you run cvscompile?  configure script must be regenerated.
>>>>
>>>>
>>>
>>> Yes, I've ran ./cvscompile. My steps were just the following:
>>>
>>>   cvs co alsa-kernel
>>>   cvs co alsa-driver
>>>   cd alsa-driver
>>>   export ALSAKERNELDIR=../alsa-kernel
>>>   ./cvscompile
>>>   su -c "make install"
>>>
>>> Something wrong?
>>
>> Should be ok.
>>
>> snd_kcalloc() is an obsolete function which was replaced recently with
>> kcalloc().  I guess the modules are not installed correctly, or the
>> detection of the kernel verion was wrong.
>>
>
> Checkout alsa-tools and rebuild your usx2yloader
>

OK. It was something I've screwed up. A second 'make install' and
everything is up and running on my US-224, at least as it was before.

JACK seems to work fine, and MIDI also gets it thru. So chalk one for
US-224 and 2.6.7-cko6.

Anything I should check deeper?
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
