From: Joe Hsu <nagual.hsu@gmail.com>
Subject: Re: About bt87x
Date: Wed, 9 Mar 2005 21:49:30 +0800
Message-ID: <7fe205990503090549110ed799@mail.gmail.com>
References: <7fe20599050309030051e073c3@mail.gmail.com>
	 <Pine.HPX.4.33n.0503091305480.12279-100000@studcom.urz.uni-halle.de>
Reply-To: Joe Hsu <nagual.hsu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
In-Reply-To: <Pine.HPX.4.33n.0503091305480.12279-100000@studcom.urz.uni-halle.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, 9 Mar 2005 13:13:21 +0100 (MET), Clemens Ladisch
<clemens@ladisch.de> wrote:
> > And then I changed the value of GPIO_DMA_CTL register as I did in
> > the btaudio module. Well, it worked in slow motion when I played
> > the captured pcm data.
> 
> This indicates that the actual sample rate is higher than 8 kHz.  Or
> probably some stereo/mono mismatch.
> 
> Could you please post your changes to btaudio.c?
> 
> Regards,
> Clemens
> 
> 

btaudio.c is version 0.6 for linux kernel 2.4.x
btaudio2.c is the modified version
btaudio.diff is the difference of btaudio.c and btaudio2.c

When I use btaudio2.c as the btaudio.o module, I load it with 
"insmod btaudio.o analog=0  digital=1 rate=8000".

http://bill-goldberg.myweb.hinet.net/btaudio.c
http://bill-goldberg.myweb.hinet.net/btaudio2.c
http://bill-goldberg.myweb.hinet.net/btaudio.diff


-- 
The sun is shinny but the ice is slippery.


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
