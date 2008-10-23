From: Oliver Ford <ipaqlinux@oliford.co.uk>
Subject: Re: Problem setting mixer switch with amixer/alsactl.
Date: Thu, 23 Oct 2008 15:07:25 +0100
Message-ID: <4900851D.2050001@oliford.co.uk>
References: <48FF7538.3090000@oliford.co.uk>
	<20081022205729.GD7537@sirena.org.uk>
	<48FFAFB1.1090106@oliford.co.uk>
	<20081023140015.GA17901@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0.thdo.woaf.net (dog.thdo.woaf.net [213.230.192.130])
	by alsa0.perex.cz (Postfix) with ESMTP id 81ED7103875
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Oct 2008 16:07:52 +0200 (CEST)
In-Reply-To: <20081023140015.GA17901@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
> OK, thanks.  I've had a brief look at this here but so far as I can tell
> I'm not able to see these problems on my system.  I am using a
> completely different machine, though, with different hardware and I
> haven't checked through your configuration in detail.  I'll have a more
> detailed look early next week.
>
>   
Ok, thanks. I'll keep poking around and see if I can find anything.
>> No unusual dmesg output, the apps think nothing is wrong.
>> It seems that just the offending control (or the actual DACL/R -> SPKMIX
>> mixer channel) stops working. I can still get audio through the
>>     
>
> but only via amixer, yes?
>   
Yes, It only stops working when the mixer switch is changed with amixer.
> One other thing that would be useful would be to put trace which logs
> the register writes in ac97_write() in the driver and then try testing
> both using alsamixer and then amixer to do the final enable of the
> Speaker Mixer PCM Playback Switch.
>   
I already have the register writes outputted, I'll compare the logs tonight.
>
>> 		name 'Speaker Playback Volume'
>> 		value 1
>> 	}
>>     
>
> That's rather low...
>   
Yes it is, well spotted, I look at that tonight as well.

Thanks for the help,

Oliver
