From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: [RFC] TLV entry for linear volume
Date: Wed, 23 Aug 2006 19:22:37 +0100
Message-ID: <44EC9CED.8040408@superbug.co.uk>
References: <s5h8xlfzhhu.wl%tiwai@suse.de>	<44EC6F16.6090807@superbug.co.uk>	<s5hhd03xydd.wl%tiwai@suse.de>
	<s5hwt8zwf96.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hwt8zwf96.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Wed, 23 Aug 2006 17:31:10 +0200,
> I wrote:
>   
>>> So, 0 dB is when (volume - rec->min) / (max - min) == 1
>>> So, for +6 dB gain, the volume will need to be higher than max?
>>> Does this sound right? In that case, maybe "max" is not a good name for 
>>> it because volume can be greater than max.
>>>       
>> Hm, right, I didn't think of overload case with a linear volume
>> codec.  By min and max, I thought of a "segment" between mute and
>> 0dB (although not implemented rightly in alsa-lib).
>>
>> Maybe min and max should be in (0.01) dB expressions since the min and
>> max "values" are known from snd_ctl_elem_info.  The only problem is
>> that we have no standard definition of "mute" in dB expression.
>> In alsa-lib, -9999999 indicates mute.  But it should be defined as a
>> constant in a public header.
>>     
>
> It turned out that minimal dB makes the computation too complicated,
> and chips are very likely from mute to a certain dB.  So, I decided to
> drop the min dB there.
>
> The below are the revised patches.
>
>
> Takashi
>   
I think you will find that your second approach is still wrong.
You need to first identify the 0dB point, and then the scale factor and 
offset value for the linear component before the log10 conversion.
So, linear to log should be something like:
20log10 ((linear / scale) - offset)
I.e. the offset taken before the log10 operation, not afterwards as is 
shown in your code:
*db_gain = (long)(100.0 * 20.0 *
                      log10((double)(volume - rec->min) /
                        (double)(rec->max - rec->min)));
*db_gain += maxdb;

Then check the equation by finding the linear value that equates to:
0dB, so that ((linear / scale) - offset) == 1 * original signal voltage
6dB, so that ((linear / scale) - offset) == 2 * original signal voltage
-6dB, so that ((linear / scale) - offset) == 0.5 * original signal voltage

This is assuming that the linear values affect the voltage, and not the 
power.

So, you need to pass from driver to userspace the value of "scale" and 
"offset", together with maybe one bit to identify if the minimum value 
of the "linear" is mute or not.

James


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
