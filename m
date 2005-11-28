From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: Where to put code for a new ioctl.
Date: Mon, 28 Nov 2005 18:56:27 +0000
Message-ID: <438B52DB.4070606@superbug.co.uk>
References: <4389943D.20100@superbug.co.uk> <s5hoe45knec.wl%tiwai@suse.de> <Pine.LNX.4.61.0511281251250.9343@tm8103.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.61.0511281251250.9343@tm8103.perex-int.cz>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela wrote:
> 
> It's used for the simple mixer implementation to cache the control 
> elements. Yes, the structure might look as complicated, but the mixer is 
> complicated. So the structure is:
> 
> 1) control - raw control API access
> 2) hcontrol - cached control API access, fast lookups etc...
> 3) mixer - mixer API
>    3a) mixer simple none
>    3b) mixer simple abstract
> 
> 
>>BTW, James, please remember that you need a new ioctl just for limited
>>drivers.  For dB conversion, only usb-audio, hda-codec and possibly
>>emu10k1 (for user-space controls) would use this ioctl.  The other
>>drivers don't need this ioctl at all - in other words, the dB
>>conversion table shouldn't be implemented on the kernel space but on
>>user space.
> 
> 
> I 100% agree here. The new ioctl will fail or don't give dB info for most 
> drivers. The possibility is to emulate the ioctl in control.c for rest 
> hardware (probably it's the most easy solution), or leave it to 3b) mixer 
> simple abstract layer. 
> 
> 						Jaroslav
> 

It's alright saying that, but when you come to implement it, you have 
problems.
My aim is this:
1) user app calls snd_mixer_selem_get_playback_dB()
2) alsa-lib retrieves the current value from 
snd_mixer_selem_get_playback_volume()
3) alsa-lib makes a call that returns details of a conversion function 
parameters. (e.g. function type, offset, multiplier, divisor). I am 
intending the function type to be a simple integer index, so that 
alsa-lib know which pre-defined function to use.
4) alsa-lib does the conversion. Example function type: 
dB_gain=(((volume-offset)*multiplier*100)/divisor);
5) alsa-lib returns the dB value to the user app.

The problem is (3).
The low level kernel driver registered the volume control, so only the 
low level driver will actually know what dB scale to apply to it.

I am therefore implementing an ioctl to handle (3) in control.c.
Any low level driver not implementing this ioctl will simply result in 
dB values not being shown in the alsamixer. i.e. current behavior.

(3) can be implemented in a number of different ways. I am intending to 
implement it in as flexible way as possible using TLVs.

The entire list of all function and parameters could all be in alsa-lib 
space, but there is still the requirement for the low level kernel 
driver to select which function, from the list, a particular control 
should use.

I can't see step (3) being achievable without a ioctl.

James


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
