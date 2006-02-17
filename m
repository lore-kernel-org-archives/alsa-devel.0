From: Rimas Kudelis <rq@akl.lt>
Subject: Re: Test model
Date: Fri, 17 Feb 2006 14:07:13 +0200
Message-ID: <43F5BC71.6040404@akl.lt>
References: <200602170159.k1H1xYkI018018@auster.physics.adelaide.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200602170159.k1H1xYkI018018@auster.physics.adelaide.edu.au>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,


>> The internal microphone is connected to the "MIC1" control. And the external too.
>> The Line In jack is connected to LINE1 control.
>> Master volume seems to be controlled by LOUT1 control. By muting this, i
>> get absolute silence.

<...>

> Very interesting.  The only difference between the "line out" and "headphone"
> setting is that the latter enables an onboard amplifier which allows it
> to drive headphones to a louder volume.  On the headphones I've tried 
> you still get adequate output when the pin is "lineout" - it's just slightly
> louder when "headphone" mode is selected.

OK, then I hope it doesn't apply here, as I'm testing things with an 
external amplifier connected to big speakers.


>> Btw, when I redirect the output to Line In, and make everything else
>> (HP-OUT, LINE-OUT, LINE2 and MIC2) be "Headphone" pins, I get a lot of
>> noise from the speakers connected to the Line In jack. These seem to catch
>> some interference even from the video card (just noticed). That electronic
>> noise differs depending on what I see in the screen atm. Weird...
> 
> Which output - the headphone jack?  What kind of noise - squeals or hiss?

Hard to tell (English is not my native), but I think it's more like 
hiss. Actually, it sounds a bit similar to a TV with bad reception, 
except that in my case the noise is quiet enough.


> Not sure at this stage.  Feel free to comment out the things which touch
> node ID 0x15 and try again (after recompiling/reboot), but based on
> experience to date I don't think it will change things.  In the face of no
> other suggestions however it might be worth trying.

I don't actually understand a single line in the driver code. :)) But 
I'll try to find possible gotchas in it.


>> I'm almost out of any ideas. :/ Could it be that the notebook uses
>> digital i/o for its internal speakers/heaphone jack or something like
>> this?
> 
> That would be extremely strange - as a system designer, why require the use
> of an external DAC when you have a perfectly servieable one already in the
> laptop?
> 
> A couple of other random thoughts:
> 
>   1) You're not using a docking station, are you?

Of course I'm not. :) This laptop doesn't even have a docking station 
interface port.

>   2) Does the laptop have an external volume control?  If so, is it turned
>      up to maximum?

No, it doesn't. Just the keyboard controls that Paolo has mentioned.

BTW, could I catch you on IRC or MSN or some other real-time media? I 
hope that could make this discussion progress a little bit faster.

best regards,

Rimas



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
