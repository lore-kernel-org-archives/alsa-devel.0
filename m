From: Peter Heatwole <peter599@gotnet.net>
Subject: Re: cs46xx experimental DSP drivers
Date: Tue, 24 Sep 2002 23:41:51 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020925064151.GC781@porky>
References: <3D8F7F59.6030105@prism.gatech.edu> <3D90A8D8.7070103@cucumelo.org> <3D90B54F.20402@prism.gatech.edu> <3D90D641.7050200@cucumelo.org> <20020925010806.GA4779@porky>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20020925010806.GA4779@porky>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: gorm@cucumelo.org
List-Id: alsa-devel@alsa-project.org

On 2002.09.24 18:08 Peter Heatwole wrote:
> 
> 
>    Booyah!   Just got digital out working properly on my Santa Cruz, and 
> it
> sounds great. I just needed to unmute "EGPIO In" and "IEC 958 Output".


    My apologies, I was rushed for a meeting and had to fire that e-mail 
off
in a hurry. (Not to mention I was elated to have digital output)
    To be more precise, here is the information I've collected.

    I've double checked, and from a fresh module insertion, I need to 
unmute
"EGPIO Input/Output" (therby setting bit one in BA0_EGPIODR), and unmute
"IEC 958 Output". Then coaxial digital out functions properly on my TB 
Santa
Cruz.
    Benny: what needs to be done so that the proper BA0_EGPIODR bits are 
set
to input or output when the user uses the "IEC 958 Input" and "IEC 958
Output" sliders? In other words, how could using the "IEC 958 Input" and
"IEC 958 Output" sliders properly set the BA0_EGPIODR bits? Also, can the
Game Theater have both optical in/out, and coaxial in/out simultaneously?

    On a side note, I noticed that the chip retains certain register 
values.
When I re-tested my instructions, I noticed that "EGPIO Input/Output" would
retain it's value after reloading the snd-cs46xx module. Just a heads up in
case you hadn't noticed this. It confused me for a minute, since I couldn't
understand why simply unmuting "IEC 958 Output" worked now, whereas earlier
it did not.

I hope all that makes sense. =o)

-- Peter Heatwole
"Murphy was just a well known pessimist."


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
