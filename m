From: Florian Winter <fw@motama.com>
Subject: Volume Control in ALSA
Date: Sat, 15 Jul 2006 10:44:09 +0200
Message-ID: <44B8AAD9.6080302@motama.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

hi,

I am trying to implement simple volume control using the ALSA library, 
and I must say I am totally confused about the many different mixer 
interfaces that exist in the ALSA library and of which none seems to be 
properly documented. The only functions I found that seem to be supposed 
to do what I want are

    snd_mixer_selem_set_playback_volume_all
    snd_mixer_selem_set_playback_dB_all

I have successfully opened the mixer interface and found a suitable 
mixer element. I am even able to set the output volume using 
snd_mixer_selem_set_playback_volume_all. unfortunately, the behaviour of 
this function seems to be non-linear, and the documentation says nothing 
about the meaning of the "value" I pass to the function:

> *Parameters:*
>
>     	/elem/  	Mixer simple element handle
>
>     	/value/  	control value
>
(from 
http://www.alsa-project.org/alsa-doc/alsa-lib/mixer_2simple_8c.html#a21)

If I control the volume in alsamixer or kmix, the slider also seems to 
behave non-linear. If I set it to 50% of the maximum position, I can 
hardly hear any sound. Also, if I turn the value on my output device to 
50%, the result is much louder than what I get by setting the value to 
"50%" in ALSA.

It is a requirement in my application that the behaviour of the volume 
control is well-defined. I want both linear volume control and 
logarithmic volume vontrol in decibels. So I tried to use the 
snd_mixer_selem_set_playback_dB_all function. Unfortunately, this 
function doesn't seem to be defined in the ALSA headers. Instead I found 
a function with a similar name which is not documented, but whose name 
and signature suggests that it is what I need:

int snd_mixer_selem_set_playback_volume_dB(snd_mixer_elem_t *elem, long 
value, int dir);

However, if I use this function, I get an undefined symbol error at 
link-time.
(i.e. the function is not even defined in the ALSA library?!)

I also tried to install the newest ALSA headers and libraries from 
source (version 1.0.12rc1). My application compiled and linked fine, but 
setting the volume using snd_mixer_selem_set_playback_dB_all failed with 
snd_strerror returning "No such device or address", probably because the 
driver doesn't support the new interface

fw@magmell:~$ cat /proc/asound/version
Advanced Linux Sound Architecture Driver Version 1.0.9 (Sun May 29 
07:31:02 2005 UTC).

So my question is:

Is there a function to set the playback volume of a mixer element in a 
well-defined way using version 1.0.9 of the ALSA library?
By well-defined, I mean: The behaviour of the volume control must be the 
same on all cards. I must be able to set the volume to, say, "50% of the 
maximum volume" or "-6 dB". Whether the interface accepts linear values 
or decibels doesn't matter. Accuracy also is not an issue. But the scale 
and units should be documented and unified (i.e. independent of the 
hardware and driver).

Is there such a function in ALSA 1.0.9? What is the name of this 
function and where is it documented? Otherwise, are there functions that 
I can use to determine what kind of values 
snd_mixer_selem_set_playback_volume_all accepts? (i.e. 
logarithmic/linear, minimum and maximum value, scale?)

Thanks in advance.

-- 
Florian Winter
Software developer
Motama GmbH
http://www.motama.com



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
