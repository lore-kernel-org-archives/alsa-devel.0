From: Benny Sjostrand <gorm@cucumelo.org>
Subject: Re: cs46xx experimental DSP drivers
Date: Wed, 25 Sep 2002 07:40:56 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D914C68.7010401@cucumelo.org>
References: <3D8F7F59.6030105@prism.gatech.edu> <3D90A8D8.7070103@cucumelo.org> <3D90B54F.20402@prism.gatech.edu> <3D90D641.7050200@cucumelo.org> <3D90FEF4.2040309@prism.gatech.edu> <20020925010013.GC990@porky> <3D911550.1000309@prism.gatech.edu> <20020925020343.GC4779@porky>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Peter Heatwole <peter599@gotnet.net>
Cc: Weijia Yang <gte733z@prism.gatech.edu>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>    I suppose so. I just leave an MP3 playing in XMMS, and restart it 
> after
> making a change (though this isn't required for all changes; I'm just
> cautious).
>    I _think_ you modify each pin using the "EGPIO On/Off" to turn each 
> pin
> on and off, and select the different pins using "EGPIO select".
>    When I have more time I will try to learn more about this, and may be
> able to help more.
>
And "EGPIO In/Out" controls to use pin as input or output,
"EGPIO CMOS/Open drain", control if the pin use active CMOS
levels, or open drain. If think "Open drain" is like open collector, the
pin is floating when it's active, it needs a pull-up resistor or 
something, well,
just copied the text from the datasheet.

Playing with the EGPIO is very experimental and the consequences
can be _any_, but hope that you already knows that -;)

/Benny




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
